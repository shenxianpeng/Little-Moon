import Foundation
import AVFoundation
import Combine

struct SeededGenerator: RandomNumberGenerator {
    private var state: UInt64 = 0x123456789ABCDEF
    mutating func next() -> UInt64 {
        state &+= 0x9E3779B97F4A7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58476D1CE4E5B9
        z = (z ^ (z >> 27)) &* 0x94D049BB133111EB
        return z ^ (z >> 31)
    }
    mutating func nextFloat() -> Float { Float(next() % 10_000) / 5_000.0 - 1.0 }
}

final class NoisePlayer: ObservableObject {
    private let lastSoundKey = "last_sound_selection"

    @Published private(set) var isPlaying: Bool = false
    @Published private(set) var currentSound: SoundItem? = nil

    var lastSelectedSound: SoundItem? {
        if let raw = UserDefaults.standard.string(forKey: lastSoundKey) {
            return SoundItem(rawValue: raw)
        }
        return nil
    }

    private let engine = AVAudioEngine()
    private let player = AVAudioPlayerNode()
    private let mixer = AVAudioMixerNode()
    private var targetVolume: Float = 1.0
    private var fadeTimer: Timer?

    @Published var volume: Float = 1.0 {
        didSet { mixer.outputVolume = max(0.0, min(volume, 1.0)) }
    }

    private var audioFile: AVAudioFile?
    private var sourceNode: AVAudioSourceNode?
    private var phase: Float = 0 // for ocean LFO
    private var rng = SeededGenerator()

    private var timer: Timer?
    private var timerEndDate: Date?

    private var cancellables = Set<AnyCancellable>()

    init() {
        setupAudioSession()
        engine.attach(player)
        let mainMixer = engine.mainMixerNode
        engine.attach(mixer)
        engine.connect(player, to: mixer, format: nil)
        engine.connect(mixer, to: mainMixer, format: nil)
        mixer.outputVolume = 0.0
        self.volume = 1.0
        try? engine.start()
        
        // Preload last selected sound (no auto-play)
        if let last = lastSelectedSound {
            currentSound = last
        }
    }

    func play(sound: SoundItem) {
        stopInternal(resetTimer: false)
        currentSound = sound
        UserDefaults.standard.set(sound.rawValue, forKey: lastSoundKey)

        if let url = sound.url, let file = try? AVAudioFile(forReading: url) {
            self.audioFile = file
            
            // Ensure source node is removed and player is connected
            if let node = sourceNode {
                engine.detach(node)
                sourceNode = nil
            }
            engine.connect(player, to: mixer, format: nil)
            
            player.scheduleFile(file, at: nil, completionHandler: scheduleLoop)
            if !engine.isRunning { try? engine.start() }
            mixer.outputVolume = 0.0
            player.play()
            isPlaying = true
            fadeIn(duration: 1.2)
            return
        }

        // Fallback: synthesized source
        startSynthesis(for: sound)
        if !engine.isRunning { try? engine.start() }
        mixer.outputVolume = 0.0
        isPlaying = true
        fadeIn(duration: 1.2)
    }

    private func startSynthesis(for sound: SoundItem) {
        // Disconnect and remove previous source node if any
        if let node = sourceNode {
            engine.disconnectNodeOutput(node)
            engine.detach(node)
            sourceNode = nil
        }
        
        // Disconnect player node to avoid conflicts
        engine.disconnectNodeOutput(player)
        
        // Create format matching the engine's output
        let sampleRate = engine.outputNode.outputFormat(forBus: 0).sampleRate
        let format = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 2)!
        
        // Capture necessary state for the closure
        var localRNG = rng
        var localPhase: Float = 0
        var previousSample: Float = 0
        
        let node = AVAudioSourceNode(format: format) { _, _, frameCount, audioBufferList -> OSStatus in
            let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
            for frame in 0..<Int(frameCount) {
                let sample: Float
                switch sound {
                case .whiteNoise:
                    sample = localRNG.nextFloat() * 0.25 // softer
                case .oceanWaves, .sea:
                    // slow sine LFO modulating noise to mimic waves
                    localPhase += Float(2 * Double.pi) * 0.2 / Float(sampleRate) // ~0.2 Hz
                    let lfo = (sinf(localPhase) + 1) * 0.5 // 0..1
                    sample = localRNG.nextFloat() * (0.12 + 0.18 * lfo)
                }
                // Write to all channels
                for buffer in ablPointer {
                    let ptr = buffer.mData!.assumingMemoryBound(to: Float.self)
                    ptr[frame] = sample
                }
            }
            return noErr
        }
        
        sourceNode = node
        engine.attach(node)
        engine.connect(node, to: mixer, format: format)
    }

    private func scheduleLoop() {
        // Re-schedule for looping
        guard let file = audioFile else { return }
        player.scheduleFile(file, at: nil, completionHandler: scheduleLoop)
    }

    func pause() {
        fadeTimer?.invalidate()
        player.pause()
        isPlaying = false
    }

    func stop() {
        fadeTimer?.invalidate()
        let currentVol = mixer.outputVolume
        if currentVol > 0.05 {
            fadeOutAndStop(duration: 1.0)
        } else {
            stopInternal(resetTimer: true)
        }
    }

    private func stopInternal(resetTimer: Bool) {
        fadeTimer?.invalidate()
        player.stop()
        if let node = sourceNode {
            engine.disconnectNodeOutput(node)
            engine.detach(node)
            sourceNode = nil
        }
        mixer.outputVolume = 0.0
        isPlaying = false
        currentSound = nil
        if resetTimer {
            timer?.invalidate()
            timer = nil
            timerEndDate = nil
        }
    }

    func startSleepTimer(minutes: Int) {
        timer?.invalidate()
        guard minutes > 0 else { return }
        let end = Date().addingTimeInterval(TimeInterval(minutes * 60))
        timerEndDate = end
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] t in
            guard let self = self else { return }
            if let endDate = self.timerEndDate, Date() >= endDate {
                self.stop()
                t.invalidate()
            } else {
                self.objectWillChange.send()
            }
        }
        RunLoop.main.add(timer!, forMode: .common)
    }

    var remainingTimeString: String? {
        guard let end = timerEndDate else { return nil }
        let remaining = max(0, Int(end.timeIntervalSinceNow))
        let minutes = remaining / 60
        let seconds = remaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func setupAudioSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try session.setActive(true)
        } catch {
            print("Audio session error: \(error)")
        }
    }
    
    func playLast() {
        if let last = lastSelectedSound ?? currentSound {
            play(sound: last)
        }
    }

    private func fadeIn(duration: TimeInterval) {
        fadeTimer?.invalidate()
        guard duration > 0 else { mixer.outputVolume = volume; return }
        let steps = 24
        let stepTime = duration / Double(steps)
        var step = 0
        mixer.outputVolume = 0.0
        fadeTimer = Timer.scheduledTimer(withTimeInterval: stepTime, repeats: true) { [weak self] t in
            guard let self = self else { return }
            step += 1
            let progress = min(1.0, Float(step) / Float(steps))
            self.mixer.outputVolume = progress * self.volume
            if step >= steps { t.invalidate() }
        }
        RunLoop.main.add(fadeTimer!, forMode: .common)
    }

    private func fadeOutAndStop(duration: TimeInterval) {
        fadeTimer?.invalidate()
        guard duration > 0 else { stopInternal(resetTimer: true); return }
        let steps = 24
        let stepTime = duration / Double(steps)
        var step = 0
        let startVolume = mixer.outputVolume
        fadeTimer = Timer.scheduledTimer(withTimeInterval: stepTime, repeats: true) { [weak self] t in
            guard let self = self else { return }
            step += 1
            let progress = min(1.0, Float(step) / Float(steps))
            self.mixer.outputVolume = max(0.0, startVolume * (1.0 - progress))
            if step >= steps {
                t.invalidate()
                self.stopInternal(resetTimer: true)
            }
        }
        RunLoop.main.add(fadeTimer!, forMode: .common)
    }
}

enum SoundItem: String, CaseIterable {
    case whiteNoise = "whiteNoise"
    case oceanWaves = "oceanWaves"
    case sea = "sea"

    var displayName: String {
        switch self {
        case .whiteNoise: return String(localized: "White Noise")
        case .oceanWaves: return String(localized: "Ocean Waves")
        case .sea:        return String(localized: "Sea")
        }
    }

    // Base filename without extension; expects mp3 files in the app bundle.
    var fileName: String {
        switch self {
        case .whiteNoise: return "WhiteNoise"
        case .oceanWaves: return "OceanWaves"
        case .sea:        return "Sea"
        }
    }

    // Prefer mp3; fallback to a few common formats if needed.
    var url: URL? {
        let exts = ["mp3", "m4a", "caf", "wav"]
        for ext in exts {
            if let url = Bundle.main.url(forResource: fileName, withExtension: ext) {
                return url
            }
        }
        return nil
    }
}

import AppIntents
import Foundation

// A simple shared player access for intents. In production, consider dependency injection / actor isolation.
final class PlayerCenter {
    static let shared = PlayerCenter()
    let player = NoisePlayer()
}

struct PlayLastSoundIntent: AppIntent {
    static var title: LocalizedStringResource { .init("Play Last Sound") }
    static var description: IntentDescription { .init("Play the last selected white noise or music.") }

    func perform() async throws -> some IntentResult {
        await PlayerCenter.shared.player.playLast()
        return .result()
    }
}

struct PausePlaybackIntent: AppIntent {
    static var title: LocalizedStringResource { .init("Pause") }
    static var description: IntentDescription { .init("Pause current playback.") }

    func perform() async throws -> some IntentResult {
        await PlayerCenter.shared.player.pause()
        return .result()
    }
}

struct StopPlaybackIntent: AppIntent {
    static var title: LocalizedStringResource { .init("Stop") }
    static var description: IntentDescription { .init("Stop playback.") }

    func perform() async throws -> some IntentResult {
        await PlayerCenter.shared.player.stop()
        return .result()
    }
}

struct SetSleepTimerIntent: AppIntent {
    static var title: LocalizedStringResource { .init("Set Sleep Timer") }
    static var description: IntentDescription { .init("Set a sleep timer in minutes.") }

    @Parameter(title: .init("Minutes"))
    var minutes: Int

    func perform() async throws -> some IntentResult {
        await PlayerCenter.shared.player.startSleepTimer(minutes: minutes)
        return .result()
    }
}


//
//  ContentView.swift
//  Little Moon
//
//  Created by Xianpeng Shen on 2026/2/4.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var player = NoisePlayer()
    @State private var selectedSound: SoundItem = .whiteNoise // will be updated from player on appear
    @State private var isTimerPresented = false
    @State private var timerMinutes: Int = 0
    @StateObject private var likeManager = LikeManager.shared

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer()
                
                // Sound Picker Section
                Picker("Sound", selection: $selectedSound) {
                    ForEach(SoundItem.allCases, id: \.self) { item in
                        Text(item.displayName).tag(item)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 24)
                .padding(.top, 20)
                
                Spacer()
                    .frame(height: 60)
                
                // Status and Sound Name Section
                VStack(spacing: 16) {
                    Text(player.isPlaying ? String(localized: "Now Playing", comment: "Playing state label") : String(localized: "Ready", comment: "Ready state label"))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                        .tracking(1.5)
                    
                    Text(selectedSound.displayName)
                        .font(.system(size: 52, weight: .bold, design: .rounded))
                    
                    // Like and AirPlay Row
                    HStack(spacing: 20) {
                        Button {
                            likeManager.toggleLike(for: selectedSound)
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: likeManager.isLiked(selectedSound) ? "heart.fill" : "heart")
                                    .font(.system(size: 20))
                                    .foregroundStyle(likeManager.isLiked(selectedSound) ? .red : .primary)
                                Text("\(likeManager.likeCount(selectedSound))")
                                    .font(.system(size: 17, weight: .medium))
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 10)
                            .background(Capsule().fill(Color(.secondarySystemBackground)))
                        }
                        
                        AirPlayRoutePicker()
                            .frame(width: 44, height: 44)
                            .accessibilityLabel(String(localized: "AirPlay"))
                    }
                }
                
                Spacer()
                    .frame(height: 50)
                
                // Control Buttons Section
                HStack(spacing: 28) {
                    Button {
                        if player.isPlaying { player.pause() } else { player.play(sound: selectedSound) }
                    } label: {
                        Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: 40, weight: .semibold))
                            .frame(width: 90, height: 90)
                            .foregroundStyle(.white)
                            .background(Circle().fill(.blue))
                            .shadow(color: .blue.opacity(0.4), radius: 12, x: 0, y: 6)
                            .accessibilityLabel(player.isPlaying ? String(localized: "Pause") : String(localized: "Play"))
                    }

                    Button {
                        player.stop()
                    } label: {
                        Image(systemName: "stop.fill")
                            .font(.system(size: 28, weight: .semibold))
                            .frame(width: 70, height: 70)
                            .foregroundStyle(.white)
                            .background(Circle().fill(.red))
                            .shadow(color: .red.opacity(0.4), radius: 10, x: 0, y: 5)
                            .accessibilityLabel(String(localized: "Stop"))
                    }

                    Button {
                        isTimerPresented = true
                    } label: {
                        Image(systemName: "timer")
                            .font(.system(size: 28, weight: .semibold))
                            .frame(width: 70, height: 70)
                            .foregroundStyle(.white)
                            .background(Circle().fill(.gray))
                            .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                            .accessibilityLabel(String(localized: "Sleep Timer"))
                    }
                }
                
                Spacer()
                    .frame(height: 50)
                
                // Volume Control Section
                VStack(spacing: 12) {
                    HStack(spacing: 16) {
                        Image(systemName: "speaker.fill")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 18))
                        
                        Slider(value: Binding(get: { Double(player.volume) }, set: { player.volume = Float($0) }), in: 0...1)
                            .tint(.blue)
                        
                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 18))
                    }
                    .padding(.horizontal, 28)
                    
                    if let remaining = player.remainingTimeString {
                        Text(String(localized: "Timer: ") + remaining)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding(.top, 4)
                    }
                }
                .padding(.bottom, 20)
                
                Spacer()
            }
            .onAppear {
                if let last = player.lastSelectedSound {
                    selectedSound = last
                } else if let current = player.currentSound {
                    selectedSound = current
                }
            }
            .navigationBarHidden(true)
            .onChange(of: selectedSound) { _, newValue in
                if player.isPlaying { player.play(sound: newValue) }
            }
            .sheet(isPresented: $isTimerPresented) {
                TimerSheet(minutes: $timerMinutes) { minutes in
                    player.startSleepTimer(minutes: minutes)
                }
                .presentationDetents([.height(260)])
            }
        }
    }
}

private struct TimerSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var minutes: Int
    var onConfirm: (Int) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(String(localized: "Sleep Timer"))
                .font(.headline)
            Stepper(value: $minutes, in: 0...180, step: 5) {
                Text(String(localized: "Minutes: ") + "\(minutes)")
            }
            HStack {
                Button(String(localized: "Cancel")) {
                    minutes = 0
                    dismiss()
                }
                Spacer()
                Button(String(localized: "Set")) {
                    onConfirm(minutes)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

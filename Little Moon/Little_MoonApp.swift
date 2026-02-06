//
//  Little_MoonApp.swift
//  Little Moon
//
//  Created by Xianpeng Shen on 2026/2/4.
//

import SwiftUI
import AVFoundation

@main
struct Little_MoonApp: App {
    init() {
        // Configure audio session to allow background playback
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

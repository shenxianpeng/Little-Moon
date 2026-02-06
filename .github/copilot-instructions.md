# GitHub Copilot Instructions for Little Moon

## Project Overview

Little Moon is a white noise and ambient sound iOS application built with SwiftUI. The app provides relaxing audio experiences including white noise, rain sounds, and ocean waves, with features like background playback, sleep timers, AirPlay support, and a like/favorite system.

## Technologies & Frameworks

- **Language**: Swift (latest version)
- **UI Framework**: SwiftUI
- **Audio**: AVFoundation (AVAudioEngine, AVAudioPlayerNode, AVAudioSourceNode)
- **Platform**: iOS (supports iPhone and iPad)
- **Minimum iOS Version**: iOS 15+
- **Build System**: Xcode

## Project Structure

```
Little Moon/
├── Little Moon/
│   ├── Little_MoonApp.swift          # App entry point, audio session setup
│   ├── ContentView.swift             # Main UI view
│   ├── NoisePlayer.swift             # Core audio player logic
│   ├── AirPlayRoutePicker.swift      # AirPlay integration
│   ├── PlaybackIntents.swift         # Siri/Shortcuts integration
│   ├── LikeManager.swift             # Like/favorite management
│   ├── Assets.xcassets/              # App assets
│   └── Localizable.strings           # Localization strings
├── Little Moon.xcodeproj/
├── *.py                               # Icon generation scripts
└── *.md                               # Documentation
```

## Code Style & Conventions

### Swift Style Guide

1. **Naming Conventions**
   - Use descriptive, camelCase names for variables and functions
   - Use PascalCase for types (classes, structs, enums)
   - Prefix private properties with `private` or `private(set)`
   - Use meaningful names: `isPlaying`, `currentSound`, `fadeTimer`

2. **SwiftUI Patterns**
   - Use `@StateObject` for view-owned objects
   - Use `@ObservedObject` for passed-in objects
   - Use `@State` for simple view-local state
   - Use `@Published` in ObservableObject for reactive properties
   - Prefer declarative view composition over imperative code

3. **Code Organization**
   - Group related properties together
   - Place computed properties after stored properties
   - Place initializers before methods
   - Keep functions focused and single-purpose
   - Extract complex views into separate structs

4. **Comments**
   - Add comments for complex audio synthesis algorithms
   - Document non-obvious business logic
   - Keep comments concise and up-to-date
   - Don't comment obvious code

### Audio Programming Best Practices

1. **AVFoundation Usage**
   - Always configure audio session in `init()` or app startup
   - Use `.playback` category for background audio
   - Handle audio interruptions gracefully
   - Properly manage audio engine lifecycle
   - Detach/disconnect nodes before reattaching

2. **Audio Synthesis**
   - Keep synthesis algorithms efficient (runs in real-time audio thread)
   - Use `AVAudioSourceNode` for procedural audio generation
   - Maintain smooth fade-ins/fade-outs for better UX
   - Use appropriate sample rates and buffer sizes

3. **Resource Management**
   - Schedule audio files for looping playback
   - Clean up audio nodes when switching sounds
   - Invalidate timers properly to prevent memory leaks
   - Use `[weak self]` in closures to avoid retain cycles

## Architecture Patterns

### MVVM-like Structure

- **Model**: `SoundItem` enum, audio data
- **View**: `ContentView`, `TimerSheet`, SwiftUI views
- **ViewModel**: `NoisePlayer` (ObservableObject managing audio state)
- **Services**: `LikeManager` (shared singleton)

### State Management

- Use `@Published` properties for UI-reactive state
- Store user preferences in `UserDefaults`
- Use `Combine` for reactive updates when needed
- Keep state minimal and focused

## Key Features to Preserve

### 1. Background Audio Playback
- Audio session configured for `.playback` mode
- UIBackgroundModes includes "audio" in Info.plist
- Audio continues when app is backgrounded or screen locks

### 2. Audio Synthesis
- Supports both file-based audio and procedural synthesis
- Fallback to synthesis if audio files not found
- Three synthesis types: white noise, rain (colored noise), ocean (LFO-modulated)

### 3. Sleep Timer
- Countdown timer with minute-based intervals
- Displays remaining time in MM:SS format
- Automatically stops playback when timer expires
- Timer persists during sound changes

### 4. Like System
- Track likes per sound type
- Persist like counts in UserDefaults
- Visual feedback with filled/unfilled heart icons

### 5. User Experience
- Smooth fade-in/fade-out transitions
- Remember last selected sound
- Volume control with slider
- Segmented picker for sound selection
- AirPlay integration
- Accessibility labels for all controls

## Localization

- All user-facing strings use `String(localized:)`
- Support both English and Chinese (simplified)
- Keys: "White Noise", "Rain", "Ocean", "Play", "Pause", "Stop", "Sleep Timer", etc.
- Maintain consistency in translation quality

## Accessibility

- Add `.accessibilityLabel()` to all interactive elements
- Ensure buttons have descriptive labels
- Support VoiceOver for all controls
- Use semantic colors that work in light/dark mode
- Ensure sufficient color contrast

## Testing Guidelines

1. **Manual Testing Checklist**
   - Test all three sound types (white noise, rain, ocean)
   - Verify background playback works
   - Test sleep timer at various durations
   - Verify AirPlay connectivity
   - Test like/unlike functionality
   - Check sound persistence across app restarts
   - Verify volume control works smoothly
   - Test on both iPhone and iPad
   - Test in both light and dark mode

2. **Common Issues to Avoid**
   - Audio not playing in background (check audio session)
   - Memory leaks from timer/audio node references
   - Crashes when switching sounds rapidly
   - Timer not resetting properly
   - Volume jumps instead of smooth transitions

## Common Tasks

### Adding a New Sound Type

1. Add case to `SoundItem` enum
2. Add display name with localization
3. Add file name mapping
4. Update synthesis logic in `startSynthesis(for:)` if procedural
5. Add audio file to bundle if file-based
6. Update segmented picker if needed

### Modifying UI Layout

1. Follow existing spacing patterns (multiples of 4/8)
2. Use `.padding()` consistently
3. Maintain visual hierarchy
4. Test on different screen sizes
5. Ensure dark mode compatibility

### Adding New Features

1. Consider if it needs to persist (UserDefaults)
2. Add @Published property if UI needs to react
3. Update relevant views with bindings
4. Add localization strings
5. Add accessibility labels
6. Test thoroughly

## Dependencies

- No external dependencies (uses only Apple frameworks)
- Keep it lightweight and self-contained
- Avoid adding unnecessary third-party libraries

## Build & Deployment

- Target: iOS 15.0+
- Bundle ID: `app.Little-Moon`
- Version: 1.0
- Build number: 1
- Supports iPhone and iPad
- Supports portrait and landscape orientations
- App Store ready (background modes configured)

## Documentation References

- **APP_STORE_CHECKLIST.md**: Complete App Store submission guide
- **RELEASE_SUMMARY.md**: Current release status and timeline
- **HOW_TO_ADD_ICON.md**: Icon application instructions
- **AUDIO_GENERATION_PROMPTS.md**: AI prompts for generating audio assets
- **APP_ICON_PROMPT.md**: AI prompts for generating app icons

## Performance Considerations

1. **Audio Performance**
   - Audio synthesis runs on real-time thread (keep it fast!)
   - Avoid allocations in audio callback
   - Use efficient random number generation
   - Minimize computational complexity in synthesis

2. **UI Performance**
   - Use `@StateObject` and `@ObservedObject` appropriately
   - Avoid excessive view updates
   - Keep view hierarchy shallow
   - Profile with Instruments if performance issues arise

## Security & Privacy

- No data collection or analytics
- No network requests
- All data stored locally in UserDefaults
- No sensitive permissions required
- Privacy-focused design

## Future Considerations

- Support for custom audio files
- Additional sound types
- EQ/audio effects
- Mixing multiple sounds
- Widgets for quick controls
- Watch app companion
- More granular timer controls

## Common Copilot Prompts

When working with GitHub Copilot on this project, you might use prompts like:

- "Add a new ocean wave synthesis algorithm with realistic wave patterns"
- "Create a new sound type for thunderstorm with rain and thunder"
- "Add a favorites section to remember liked sounds"
- "Implement volume automation for gradual volume changes"
- "Add haptic feedback when buttons are tapped"
- "Create a settings view for customizing app behavior"

## Code Quality Standards

- ✅ No force unwrapping (`!`) unless absolutely necessary
- ✅ Proper error handling with `do-catch` or `try?`
- ✅ Memory leak prevention (weak self in closures)
- ✅ Clean resource management (timers, audio nodes)
- ✅ Consistent formatting and indentation
- ✅ Meaningful variable and function names
- ✅ Minimal coupling between components
- ✅ Single responsibility principle

---

**Last Updated**: February 2026  
**Maintained by**: Xianpeng Shen  
**License**: As per project LICENSE file

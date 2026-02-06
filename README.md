# Little Moon 🌙

A beautiful and minimalist iOS white noise and ambient sound app built with SwiftUI, designed to help you relax, focus, and sleep better.

<p align="center">
  <img src="AppIcon-1024.png" alt="Little Moon App Icon" width="200"/>
</p>

## ✨ Features

- 🎵 **Multiple Ambient Sounds**
  - White Noise - Classic white noise for masking background sounds
  - Rain - Soothing rain sounds for relaxation
  - Ocean Waves - Calming ocean waves for sleep

- 🎮 **Playback Controls**
  - Play, pause, and stop functionality
  - Volume adjustment
  - Smooth fade in/out effects

- ⏰ **Sleep Timer**
  - Set a timer to automatically stop playback
  - Perfect for falling asleep without draining battery

- ❤️ **Like/Favorite System**
  - Mark your favorite sounds
  - Persistent like counts

- 📱 **AirPlay Support**
  - Stream to AirPlay-compatible devices
  - Full wireless audio support

- 🎨 **Beautiful UI**
  - Clean, minimalist design
  - Intuitive controls
  - Professional appearance

- 🔊 **Background Audio**
  - Continue playing when app is in background
  - Full audio session management

## 📋 Requirements

- iOS 17.0 or later
- Xcode 15.0 or later
- Swift 5.9 or later

## 🚀 Getting Started

### Installation

1. Clone the repository:
```bash
git clone https://github.com/shenxianpeng/Little-Moon.git
cd Little-Moon
```

2. Open the project in Xcode:
```bash
open "Little Moon.xcodeproj"
```

3. Build and run:
   - Select your target device or simulator
   - Press `⌘R` to build and run

### Configuration

The app is ready to use out of the box. The Bundle ID is configured as `app.Little-Moon`.

## 🏗️ Project Structure

```
Little Moon/
├── Little Moon/              # Main app source code
│   ├── ContentView.swift    # Main UI view
│   ├── Little_MoonApp.swift # App entry point
│   ├── NoisePlayer.swift    # Audio playback engine
│   ├── LikeManager.swift    # Like/favorite management
│   ├── PlaybackIntents.swift # Siri integration
│   ├── AirPlayRoutePicker.swift # AirPlay support
│   ├── Localizable.strings  # Localization strings
│   └── Assets.xcassets/     # App assets and icons
├── Little Moon.xcodeproj/   # Xcode project file
├── AppIcon-1024.png         # Source app icon
├── apply_app_icon.py        # Icon generation script (Python)
├── apply_app_icon.sh        # Icon generation script (Shell)
└── generate_placeholder_icon.py # Placeholder icon generator
```

## 📱 App Store

This app is ready for App Store submission. Before submitting:

1. Review the [App Store Checklist](APP_STORE_CHECKLIST.md)
2. Check the [Release Summary](RELEASE_SUMMARY.md)
3. Prepare screenshots (see guidelines in documentation)
4. Create privacy policy page

For detailed release information, see:
- **[RELEASE_SUMMARY.md](RELEASE_SUMMARY.md)** - Complete release status and timeline
- **[UPDATE_SUMMARY.md](UPDATE_SUMMARY.md)** - Recent changes and improvements
- **[APP_STORE_CHECKLIST.md](APP_STORE_CHECKLIST.md)** - Complete App Store submission guide

## 🎨 Customization

### App Icon

The app includes scripts to help you customize the app icon:

1. **Using AI to generate a new icon:**
   - See [APP_ICON_PROMPT.md](APP_ICON_PROMPT.md) for detailed AI prompts
   - Generate a 1024x1024 PNG image
   - Save it as `AppIcon-1024.png`

2. **Apply the icon:**
   ```bash
   # Using Python (recommended)
   python3 apply_app_icon.py
   
   # Or using Shell script
   ./apply_app_icon.sh
   ```

3. **Generate a placeholder icon:**
   ```bash
   python3 generate_placeholder_icon.py
   ```

For more details, see [HOW_TO_ADD_ICON.md](HOW_TO_ADD_ICON.md).

### Audio Files

Currently, the app uses synthesized audio. To add real audio files:

1. Review [AUDIO_GENERATION_PROMPTS.md](AUDIO_GENERATION_PROMPTS.md) for AI audio generation prompts
2. Generate or obtain audio files
3. Add them to the project's Assets

## 🛠️ Development

### Building

```bash
# Clean build
xcodebuild clean -project "Little Moon.xcodeproj" -scheme "Little Moon"

# Build for simulator
xcodebuild -project "Little Moon.xcodeproj" -scheme "Little Moon" -sdk iphonesimulator

# Build for device
xcodebuild -project "Little Moon.xcodeproj" -scheme "Little Moon" -sdk iphoneos
```

### Testing

1. Open the project in Xcode
2. Select a simulator or connected device
3. Run the app with `⌘R`
4. Test all sounds and features

## 🤝 Contributing

Contributions are welcome! Here are some ways you can contribute:

- Report bugs and issues
- Suggest new features or improvements
- Submit pull requests
- Improve documentation
- Add new ambient sounds
- Enhance UI/UX design

## 📄 License

This project is available for personal and educational use. Please check with the repository owner for commercial use.

## 📚 Documentation

- [App Store Checklist](APP_STORE_CHECKLIST.md) - Complete guide for App Store submission
- [Release Summary](RELEASE_SUMMARY.md) - Current release status and timeline
- [Update Summary](UPDATE_SUMMARY.md) - Recent changes and improvements
- [App Icon Guide](HOW_TO_ADD_ICON.md) - How to customize the app icon
- [Icon Prompts](APP_ICON_PROMPT.md) - AI prompts for generating icons
- [Audio Prompts](AUDIO_GENERATION_PROMPTS.md) - AI prompts for generating audio

## 👨‍💻 Author

Created by Xianpeng Shen

## 🙏 Acknowledgments

- Built with SwiftUI and AVFoundation
- Inspired by the need for simple, beautiful ambient sound apps

---

**Enjoy peaceful moments with Little Moon! 🌙✨**

*Made with ❤️ for better sleep and focus*

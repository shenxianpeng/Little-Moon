# 🌙 Little Moon

> Your peaceful sleep companion with soothing ambient sounds

Little Moon is an elegant iOS app that helps you fall asleep faster and sleep better with carefully crafted ambient sounds including white noise, rain, and ocean waves.

![App Icon](AppIcon-1024.png)

## ✨ Features

- **Three Soothing Sounds**
  - 🔊 White Noise - Block distractions and create a peaceful environment
  - 🌧️ Rain - Gentle rainfall for deep relaxation
  - 🌊 Ocean - Calming ocean waves for tranquil sleep

- **Smart Sleep Timer**
  - Set automatic stop timer (5, 15, 30, 60 minutes)
  - Falls asleep with you - no jarring interruptions

- **Background Playback**
  - Continues playing even when your phone is locked
  - Works seamlessly in the background

- **AirPlay Support**
  - Stream to your favorite speakers or devices
  - Fill your room with soothing sounds

- **Simple & Beautiful**
  - Clean, intuitive interface
  - Dark mode support
  - No ads, no subscriptions
  - Privacy-first design - no data collection

## 📱 Requirements

- iOS 15.0 or later
- Compatible with iPhone and iPad
- Works in both portrait and landscape orientations

## 🛠️ Technical Details

### Built With
- SwiftUI for modern, declarative UI
- AVFoundation for audio playback
- Background audio capabilities
- AirPlay integration
- Siri shortcuts support (PlaybackIntents)

### Project Structure
```
Little Moon/
├── Little_MoonApp.swift      # App entry point
├── ContentView.swift          # Main UI
├── NoisePlayer.swift          # Audio engine
├── LikeManager.swift          # User preferences
├── PlaybackIntents.swift     # Siri shortcuts
├── AirPlayRoutePicker.swift  # AirPlay integration
└── Assets.xcassets/          # App assets
```

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0 or later
- macOS Ventura or later
- Apple Developer account (for device testing)

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/little-moon.git
cd little-moon
```

2. Open the project in Xcode
```bash
open "Little Moon.xcodeproj"
```

3. Select your development team in the project settings
   - Go to "Little Moon" target → Signing & Capabilities
   - Select your team

4. Build and run
   - Select a simulator or connected device
   - Press `Cmd+R` to build and run

## 🧪 Testing

The project includes GitHub Actions workflows for continuous integration:

- **Test Workflow** - Runs on every push and PR
  - Builds for iPhone simulator
  - Builds for iPad simulator
  - Runs unit tests (if available)

- **Release Workflow** - Triggers on version tags
  - Creates production build
  - Generates IPA file
  - Uploads to TestFlight
  - Creates GitHub release

### Running Tests Locally
```bash
xcodebuild test \
  -project "Little Moon.xcodeproj" \
  -scheme "Little Moon" \
  -destination "platform=iOS Simulator,name=iPhone 15 Pro"
```

## 📦 Building for Release

1. Update version number in Xcode
   - Select project → General
   - Update Version and Build number

2. Create archive
```bash
xcodebuild archive \
  -project "Little Moon.xcodeproj" \
  -scheme "Little Moon" \
  -archivePath "build/Little Moon.xcarchive"
```

3. Export IPA
```bash
xcodebuild -exportArchive \
  -archivePath "build/Little Moon.xcarchive" \
  -exportPath "build" \
  -exportOptionsPlist ExportOptions.plist
```

## 🔧 Configuration

### GitHub Actions Secrets

For automated releases, configure these secrets in your repository:

- `CERTIFICATE_BASE64` - Base64 encoded distribution certificate
- `CERTIFICATE_PASSWORD` - Certificate password
- `KEYCHAIN_PASSWORD` - Keychain password for CI
- `PROVISIONING_PROFILE_BASE64` - Base64 encoded provisioning profile
- `APP_STORE_CONNECT_API_KEY` - App Store Connect API key
- `APP_STORE_CONNECT_ISSUER_ID` - Issuer ID
- `APP_STORE_CONNECT_KEY_ID` - Key ID

### ExportOptions.plist

Create an `ExportOptions.plist` file for release builds:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>app-store</string>
    <key>teamID</key>
    <string>S46BSLZ6TR</string>
    <key>uploadSymbols</key>
    <true/>
    <key>compileBitcode</key>
    <false/>
</dict>
</plist>
```

## 🎨 App Icon

The app icon features a serene crescent moon design. For customization:
- See `APP_ICON_PROMPT.md` for AI generation prompts
- Use `apply_app_icon.py` to apply new icons
- Source image: `AppIcon-1024.png` (1024x1024)

## 📄 Privacy Policy

Little Moon respects your privacy:
- ✅ No data collection
- ✅ No analytics or tracking
- ✅ No third-party services
- ✅ All preferences stored locally on your device
- ✅ No internet connection required

## 📝 License

Copyright © 2026 Xianpeng Shen. All rights reserved.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 🐛 Bug Reports

If you encounter any issues, please [open an issue](https://github.com/yourusername/little-moon/issues) with:
- Device model and iOS version
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable

## 💡 Roadmap

Future enhancements being considered:
- [ ] Mix multiple sounds together
- [ ] Custom fade in/fade out
- [ ] Favorites system
- [ ] Playback history
- [ ] Widget support
- [ ] More ambient sounds
- [ ] Custom sound uploads

## 📧 Contact

Xianpeng Shen - [@yourusername](https://github.com/yourusername)

Project Link: [https://github.com/yourusername/little-moon](https://github.com/yourusername/little-moon)

---

Made with ❤️ for better sleep

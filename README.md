# Little Moon 🌙

![CI](https://github.com/shenxianpeng/Little-Moon/workflows/CI/badge.svg)
![SwiftLint](https://github.com/shenxianpeng/Little-Moon/workflows/SwiftLint/badge.svg)
![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

A beautiful iOS app for sleep sounds and white noise to help you relax and sleep better.

## Features

- 🎵 High-quality white noise and nature sounds
- 🌙 Background audio playback support
- ⏱️ Sleep timer functionality
- ❤️ Favorite sounds management
- 🎨 Beautiful, minimalist UI design
- 🔊 AirPlay support

## Requirements

- iOS 15.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

1. Clone the repository:
```bash
git clone https://github.com/shenxianpeng/Little-Moon.git
cd Little-Moon
```

2. Open the project in Xcode:
```bash
open "Little Moon.xcodeproj"
```

3. Build and run the project in Xcode (⌘+R)

## Development

### Building

```bash
xcodebuild clean build \
  -project "Little Moon.xcodeproj" \
  -scheme "Little Moon" \
  -destination "platform=iOS Simulator,name=iPhone 15 Pro,OS=latest"
```

### Code Quality

This project uses SwiftLint for code quality. Install SwiftLint:

```bash
brew install swiftlint
```

Run SwiftLint:

```bash
swiftlint
```

## CI/CD

This project uses GitHub Actions for continuous integration:

- **CI Workflow**: Builds and tests the app on every push and pull request
- **SwiftLint**: Checks code quality and style
- **PR Check**: Validates pull requests before merging
- **Archive**: Creates release builds for App Store submission

## App Store

Bundle Identifier: `app.Little-Moon`

For App Store submission details, see:
- [APP_STORE_CHECKLIST.md](APP_STORE_CHECKLIST.md)
- [RELEASE_SUMMARY.md](RELEASE_SUMMARY.md)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is available under the MIT License.

## Author

Created by Xianpeng Shen

---

Made with ❤️ using SwiftUI

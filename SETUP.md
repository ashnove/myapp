# Setup Guide

Complete setup guide for MyApp iOS application.

## Quick Start (5 minutes)

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd workspace
   ```

2. **Open in Xcode**
   ```bash
   cd MyApp
   open MyApp.xcodeproj
   ```

3. **Build and Run**
   - Select iPhone 15 simulator (or your device)
   - Press `Cmd + R`
   - App should launch successfully

## Detailed Setup

### System Requirements

- **Operating System**: macOS 13.0 (Ventura) or later
- **Xcode**: Version 15.0 or later
- **iOS Deployment Target**: iOS 16.0+
- **Disk Space**: ~5 GB (includes Xcode cache)

### Installing Xcode

1. Open App Store
2. Search for "Xcode"
3. Click "Get" or "Install"
4. Wait for installation to complete (~12 GB download)

Or use command line:
```bash
xcode-select --install
```

### Verifying Xcode Installation

```bash
xcodebuild -version
# Should output: Xcode 15.0 or later
```

### Project Configuration

#### 1. Bundle Identifier

Update the bundle identifier to make it unique:

1. Open project in Xcode
2. Select project in navigator
3. Select "MyApp" target
4. Go to "Signing & Capabilities"
5. Change "Bundle Identifier" to your own (e.g., `com.yourcompany.MyApp`)

#### 2. Code Signing

**For Simulator (No Setup Required):**
- Just select a simulator and run

**For Physical Device:**

1. Connect your iPhone/iPad via USB
2. In Xcode, select your device from the target dropdown
3. Go to "Signing & Capabilities"
4. Select your Team (requires Apple Developer account)
5. Xcode will automatically provision the app

**Troubleshooting Signing:**
- If you see signing errors, make sure you're logged into Xcode with your Apple ID
- Xcode → Settings → Accounts → Add Apple ID

#### 3. Development Team Setup

Free Apple ID:
- Can test on physical devices
- Apps expire after 7 days
- Limited to 3 devices

Paid Apple Developer Program ($99/year):
- No expiration
- App Store distribution
- Advanced capabilities (push notifications, etc.)

### Running the App

#### On Simulator

1. In Xcode, click the device dropdown (top-left)
2. Select a simulator (e.g., iPhone 15)
3. Press `Cmd + R` or click the Play button
4. Wait for simulator to boot and app to install

**First Launch:**
- Simulator may take 1-2 minutes to boot
- Subsequent launches are faster

#### On Physical Device

1. Connect iPhone/iPad via USB
2. Trust the computer on your device
3. Select your device in Xcode
4. Press `Cmd + R`

**First Time on Device:**
- Go to Settings → General → VPN & Device Management
- Trust your developer certificate
- Return to home screen and launch app

### Project Structure

```
MyApp/
├── MyApp.xcodeproj          # Xcode project file
├── MyApp/                   # Source code
│   ├── MyAppApp.swift       # App entry point
│   ├── ContentView.swift    # Main view
│   ├── Views/              # UI views
│   ├── Models/             # Data models
│   ├── Persistence/        # Core Data
│   ├── Services/           # Business logic
│   ├── Config/             # Configuration
│   ├── Utilities/          # Helpers
│   └── Assets.xcassets/    # Images, colors
├── MyAppTests/             # Unit tests
└── MyAppUITests/           # UI tests
```

### Dependencies

This project has **no external dependencies** by design. Everything needed is included or part of iOS SDK.

### Optional Tools

#### SwiftLint (Code Quality)

Install:
```bash
brew install swiftlint
```

Run:
```bash
make lint
```

#### SwiftFormat (Code Formatting)

Install:
```bash
brew install swiftformat
```

Run:
```bash
make format
```

### Building from Command Line

#### Build
```bash
make build
```

#### Run Tests
```bash
make test
```

#### Clean
```bash
make clean
```

### Xcode Keyboard Shortcuts

- `Cmd + R` - Run app
- `Cmd + B` - Build
- `Cmd + U` - Run tests
- `Cmd + .` - Stop running
- `Cmd + Shift + K` - Clean build folder
- `Cmd + Shift + O` - Open quickly (file search)
- `Cmd + /` - Toggle comment

### Troubleshooting

#### Build Fails

**Error: "No signing certificate"**
- Solution: Add your Apple ID in Xcode → Settings → Accounts

**Error: "Build input file cannot be found"**
- Solution: Clean build folder (`Cmd + Shift + K`) and rebuild

**Error: "The operation couldn't be completed"**
- Solution: Restart Xcode

#### Simulator Issues

**Simulator won't boot:**
```bash
# Reset simulator
xcrun simctl shutdown all
xcrun simctl erase all
```

**App not appearing in simulator:**
- Delete app from simulator
- Clean build folder
- Rebuild and run

#### Core Data Issues

**Error: "The model used to open the store is incompatible"**
- Solution: Delete app from simulator/device (removes old database)
- For production apps, implement proper migrations

#### Performance Issues

**Xcode is slow:**
- Close other apps
- Clean derived data: `rm -rf ~/Library/Developer/Xcode/DerivedData/*`
- Restart Xcode

**Simulator is slow:**
- Reduce graphics quality: Simulator → Features → Graphics Quality → Low
- Use a smaller device (iPhone SE)
- Increase RAM allocated to simulator

### Testing Setup

#### Running Tests

**All tests:**
```bash
make test
# or
xcodebuild test -scheme MyApp -destination 'platform=iOS Simulator,name=iPhone 15'
```

**Specific test:**
```bash
xcodebuild test -scheme MyApp -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:MyAppTests/MyAppTests/testItemCreation
```

**In Xcode:**
- `Cmd + U` runs all tests
- Click diamond icon next to test to run individually
- View results in Test Navigator (`Cmd + 6`)

#### Code Coverage

Enable code coverage:
1. Edit scheme (`Cmd + <`)
2. Select "Test" action
3. Options tab
4. Check "Code Coverage"

View coverage:
- Report Navigator (`Cmd + 9`)
- Select latest test run
- Click "Coverage" tab

### Debugging

#### Breakpoints

1. Click line number to add breakpoint
2. Run app in debug mode (`Cmd + R`)
3. When breakpoint hits:
   - Step over: `F6`
   - Step into: `F7`
   - Step out: `F8`
   - Continue: `Ctrl + Cmd + Y`

#### Print Debugging

Use Logger instead of print:
```swift
import os.log

Logger.general.debug("Debug message")
Logger.general.info("Info message")
Logger.general.error("Error message")
```

View logs:
- Xcode console (bottom panel)
- Console.app (filter by process name)

#### View Hierarchy Debugging

1. Run app
2. Debug → View Debugging → Capture View Hierarchy
3. Rotate and inspect 3D view

### Advanced Setup

#### Custom Build Configurations

1. Project → Info
2. Configurations section
3. Duplicate "Debug" configuration
4. Name it "Staging"
5. Update `AppConfig.swift` to handle new environment

#### Multiple Schemes

For different environments:
1. Product → Scheme → New Scheme
2. Name it (e.g., "MyApp-Staging")
3. Edit scheme
4. Build Configuration → Select "Staging"

#### Fastlane (CI/CD)

For automated builds and distribution:

```bash
# Install fastlane
brew install fastlane

# Initialize
cd MyApp
fastlane init

# Follow prompts
```

### Environment-Specific Configuration

Create different configurations for dev/staging/prod:

1. Create `Config.xcconfig` files:
   ```
   Config/
   ├── Debug.xcconfig
   ├── Release.xcconfig
   └── Staging.xcconfig
   ```

2. Set in project settings:
   - Project → Info → Configurations
   - Assign config files

3. Use in code:
   ```swift
   #if DEBUG
   let apiURL = "https://dev-api.example.com"
   #else
   let apiURL = "https://api.example.com"
   #endif
   ```

### CI/CD Integration

#### GitHub Actions Example

Create `.github/workflows/ios.yml`:

```yaml
name: iOS CI

on: [push, pull_request]

jobs:
  build-and-test:
    runs-on: macos-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Select Xcode version
      run: sudo xcode-select -s /Applications/Xcode_15.0.app
    
    - name: Build
      run: make build
    
    - name: Run tests
      run: make test
```

### Getting Help

#### Resources

- [README.md](README.md) - Project overview
- [ARCHITECTURE.md](ARCHITECTURE.md) - Architecture details
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines
- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [Swift.org](https://swift.org)

#### Common Questions

**Q: Do I need a paid Apple Developer account?**
A: No, for development and simulator testing. Yes, for App Store distribution.

**Q: Can I develop on Windows/Linux?**
A: No, iOS development requires macOS and Xcode.

**Q: How large is the project?**
A: ~50 KB source code, ~10 MB with build artifacts.

**Q: Does this work on M1/M2 Macs?**
A: Yes, fully compatible with Apple Silicon.

**Q: Can I use this for production?**
A: Yes, but update bundle identifiers, signing, and configuration.

### Next Steps

After successful setup:

1. ✅ Run the app on simulator
2. ✅ Run all tests
3. ✅ Read [README.md](README.md) for feature overview
4. ✅ Read [ARCHITECTURE.md](ARCHITECTURE.md) to understand structure
5. ✅ Try adding a new feature
6. ✅ Read [CONTRIBUTING.md](CONTRIBUTING.md) to contribute

### Support

If you encounter issues:

1. Check this guide's troubleshooting section
2. Search existing GitHub issues
3. Create a new issue with:
   - Xcode version
   - macOS version
   - Error message
   - Steps to reproduce

---

**Happy coding! 🎉**

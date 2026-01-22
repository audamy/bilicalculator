# Neonatal Jaundice Calculator - APK Build Instructions

## Quick Start (If you have space)

```bash
cd /Users/mahmoudahmed/neonatal_jaundice_calculator
flutter build apk --release
```

The APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`

## Building on Your Current System (Space-Limited)

Due to disk space constraints, here's a recommended approach:

### Option 1: Clean Build with Optimizations

```bash
# Clear Flutter cache to free up space
flutter clean

# Remove build directories
rm -rf build/
rm -rf .dart_tool/

# Build with minimal footprint
flutter build apk --release --no-build-number
```

### Option 2: Split Per Architecture (Smaller APKs)

```bash
flutter build apk --split-per-abi
```

This creates separate APKs for each CPU architecture:
- `app-armeabi-v7a-release.apk` (32-bit ARM)
- `app-arm64-v8a-release.apk` (64-bit ARM - Most common for modern Android)
- `app-x86_64-release.apk` (x86 64-bit)

Located at: `build/app/outputs/flutter-apk/`

### Option 3: AAB (Android App Bundle - For Google Play)

```bash
flutter build appbundle --release
```

Located at: `build/app/outputs/bundle/release/app-release.aab`

## Prerequisites

Before building, ensure:

1. **Android SDK** is installed:
   ```bash
   export ANDROID_SDK_ROOT=~/Android/sdk
   export ANDROID_HOME=~/Android/sdk
   ```

2. **Java 17+** is installed:
   ```bash
   /opt/homebrew/opt/openjdk@17/bin/java -version
   ```

3. **Flutter** is installed:
   ```bash
   flutter doctor
   ```

## Troubleshooting

### "No Android SDK found"

```bash
flutter config --android-sdk ~/Android/sdk
```

### Out of Disk Space

Clear these to free up space:

```bash
# Flutter build cache
rm -rf ~/.dart_tool/

# Gradle cache
rm -rf ~/.gradle/

# Android SDK unnecessary files
rm -rf ~/Android/sdk/ndk
rm -rf ~/Android/sdk/emulator
rm -rf ~/Android/sdk/system-images
```

### Build Fails

Try clean build:

```bash
flutter clean
flutter pub get
flutter build apk --release
```

## Installing on Device

Transfer the APK to your Android device and open it to install, or use:

```bash
flutter install
```

(Requires Android device/emulator connected and SDK properly configured)

## Cloud-Based Building (Alternative)

If disk space remains an issue, consider:

1. **Google Play Console** - Upload source and build in cloud
2. **Codemagic** - Free CI/CD for Flutter apps (github.com)
3. **GitHub Actions** - Build APKs automatically
4. **Fastlane** - Automate builds and deployment

## Project Details

- **App Name**: Neonatal Jaundice Calculator
- **Package**: com.example.neonatal_jaundice_calculator
- **Min SDK**: 21 (Android 5.0)
- **Target SDK**: 34 (Android 14)

## Next Steps After Build

1. Test on emulator or device
2. Sign the APK for distribution
3. Upload to Google Play Store or share directly

For detailed Flutter build documentation: https://docs.flutter.dev/deployment/android

#!/bin/bash

# Quick APK Build Script with Environment Setup
# Run this script to build the Neonatal Jaundice Calculator APK

PROJECT_DIR="/Users/mahmoudahmed/neonatal_jaundice_calculator"

# Set up environment
export ANDROID_HOME="$HOME/Android/sdk"
export JAVA_HOME="/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

echo "🚀 Building Neonatal Jaundice Calculator APK..."
echo ""
echo "Environment:"
echo "  ANDROID_HOME: $ANDROID_HOME"
echo "  JAVA_HOME: $JAVA_HOME"
echo ""

cd "$PROJECT_DIR"

# Step 1: Clean
echo "📦 Step 1: Cleaning previous builds..."
flutter clean
rm -rf build/ .dart_tool/

# Step 2: Get dependencies
echo "📚 Step 2: Getting dependencies..."
flutter pub get

# Step 3: Build APK
echo "🔨 Step 3: Building APK..."
flutter build apk --split-per-abi --release

# Step 4: Check results
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ BUILD SUCCESSFUL!"
    echo ""
    echo "APK files created:"
    find build/app/outputs/flutter-apk -name "*.apk" -exec ls -lh {} \;
    echo ""
    echo "📱 Installation options:"
    echo "1. Direct transfer: adb install build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"
    echo "2. Google Play Store: Upload app-release.aab"
    echo ""
else
    echo "❌ Build failed!"
    exit 1
fi

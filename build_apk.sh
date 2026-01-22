#!/bin/bash

# Neonatal Jaundice Calculator - APK Build Script
# This script builds the Flutter APK for Android

set -e

PROJECT_DIR="/Users/mahmoudahmed/neonatal_jaundice_calculator"
BUILD_OUTPUT_DIR="$PROJECT_DIR/build/app/outputs/flutter-apk"

echo "=========================================="
echo "Neonatal Jaundice Calculator - APK Builder"
echo "=========================================="
echo ""

# Check prerequisites
echo "Checking prerequisites..."

# Check Flutter
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter not found. Install with: brew install flutter"
    exit 1
fi

# Check Java
if ! command -v java &> /dev/null; then
    echo "❌ Java not found. Install with: brew install openjdk@17"
    exit 1
fi

# Check Android SDK
if [ -z "$ANDROID_HOME" ] && [ ! -d "$HOME/Android/sdk" ]; then
    echo "❌ Android SDK not found."
    echo "   Set ANDROID_HOME or install Android Studio"
    exit 1
fi

# Set Android SDK if not already set
if [ -z "$ANDROID_HOME" ]; then
    export ANDROID_HOME="$HOME/Android/sdk"
fi

echo "✓ Flutter installed"
echo "✓ Java installed"
echo "✓ Android SDK found at: $ANDROID_HOME"
echo ""

# Navigate to project
cd "$PROJECT_DIR"

echo "Building APK files..."
echo ""

# Clean previous builds
flutter clean
rm -rf build/

# Get dependencies
echo "Getting dependencies..."
flutter pub get

# Build split APKs (one per architecture)
echo "Building split APKs (ARM64, ARM32, x86_64)..."
flutter build apk --split-per-abi --release

# Check if build was successful
if [ -d "$BUILD_OUTPUT_DIR" ]; then
    echo ""
    echo "=========================================="
    echo "✓ BUILD SUCCESSFUL!"
    echo "=========================================="
    echo ""
    echo "Output files:"
    ls -lh "$BUILD_OUTPUT_DIR"/*.apk
    echo ""
    echo "Recommended APK:"
    echo "→ app-arm64-v8a-release.apk (Most common for modern devices)"
    echo ""
else
    echo "❌ Build failed. Check output above for errors."
    exit 1
fi

echo "Done!"

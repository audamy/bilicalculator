#!/usr/bin/env python3
"""
Neonatal Jaundice Calculator - APK Build Assistant
Automates the APK build process with proper environment setup
"""

import os
import subprocess
import sys
from pathlib import Path

PROJECT_DIR = Path("/Users/mahmoudahmed/neonatal_jaundice_calculator")
ANDROID_SDK = Path.home() / "Android" / "sdk"
JAVA_HOME = Path("/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home")

def run_command(cmd, description=""):
    """Run a command and return success status"""
    if description:
        print(f"\n{'='*60}")
        print(f"📌 {description}")
        print('='*60)
    
    print(f"$ {' '.join(cmd)}\n")
    try:
        result = subprocess.run(cmd, check=True, text=True)
        return True
    except subprocess.CalledProcessError as e:
        print(f"\n❌ Error: {e}")
        return False
    except FileNotFoundError as e:
        print(f"\n❌ Command not found: {e}")
        return False

def check_prerequisites():
    """Check if all required tools are installed"""
    print("\n" + "="*60)
    print("🔍 CHECKING PREREQUISITES")
    print("="*60)
    
    checks = {
        "Flutter": subprocess.run(["flutter", "--version"], capture_output=True).returncode == 0,
        "Java": subprocess.run(["java", "-version"], capture_output=True).returncode == 0,
        "Android SDK": ANDROID_SDK.exists(),
        "Git": subprocess.run(["git", "--version"], capture_output=True).returncode == 0,
    }
    
    for tool, available in checks.items():
        status = "✅" if available else "❌"
        print(f"{status} {tool}")
    
    if not all(checks.values()):
        print("\n⚠️  Some prerequisites are missing!")
        if not checks["Flutter"]:
            print("   Install Flutter: brew install flutter")
        if not checks["Java"]:
            print("   Install Java: brew install openjdk@17")
        if not checks["Android SDK"]:
            print("   Install Android SDK or Android Studio from developer.android.com")
        return False
    
    print("\n✅ All prerequisites met!")
    return True

def setup_environment():
    """Set up environment variables"""
    print("\n" + "="*60)
    print("⚙️  SETTING UP ENVIRONMENT")
    print("="*60)
    
    os.environ["ANDROID_HOME"] = str(ANDROID_SDK)
    os.environ["ANDROID_SDK_ROOT"] = str(ANDROID_SDK)
    
    if JAVA_HOME.exists():
        os.environ["JAVA_HOME"] = str(JAVA_HOME)
    
    print(f"ANDROID_HOME = {ANDROID_SDK}")
    print(f"JAVA_HOME = {JAVA_HOME}")
    print("\n✅ Environment configured")

def build_apk():
    """Build the APK"""
    os.chdir(PROJECT_DIR)
    
    steps = [
        (["flutter", "clean"], "Cleaning previous builds..."),
        (["rm", "-rf", "build", ".dart_tool"], "Removing cache directories..."),
        (["flutter", "pub", "get"], "Getting Flutter dependencies..."),
        (["flutter", "build", "apk", "--split-per-abi", "--release"], "Building APK files..."),
    ]
    
    for cmd, description in steps:
        if not run_command(cmd, description):
            return False
    
    return True

def show_results():
    """Show build results"""
    apk_dir = PROJECT_DIR / "build" / "app" / "outputs" / "flutter-apk"
    
    if apk_dir.exists():
        apk_files = list(apk_dir.glob("*.apk"))
        
        if apk_files:
            print("\n" + "="*60)
            print("✅ BUILD SUCCESSFUL!")
            print("="*60)
            print("\n📱 Generated APK files:\n")
            
            for apk in apk_files:
                size = apk.stat().st_size / (1024 * 1024)  # Convert to MB
                print(f"  • {apk.name}")
                print(f"    Size: {size:.1f} MB")
            
            print("\n📌 Recommended for most devices:")
            print("  → app-arm64-v8a-release.apk (64-bit ARM)")
            print("  → app-armeabi-v7a-release.apk (32-bit ARM - compatibility)")
            
            print("\n📋 Installation options:")
            print("  1. Via ADB: adb install build/app/outputs/flutter-apk/app-arm64-v8a-release.apk")
            print("  2. Direct transfer to Android device and tap to install")
            print("  3. Upload to Google Play Store")
            
            return True
    
    return False

def main():
    """Main build process"""
    print("\n🚀 NEONATAL JAUNDICE CALCULATOR - APK BUILD")
    print("="*60)
    
    # Check prerequisites
    if not check_prerequisites():
        print("\n❌ Please install missing prerequisites and try again.")
        sys.exit(1)
    
    # Set up environment
    setup_environment()
    
    # Build APK
    if not build_apk():
        print("\n❌ Build failed. Check errors above.")
        sys.exit(1)
    
    # Show results
    if not show_results():
        print("\n⚠️  Build completed but no APK files found.")
        sys.exit(1)
    
    print("\n" + "="*60)
    print("✅ ALL DONE!")
    print("="*60 + "\n")

if __name__ == "__main__":
    main()

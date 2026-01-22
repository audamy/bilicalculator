# Neonatal Hyperbilirubinemia Calculator - Android App

A Flutter-based Android application for calculating neonatal jaundice thresholds based on AAP 2025 (2022 Revision) and NICE Guidelines.

## Features

- ✅ Gestational age calculation
- ✅ AAP 2025 treatment thresholds with risk factor adjustment
- ✅ NICE Guidelines (CG98) thresholds
- ✅ Neurotoxicity risk factor assessment
- ✅ Dual unit support (mg/dL and μmol/L)
- ✅ Clinical recommendations based on patient bilirubin level
- ✅ Clean, intuitive Material Design UI

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Android SDK
- Android Studio or Visual Studio Code with Flutter extension

### Installation

1. Clone or navigate to the project directory
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Building APK

To build a release APK for distribution:

```bash
flutter build apk --release
```

The APK will be generated at: `build/app/outputs/flutter-apk/app-release.apk`

## Project Structure

```
lib/
├── main.dart              # Entry point
├── models/
│   └── patient_data.dart  # Patient data model
├── services/
│   └── calculator_service.dart  # Calculation logic
└── screens/
    ├── home_screen.dart   # Input screen
    └── results_screen.dart # Results display
```

## Guidelines Implemented

### AAP 2025 (2022 Revision)
- Threshold-based approach for infants ≥35 weeks gestational age
- Risk factor adjustments for neurotoxicity
- Exchange transfusion thresholds

### NICE Guidelines (CG98)
- Applicable for infants ≥23 weeks gestational age
- Gestational age-specific treatment curves
- Linear interpolation for precise thresholds

## Clinical Disclaimer

This calculator is for **educational and clinical decision support purposes only**. Always use clinical judgment and verify results with official guidelines. For official references, consult:

- [AAP 2025 Guidelines](https://publications.aap.org)
- [NICE CG98 Guidelines](https://www.nice.org.uk)

## Author

Developed by Dr. Mahmoud Ahmed

## License

All rights reserved © 2026

import '../models/patient_data.dart';

class CalculatorService {
  // AAP 2025 Thresholds (in mg/dL)
  static const Map<int, double> aapPhototherapyThresholds = {
    24: 7.0,
    25: 7.1,
    26: 7.2,
    27: 7.3,
    28: 7.4,
    29: 7.5,
    30: 8.0,
    31: 8.5,
    32: 9.0,
    33: 9.5,
    34: 10.0,
    35: 10.0,
    36: 11.0,
    37: 12.0,
    38: 13.0,
    39: 14.0,
    40: 15.0,
  };

  static const Map<int, double> aapExchangeThresholds = {
    24: 14.0,
    25: 14.5,
    26: 15.0,
    27: 15.5,
    28: 16.0,
    29: 16.5,
    30: 17.0,
    31: 17.5,
    32: 18.0,
    33: 18.5,
    34: 19.0,
    35: 20.0,
    36: 21.0,
    37: 22.0,
    38: 23.0,
    39: 24.0,
    40: 25.0,
  };

  // NICE Guidelines Thresholds (in μmol/L)
  static const Map<int, double> nicePhototherapyThresholds = {
    24: 120,
    25: 125,
    26: 130,
    27: 135,
    28: 145,
    29: 155,
    30: 160,
    31: 170,
    32: 180,
    33: 190,
    34: 200,
    35: 210,
    36: 220,
    37: 240,
    38: 260,
    39: 280,
    40: 300,
  };

  static const Map<int, double> niceExchangeThresholds = {
    24: 240,
    25: 250,
    26: 270,
    27: 290,
    28: 310,
    29: 330,
    30: 350,
    31: 370,
    32: 390,
    33: 410,
    34: 430,
    35: 450,
    36: 480,
    37: 510,
    38: 540,
    39: 570,
    40: 600,
  };

  static double getAAPPhototherapyThreshold(PatientData data) {
    int ga = data.getTotalGestationalAge() ~/ 7;
    double baseThreshold =
        aapPhototherapyThresholds[ga] ?? aapPhototherapyThresholds[40]!;

    // Reduce threshold if neurotoxicity risk present
    if (data.hasNeurotoxicityRisk()) {
      baseThreshold -= 2.0;
    }

    return baseThreshold;
  }

  static double getAAPExchangeThreshold(PatientData data) {
    int ga = data.getTotalGestationalAge() ~/ 7;
    double baseThreshold =
        aapExchangeThresholds[ga] ?? aapExchangeThresholds[40]!;

    // Reduce threshold if neurotoxicity risk present
    if (data.hasNeurotoxicityRisk()) {
      baseThreshold -= 2.0;
    }

    return baseThreshold;
  }

  static double getNICEPhototherapyThreshold(PatientData data) {
    int ga = data.getTotalGestationalAge() ~/ 7;
    return nicePhototherapyThresholds[ga] ?? nicePhototherapyThresholds[40]!;
  }

  static double getNICEExchangeThreshold(PatientData data) {
    int ga = data.getTotalGestationalAge() ~/ 7;
    return niceExchangeThresholds[ga] ?? niceExchangeThresholds[40]!;
  }

  static String getRecommendation(double tsb, double phototherapyThreshold,
      double exchangeThreshold, String guideline) {
    if (tsb >= exchangeThreshold) {
      return 'URGENT: Exchange transfusion required ($guideline)';
    } else if (tsb >= phototherapyThreshold) {
      return 'Phototherapy required ($guideline)';
    } else {
      return 'Observe and monitor ($guideline)';
    }
  }

  static int getPostnatalAgeInHours(DateTime birthDateTime) {
    final now = DateTime.now();
    final difference = now.difference(birthDateTime);
    return difference.inHours;
  }
}

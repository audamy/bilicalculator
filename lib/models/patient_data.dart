class PatientData {
  int gestationalAgeWeeks;
  int gestationalAgeDays;
  DateTime birthDateTime;
  double bilirubinLevel;
  String bilirubinUnit;
  bool riskIsoimmune;
  bool riskG6PD;
  bool riskAsphyxia;
  bool riskSepsis;
  bool riskAlbumin;
  bool riskInstability;

  PatientData({
    this.gestationalAgeWeeks = 38,
    this.gestationalAgeDays = 0,
    required this.birthDateTime,
    this.bilirubinLevel = 0.0,
    this.bilirubinUnit = 'mgdl',
    this.riskIsoimmune = false,
    this.riskG6PD = false,
    this.riskAsphyxia = false,
    this.riskSepsis = false,
    this.riskAlbumin = false,
    this.riskInstability = false,
  });

  int getTotalGestationalAge() {
    return gestationalAgeWeeks * 7 + gestationalAgeDays;
  }

  bool hasNeurotoxicityRisk() {
    return riskIsoimmune ||
        riskG6PD ||
        riskAsphyxia ||
        riskSepsis ||
        riskAlbumin ||
        riskInstability;
  }

  double getBilirubinInMgdL() {
    if (bilirubinUnit == 'mgdl') {
      return bilirubinLevel;
    } else {
      return bilirubinLevel / 17.1;
    }
  }
}

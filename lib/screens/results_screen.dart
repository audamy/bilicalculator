import 'package:flutter/material.dart';
import '../models/patient_data.dart';
import '../services/calculator_service.dart';

class ResultsScreen extends StatefulWidget {
  final PatientData patientData;

  const ResultsScreen({Key? key, required this.patientData}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late int _selectedTabIndex;

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final aapPhotoThreshold =
        CalculatorService.getAAPPhototherapyThreshold(widget.patientData);
    final aapExchangeThreshold =
        CalculatorService.getAAPExchangeThreshold(widget.patientData);
    final nicePhotoThreshold =
        CalculatorService.getNICEPhototherapyThreshold(widget.patientData);
    final niceExchangeThreshold =
        CalculatorService.getNICEExchangeThreshold(widget.patientData);

    final tsbMgdL = widget.patientData.getBilirubinInMgdL();
    final tsbUmol = tsbMgdL * 17.1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tab Selection
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selectedTabIndex = 0);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedTabIndex == 0
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Text(
                          'AAP 2025',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _selectedTabIndex == 0
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selectedTabIndex = 1);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedTabIndex == 1
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Text(
                          'NICE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _selectedTabIndex == 1
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Content based on selected tab
              if (_selectedTabIndex == 0)
                _buildAAPResults(
                  tsbMgdL,
                  aapPhotoThreshold,
                  aapExchangeThreshold,
                )
              else
                _buildNICEResults(
                  tsbUmol,
                  nicePhotoThreshold,
                  niceExchangeThreshold,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAAPResults(
    double tsbMgdL,
    double photoThreshold,
    double exchangeThreshold,
  ) {
    final recommendation = CalculatorService.getRecommendation(
      tsbMgdL,
      photoThreshold,
      exchangeThreshold,
      'AAP 2025',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildThresholdCard(
          'Phototherapy Threshold',
          '${photoThreshold.toStringAsFixed(1)} mg/dL',
          Colors.orange,
        ),
        const SizedBox(height: 16),
        _buildThresholdCard(
          'Exchange Transfusion Threshold',
          '${exchangeThreshold.toStringAsFixed(1)} mg/dL',
          Colors.red,
        ),
        const SizedBox(height: 24),
        _buildPatientLevelCard(
          'Patient\'s Bilirubin Level',
          '${tsbMgdL.toStringAsFixed(1)} mg/dL',
        ),
        const SizedBox(height: 24),
        _buildRecommendationCard(recommendation),
      ],
    );
  }

  Widget _buildNICEResults(
    double tsbUmol,
    double photoThreshold,
    double exchangeThreshold,
  ) {
    final recommendation = CalculatorService.getRecommendation(
      tsbUmol,
      photoThreshold,
      exchangeThreshold,
      'NICE',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildThresholdCard(
          'Phototherapy Threshold',
          '${photoThreshold.toStringAsFixed(0)} μmol/L',
          Colors.orange,
        ),
        const SizedBox(height: 16),
        _buildThresholdCard(
          'Exchange Transfusion Threshold',
          '${exchangeThreshold.toStringAsFixed(0)} μmol/L',
          Colors.red,
        ),
        const SizedBox(height: 24),
        _buildPatientLevelCard(
          'Patient\'s Bilirubin Level',
          '${tsbUmol.toStringAsFixed(1)} μmol/L',
        ),
        const SizedBox(height: 24),
        _buildRecommendationCard(recommendation),
      ],
    );
  }

  Widget _buildThresholdCard(String label, String value, Color color) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color.withOpacity(0.1),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientLevelCard(String label, String value) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.blue.shade50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(String recommendation) {
    final isUrgent = recommendation.contains('URGENT');
    final isPhototherapy = recommendation.contains('Phototherapy');

    Color backgroundColor = Colors.green.shade50;
    Color borderColor = Colors.green;
    if (isUrgent) {
      backgroundColor = Colors.red.shade50;
      borderColor = Colors.red;
    } else if (isPhototherapy) {
      backgroundColor = Colors.orange.shade50;
      borderColor = Colors.orange;
    }

    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Clinical Recommendation',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              recommendation,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: borderColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

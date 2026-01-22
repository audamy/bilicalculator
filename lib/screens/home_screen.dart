import 'package:flutter/material.dart';
import '../models/patient_data.dart';
import '../services/calculator_service.dart';
import 'results_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PatientData _patientData;
  final _gaWeeksController = TextEditingController(text: '38');
  final _gaDaysController = TextEditingController(text: '0');
  final _bilirubinController = TextEditingController();
  String _bilirubinUnit = 'mgdl';

  @override
  void initState() {
    super.initState();
    _patientData = PatientData(birthDateTime: DateTime.now());
  }

  @override
  void dispose() {
    _gaWeeksController.dispose();
    _gaDaysController.dispose();
    _bilirubinController.dispose();
    super.dispose();
  }

  void _calculateAndNavigate() {
    // Validate input
    if (_bilirubinController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter bilirubin level')),
      );
      return;
    }

    // Update patient data
    _patientData = PatientData(
      gestationalAgeWeeks: int.parse(_gaWeeksController.text),
      gestationalAgeDays: int.parse(_gaDaysController.text),
      birthDateTime: DateTime.now(),
      bilirubinLevel: double.parse(_bilirubinController.text),
      bilirubinUnit: _bilirubinUnit,
      riskIsoimmune: _patientData.riskIsoimmune,
      riskG6PD: _patientData.riskG6PD,
      riskAsphyxia: _patientData.riskAsphyxia,
      riskSepsis: _patientData.riskSepsis,
      riskAlbumin: _patientData.riskAlbumin,
      riskInstability: _patientData.riskInstability,
    );

    // Navigate to results screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(patientData: _patientData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neonatal Jaundice Calculator'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Neonatal Hyperbilirubinemia Calculator',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Based on AAP 2025 & NICE Guidelines',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Patient Information Section
              const Text(
                'Patient Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Gestational Age
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _gaWeeksController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Weeks',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _gaDaysController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Days',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Bilirubin Level
              TextField(
                controller: _bilirubinController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Total Serum Bilirubin (TSB)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButton<String>(
                      value: _bilirubinUnit,
                      underline: Container(),
                      onChanged: (value) {
                        setState(() {
                          _bilirubinUnit = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'mgdl',
                          child: Text('mg/dL'),
                        ),
                        DropdownMenuItem(
                          value: 'umol',
                          child: Text('μmol/L'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Risk Factors Section
              const Text(
                'Neurotoxicity Risk Factors',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              CheckboxListTile(
                title: const Text('Isoimmune hemolytic disease'),
                value: _patientData.riskIsoimmune,
                onChanged: (value) {
                  setState(() {
                    _patientData.riskIsoimmune = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('G6PD deficiency'),
                value: _patientData.riskG6PD,
                onChanged: (value) {
                  setState(() {
                    _patientData.riskG6PD = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Asphyxia'),
                value: _patientData.riskAsphyxia,
                onChanged: (value) {
                  setState(() {
                    _patientData.riskAsphyxia = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Significant lethargy/Sepsis'),
                value: _patientData.riskSepsis,
                onChanged: (value) {
                  setState(() {
                    _patientData.riskSepsis = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Albumin < 3.0 g/dL'),
                value: _patientData.riskAlbumin,
                onChanged: (value) {
                  setState(() {
                    _patientData.riskAlbumin = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Clinical instability in last 24h'),
                value: _patientData.riskInstability,
                onChanged: (value) {
                  setState(() {
                    _patientData.riskInstability = value!;
                  });
                },
              ),
              const SizedBox(height: 32),

              // Calculate Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _calculateAndNavigate,
                  child: const Text(
                    'Calculate Thresholds',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const NeonatalJaundiceApp());
}

class NeonatalJaundiceApp extends StatelessWidget {
  const NeonatalJaundiceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neonatal Jaundice Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

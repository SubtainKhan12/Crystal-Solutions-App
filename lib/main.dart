import 'package:crystal_solutions/HHH/Login/loginScreen.dart';
import 'package:flutter/material.dart';

import 'Office Panel/officeDashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff111441)),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

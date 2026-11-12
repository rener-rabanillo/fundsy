import 'package:flutter/material.dart';
import 'package:fundsy/app/themes/app_themes.dart';
import 'package:fundsy/features/auth/presentation/pages/welcome_screen.dart'; // Import ang WelcomeScreen

class Fundsy extends StatelessWidget {
  const Fundsy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fundsy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomeScreen(), // Dito magsisimula ang app
    );
  }
}
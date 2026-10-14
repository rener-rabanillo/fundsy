import 'package:flutter/material.dart';
import 'package:fundsy/app/themes/app_themes.dart';
import 'package:fundsy/features/dashboard/presentation/pages/dashboard_page.dart';

class Fundsy extends StatelessWidget {
  const Fundsy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fundsy',
      home: const DashboardScreen(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}

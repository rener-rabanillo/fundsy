import 'package:flutter/material.dart';
import 'package:fundsy/app/themes/app_colors.dart';
import 'package:fundsy/app/themes/app_typography.dart';
import 'package:fundsy/app/themes/app_components.dart';

abstract final class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onSurfaceVariant,
    ),
    textTheme: AppTypography.typography,
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    appBarTheme: AppComponents.appBarThemeData,
    bottomNavigationBarTheme: AppComponents.bottomNavigationBarThemeData,
    floatingActionButtonTheme: AppComponents.floatingActionButtonThemeData,
    iconTheme: AppComponents.iconThemeData,
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      surface: AppColors.darkSurface,
      onSurface: AppColors.onDarkSurface,
      onSurfaceVariant: AppColors.onDarkSurfaceVariant,
    ),
    textTheme: AppTypography.typography,
    scaffoldBackgroundColor: AppColors.darkScaffoldBackground,
    appBarTheme: AppComponents.darkAppBarThemeData,
    bottomNavigationBarTheme: AppComponents.darkBottomNavigationBarThemeData,
    floatingActionButtonTheme: AppComponents.darkFloatingActionButtonThemeData,
    iconTheme: AppComponents.darkIconThemeData,
  );
}

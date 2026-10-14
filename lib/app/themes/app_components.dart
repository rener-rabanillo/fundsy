import 'package:flutter/material.dart';
import 'package:fundsy/app/themes/app_colors.dart';
import 'package:fundsy/app/themes/app_typography.dart';

abstract final class AppComponents {
  static final appBarThemeData = AppBarThemeData(
    backgroundColor: AppColors.scaffoldBackground,
    foregroundColor: AppColors.onSurface,
    elevation: 0.0,
    scrolledUnderElevation: 0.0,
    surfaceTintColor: Colors.transparent,
    toolbarTextStyle: AppTypography.typography.bodyMedium?.copyWith(
      color: AppColors.onSurface,
    ),
    titleTextStyle: AppTypography.typography.titleLarge?.copyWith(
      color: AppColors.onSurface,
    ),
  );

  static final darkAppBarThemeData = appBarThemeData.copyWith(
    backgroundColor: AppColors.darkScaffoldBackground,
    foregroundColor: AppColors.onDarkSurface,
    toolbarTextStyle: AppTypography.typography.bodyMedium?.copyWith(
      color: AppColors.onDarkSurface,
    ),
    titleTextStyle: AppTypography.typography.titleLarge?.copyWith(
      color: AppColors.onDarkSurface,
    ),
  );

  static final bottomNavigationBarThemeData = BottomNavigationBarThemeData(
    backgroundColor: AppColors.scaffoldBackground,
    elevation: 0.0,
    selectedIconTheme: IconThemeData(
      size: 32.0,
      opticalSize: 32.0
    ),
    unselectedIconTheme: IconThemeData(
      size: 32.0,
      opticalSize: 32.0
    ),
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.onDarkSurfaceVariant,
    selectedLabelStyle: AppTypography.typography.labelSmall?.copyWith(
      fontWeight: FontWeight.w500
    ),
    unselectedLabelStyle: AppTypography.typography.labelSmall?.copyWith(
      fontWeight: FontWeight.w400
    ),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  );

  static final darkBottomNavigationBarThemeData = bottomNavigationBarThemeData.copyWith(
    backgroundColor: AppColors.darkScaffoldBackground,
    selectedItemColor: AppColors.onDarkSurface,
    unselectedItemColor: AppColors.onSurfaceVariant,
  );

  static final floatingActionButtonThemeData = FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
    shape: CircleBorder(),
    iconSize: 32.0,
  );

  static final darkFloatingActionButtonThemeData = floatingActionButtonThemeData.copyWith(
    backgroundColor: AppColors.onDarkSurface,
    foregroundColor: AppColors.darkScaffoldBackground,
  );

  static final iconThemeData = IconThemeData(
    size: 24.0,
    fill: 0.0,
    opticalSize: 24.0,
    color: AppColors.onSurface,
  );

  static final darkIconThemeData = iconThemeData.copyWith(
    color: AppColors.onDarkSurface,
  );
}

import 'package:flutter/material.dart';
import 'package:fundsy/app/themes/app_colors.dart';
import 'package:fundsy/app/themes/app_typography.dart';

abstract final class AppComponents {
  //
  // App Bar Light Theme
  //
  static final appBarThemeData = AppBarThemeData(
    backgroundColor: AppColors.scaffoldBackground,
    foregroundColor: AppColors.onSurface,
    elevation: 0.0,
    scrolledUnderElevation: 0.0,
    surfaceTintColor: Colors.transparent,
    toolbarTextStyle: AppTypography.typography.bodyMedium!.copyWith(
      color: AppColors.onSurface,
    ),
    titleTextStyle: AppTypography.typography.titleMedium!.copyWith(
      color: AppColors.onSurface,
    ),
  );
  //
  // App Bar Dark Theme
  //
  static final darkAppBarThemeData = appBarThemeData.copyWith(
    backgroundColor: AppColors.darkScaffoldBackground,
    foregroundColor: AppColors.onDarkSurface,
    toolbarTextStyle: AppTypography.typography.bodyMedium!.copyWith(
      color: AppColors.onDarkSurface,
    ),
    titleTextStyle: AppTypography.typography.titleMedium!.copyWith(
      color: AppColors.onDarkSurface,
    ),
  );
  //
  // Navigation Bar Light Theme
  //
  static final navigationBarThemeData = NavigationBarThemeData(
    backgroundColor: AppColors.scaffoldBackground,
    elevation: 0.0,
    indicatorColor: AppColors.primary,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.0),
    ),
    labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppTypography.typography.labelSmall!.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        );
      }
      return AppTypography.typography.labelSmall!.copyWith(
        fontWeight: FontWeight.w400,
        color: AppColors.onSurfaceVariant,
      );
    }),
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return IconThemeData(
          color: AppColors.onPrimary,
        );
      }
      return IconThemeData(
        color: AppColors.onSurfaceVariant,
      );
    }),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
  );
  //
  // Navigation Bar Dark Theme
  //
  static final darkNavigationBarThemeData = navigationBarThemeData.copyWith(
    backgroundColor: AppColors.darkScaffoldBackground,
    indicatorColor: AppColors.onDarkSurface,
    labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppTypography.typography.labelSmall!.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.onDarkSurface,
        );
      }
      return AppTypography.typography.labelSmall!.copyWith(
        fontWeight: FontWeight.w400,
        color: AppColors.onDarkSurfaceVariant,
      );
    }),
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return IconThemeData(
          color: AppColors.darkScaffoldBackground,
        );
      }
      return IconThemeData(
        color: AppColors.onDarkSurfaceVariant,
      );
    }),
  );
  //
  // Floating Action Button Light Theme
  //
  static final floatingActionButtonThemeData = FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
    shape: CircleBorder(),
    iconSize: 32.0,
  );
  //
  // Floating Action Button Dark Theme
  //
  static final darkFloatingActionButtonThemeData = floatingActionButtonThemeData.copyWith(
    backgroundColor: AppColors.onDarkSurface,
    foregroundColor: AppColors.darkScaffoldBackground,
  );
  //
  // Icon Light Theme
  //
  static final iconThemeData = IconThemeData(
    size: 24.0,
    fill: 0.0,
    opticalSize: 24.0,
    color: AppColors.onSurface,
  );
  //
  // Icon Dark Theme
  //
  static final darkIconThemeData = iconThemeData.copyWith(
    color: AppColors.onDarkSurface,
  );
}

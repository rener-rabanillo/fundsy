import 'package:flutter/material.dart';

abstract final class AppTypography {
  static const typography = TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 32.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 28.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 24.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 22.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w300,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 11.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w300,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 10.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w300,
    ),
  );
}

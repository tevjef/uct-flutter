import 'package:flutter/material.dart';

class Styles {
  static TextStyle body1Secondary = new TextStyle(
      color: Colors.black54,
      fontSize: 10.0,
      fontStyle: FontStyle.italic,
      fontFamily: "ProductSans");

  static TextStyle caption =
      new TextStyle(fontFamily: "ProductSans", fontWeight: FontWeight.bold);

  static TextStyle sectionHeader = new TextStyle(
      color: Colors.black,
      letterSpacing: 0.6,
      fontSize: 12.toDouble(),
      fontFamily: "ProductSans",
      fontWeight: FontWeight.bold);
}

class AppColors {
  static MaterialColor white = MaterialColor(0xFFFFFFFF, <int, Color>{
    50: const Color(0xFFFAFAFA),
    100: const Color(0xFFF5F5F5),
    200: const Color(0xFFEEEEEE),
    300: const Color(0xFFE0E0E0),
    350: const Color(
        0xFFD6D6D6), // only for raised button while pressed in light theme
    400: const Color(0xFFBDBDBD),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFF757575),
    700: const Color(0xFF616161),
    800: const Color(0xFF424242),
    850: const Color(0xFF303030), // only for background color in dark theme
    900: const Color(0xFF212121),
  });
}

class Dimens {
  static double spacingNone = 0.0;
  static double spacingXthin = 1.0;
  static double spacingThin = 2.0;
  static double spacingXsmall = 4.0;
  static double spacingSmall = 8.0;
  static double spacingMedium = 12.0;
  static double spacingStandard = 16.0;
  static double spacingLarge = 20.0;
  static double spacingXlarge = 24.0;
  static double spacingXxlarge = 36.0;
  static double spacingXxxlarge = 48.0;
}

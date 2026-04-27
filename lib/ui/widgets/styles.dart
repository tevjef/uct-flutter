import 'package:flutter/material.dart';

class AppColors {
  static Color uctGreen = const Color(0x004caf50);
  static Color uctRed = const Color(0x00f44336);

  static MaterialColor white = const MaterialColor(0xFFFFFFFF, <int, Color>{
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF5F5F5),
    200: Color(0xFFEEEEEE),
    300: Color(0xFFE0E0E0),
    350: Color(
        0xFFD6D6D6), // only for raised button while pressed in light theme
    400: Color(0xFFBDBDBD),
    500: Color(0xFFFFFFFF),
    600: Color(0xFF757575),
    700: Color(0xFF616161),
    800: Color(0xFF424242),
    850: Color(0xFF303030), // only for background color in dark theme
    900: Color(0xFF212121),
  });
}

class Dimens {
  static const double spacingNone = 0.0;
  static const double spacingXthin = 1.0;
  static const double spacingThin = 2.0;
  static const double spacingXsmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 12.0;
  static const double spacingStandard = 16.0;
  static const double spacingLarge = 20.0;
  static const double spacingXlarge = 24.0;
  static const double spacingXxlarge = 36.0;
  static const double spacingXxxlarge = 48.0;
}

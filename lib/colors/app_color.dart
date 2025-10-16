import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFD34823);
  static const Color primaryDark = Color(0xFFB8371E);
  static const Color primaryLight = Color(0xFFE87454);

  // Service Card Colors
  static const Color orangeService = Color(0xFFE87454);
  static const Color blueService = Color(0xFF4FA9D8);
  static const Color redService = Color(0xFFD85454);

  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color searchBackground = Color(0xFFF5F5F5);

  // Text Colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textHint = Color(0xFFBDBDBD);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryDark, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient orangeGradient = LinearGradient(
    colors: [orangeService, Color(0xFFE87454)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [blueService, Color(0xFF4FA9D8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient redGradient = LinearGradient(
    colors: [redService, Color(0xFFD85454)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow Colors
  static Color primaryShadow = primary.withOpacity(0.3);
  static Color orangeShadow = orangeService.withOpacity(0.3);
  static Color blueShadow = blueService.withOpacity(0.3);
  static Color redShadow = redService.withOpacity(0.3);
  static Color blackShadow = Colors.black.withOpacity(0.05);

  // Helper method to create gradient with opacity
  static LinearGradient createGradient(Color color) {
    return LinearGradient(
      colors: [color, color.withOpacity(0.8)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
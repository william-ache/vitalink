import 'package:flutter/material.dart';

/// Senior Configuration Class
/// Allows global control over font sizes and button spacing.
class AppConfig {
  static const String appName = 'VITALINK';

  // Senior Mode: Scaling factors
  static final ValueNotifier<double> scaleNotifier = ValueNotifier(1.0);

  static double get fontScale => scaleNotifier.value;
  static double get spacingScale => scaleNotifier.value;

  // Method to toggle Senior Mode
  static void toggleSeniorMode(bool enabled) {
    scaleNotifier.value = enabled ? 1.5 : 1.0; // Increased to 1.5 for better balance
  }

  // Dimension utilities
  static double get fontSizeMultiplier => scaleNotifier.value;
  static double get paddingMultiplier => scaleNotifier.value;

  // Specific spacing constants
  static const double basePadding = 16.0;
  static double get dynamicPadding => basePadding * scaleNotifier.value;

  static const double baseButtonHeight = 56.0;
  static double get dynamicButtonHeight => baseButtonHeight * scaleNotifier.value;
}

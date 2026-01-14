import 'package:flutter/material.dart';
import 'color_palettes.dart';

class SaintColors {
  static const Color primary = NatureColors.green;
  static const Color secondary = NatureColors.lightGreen;
  static const Color background = NatureColors.bone;
  static const Color foreground = NatureColors.darkGreen;
  static const Color surface = NatureColors.lightGray;
  static const Color contrast = NatureColors.gold;

  static const Color error = WarmColors.red;
  static const Color success = WarmColors.green;
}

ColorScheme getColorScheme(Brightness brightness) {
  return ColorScheme.fromSeed(
    seedColor: SaintColors.primary,
    brightness: brightness,
    primary: SaintColors.primary,
    onPrimary: SaintColors.background,
    secondary: SaintColors.secondary,
    onSecondary: SaintColors.contrast,
    surface: SaintColors.secondary,
    onSurface: SaintColors.contrast,
    error: SaintColors.error,
    onError: Colors.white,
  );
}
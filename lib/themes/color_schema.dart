import 'package:flutter/material.dart';
import 'color_palettes.dart';

class SaintColors {
  static const Color primary = DreamPalette.deepPurple;
  static const Color secondary = DreamPalette.lightPurple;
  static const Color background = DreamPalette.ivory;
  static const Color foreground = DreamPalette.charcoal;
  static const Color surface = DreamPalette.lightGray;
  static const Color contrast = DreamPalette.plum;

  static const Color error = DreamPalette.errorRed;
  static const Color success = DreamPalette.successGreen;
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
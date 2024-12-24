// Define color scheme for dark mode
import 'package:flutter/material.dart';
import 'package:flutter_receipt/config/themes/app_pallete.dart';

ColorScheme darkColorScheme() {
  return ColorScheme.dark(
    primary: AppPallete.primaryDark,
    onPrimary: AppPallete.onPrimaryDark,
    secondary: AppPallete.secondaryDark,
    onSecondary: AppPallete.onSecondaryDark,
    error: AppPallete.errorDark,
    onError: AppPallete.onErrorDark,
    surface: AppPallete.backgroundDark,
    onSurface: AppPallete.onBackgroundDark,
  );
}

// Define color scheme for light mode
ColorScheme lightColorScheme() {
  return ColorScheme.light(
    primary: AppPallete.primaryLight,
    onPrimary: AppPallete.onPrimaryLight,
    secondary: AppPallete.secondaryLight,
    onSecondary: AppPallete.onSecondaryLight,
    error: AppPallete.errorLight,
    onError: AppPallete.onErrorLight,
    surface: AppPallete.backgroundLight,
    onSurface: AppPallete.onBackgroundLight,
  );
}

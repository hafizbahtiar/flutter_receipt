// Define color scheme for dark mode
import 'package:flutter/material.dart';

ColorScheme colorSchema(bool isDarkMode) {
  final lightColors = LightColorScheme();
  final darkColors = DarkColorScheme();

  return ColorScheme(
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    primary: isDarkMode ? DarkColorScheme().primary : LightColorScheme().primary,
    onPrimary: isDarkMode ? darkColors.onPrimary : lightColors.onPrimary,
    primaryContainer: isDarkMode ? darkColors.primaryContainer : lightColors.primaryContainer,
    onPrimaryContainer: isDarkMode ? darkColors.onPrimaryContainer : lightColors.onPrimaryContainer,
    secondary: isDarkMode ? darkColors.secondary : lightColors.secondary,
    onSecondary: isDarkMode ? darkColors.onSecondary : lightColors.onSecondary,
    secondaryContainer: isDarkMode ? darkColors.secondaryContainer : lightColors.secondaryContainer,
    onSecondaryContainer: isDarkMode ? darkColors.onSecondaryContainer : lightColors.onSecondaryContainer,
    tertiary: isDarkMode ? darkColors.tertiary : lightColors.tertiary,
    onTertiary: isDarkMode ? darkColors.onTertiary : lightColors.onTertiary,
    tertiaryContainer: isDarkMode ? darkColors.tertiaryContainer : lightColors.tertiaryContainer,
    onTertiaryContainer: isDarkMode ? darkColors.onTertiaryContainer : lightColors.onTertiaryContainer,
    error: isDarkMode ? darkColors.error : lightColors.error,
    onError: isDarkMode ? darkColors.onError : lightColors.onError,
    errorContainer: isDarkMode ? darkColors.errorContainer : lightColors.errorContainer,
    onErrorContainer: isDarkMode ? darkColors.onErrorContainer : lightColors.onErrorContainer,
    surface: isDarkMode ? darkColors.surface : lightColors.surface,
    onSurface: isDarkMode ? darkColors.onSurface : lightColors.onSurface,
    onSurfaceVariant: isDarkMode ? darkColors.onSurfaceVariant : lightColors.onSurfaceVariant,
    inverseSurface: isDarkMode ? darkColors.inverseSurface : lightColors.inverseSurface,
    onInverseSurface: isDarkMode ? darkColors.inverseOnSurface : lightColors.inverseOnSurface,
    outline: isDarkMode ? darkColors.outline : lightColors.outline,
    outlineVariant: isDarkMode ? darkColors.outlineVariant : lightColors.outlineVariant,
    surfaceTint: isDarkMode ? darkColors.surfaceTint : lightColors.surfaceTint,
    inversePrimary: isDarkMode ? darkColors.inversePrimary : lightColors.inversePrimary,
    surfaceBright: isDarkMode ? darkColors.surfaceBright : lightColors.surfaceBright,
    surfaceContainer: isDarkMode ? darkColors.surfaceContainer : lightColors.surfaceContainer,
    surfaceDim: isDarkMode ? darkColors.surfaceDim : lightColors.surfaceDim,
    surfaceContainerHigh: isDarkMode ? darkColors.surfaceContainerHigh : lightColors.surfaceContainerHigh,
    surfaceContainerHighest: isDarkMode ? darkColors.surfaceContainerHighest : lightColors.surfaceContainerHighest,
    surfaceContainerLow: isDarkMode ? darkColors.surfaceContainerLow : lightColors.surfaceContainerLow,
    surfaceContainerLowest: isDarkMode ? darkColors.surfaceContainerLowest : lightColors.surfaceContainerLowest,
  );
}

class LightColorScheme {
  final Color primary = const Color(0xFF1565C0); // Blue
  final Color onPrimary = const Color(0xFFFFFFFF); // White for contrast
  final Color inversePrimary = const Color(0xFF90CAF9); // Light Blue
  final Color primaryContainer = const Color(0xFFBBDEFB); // Light Blue Container
  final Color onPrimaryContainer = const Color(0xFF002F6C); // Dark Blue

  final Color secondary = const Color(0xFF6D4C41); // Brown for contrast
  final Color onSecondary = const Color(0xFFFFFFFF);
  final Color secondaryContainer = const Color(0xFFD7CCC8);
  final Color onSecondaryContainer = const Color(0xFF3E2723);

  final Color tertiary = const Color(0xFF00897B); // Teal
  final Color onTertiary = const Color(0xFFFFFFFF);
  final Color tertiaryContainer = const Color(0xFFA7FFEB);
  final Color onTertiaryContainer = const Color(0xFF004D40);

  final Color error = const Color(0xFFB3261E);
  final Color onError = const Color(0xFFFFFFFF);
  final Color errorContainer = const Color(0xFFF9DEDC);
  final Color onErrorContainer = const Color(0xFF8C1D18);

  final Color surface = const Color(0xFFFFFFFF); // White
  final Color onSurface = const Color(0xFF1D1B20); // Dark Grey
  final Color onSurfaceVariant = const Color(0xFF49454F);
  final Color surfaceContainerHighest = const Color(0xFFE6E0E9);
  final Color surfaceContainerHigh = const Color(0xFFECE6F0);
  final Color surfaceContainer = const Color(0xFFF3EDF7);
  final Color surfaceContainerLow = const Color(0xFFF7F2FA);
  final Color surfaceContainerLowest = const Color(0xFFFFFFFF);
  final Color inverseSurface = const Color(0xFF322F35);
  final Color inverseOnSurface = const Color(0xFFF5EFF7);
  final Color surfaceTint = const Color(0xFF1565C0); // Blue Tint

  final Color outline = const Color(0xFF79747E);
  final Color outlineVariant = const Color(0xFFCAC4D0);
  final Color surfaceBright = const Color(0xFFFFFFFF); // White
  final Color surfaceDim = const Color(0xFFE7E0EC);
}

class DarkColorScheme {
  final Color primary = const Color(0xFF90CAF9); // Light Blue
  final Color onPrimary = const Color(0xFF002F6C); // Dark Blue for contrast
  final Color inversePrimary = const Color(0xFF1565C0); // Blue
  final Color primaryContainer = const Color(0xFF0D47A1); // Dark Blue Container
  final Color onPrimaryContainer = const Color(0xFFBBDEFB); // Light Blue

  final Color secondary = const Color(0xFF8D6E63); // Brown
  final Color onSecondary = const Color(0xFF3E2723);
  final Color secondaryContainer = const Color(0xFF5D4037);
  final Color onSecondaryContainer = const Color(0xFFD7CCC8);

  final Color tertiary = const Color(0xFF4DB6AC); // Teal
  final Color onTertiary = const Color(0xFF004D40);
  final Color tertiaryContainer = const Color(0xFF00695C);
  final Color onTertiaryContainer = const Color(0xFFA7FFEB);

  final Color error = const Color(0xFFF2B8B5);
  final Color onError = const Color(0xFF601410);
  final Color errorContainer = const Color(0xFF8C1D18);
  final Color onErrorContainer = const Color(0xFFF9DEDC);

  final Color surface = const Color(0xFF121212); // Dark Grey
  final Color onSurface = const Color(0xFFE6E1E5); // Light Grey
  final Color onSurfaceVariant = const Color(0xFFCAC4D0);
  final Color surfaceContainerHighest = const Color(0xFF1C1C1C);
  final Color surfaceContainerHigh = const Color(0xFF232323);
  final Color surfaceContainer = const Color(0xFF282828);
  final Color surfaceContainerLow = const Color(0xFF2F2F2F);
  final Color surfaceContainerLowest = const Color(0xFF121212);
  final Color inverseSurface = const Color(0xFFE6E1E5);
  final Color inverseOnSurface = const Color(0xFF1C1C1C);
  final Color surfaceTint = const Color(0xFF90CAF9); // Light Blue Tint

  final Color outline = const Color(0xFF938F99);
  final Color outlineVariant = const Color(0xFF49454F);
  final Color surfaceBright = const Color(0xFF121212);
  final Color surfaceDim = const Color(0xFF1C1C1C);
}

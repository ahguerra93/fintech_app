import 'package:flutter/material.dart';
import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/app_text_styles.dart';

/// Ready-to-use [ThemeData] instances for [MaterialApp].
///
/// ```dart
/// MaterialApp(
///   theme:      AppTheme.light,
///   darkTheme:  AppTheme.dark,
/// )
/// ```
abstract final class AppTheme {
  static ThemeData get light => _base(
    brightness: Brightness.light,
    colorExtension: AppColorTheme.light,
    scaffoldBackground: AppColors.background,
    cardColor: AppColors.surface,
    dividerColor: AppColors.border,
    textTheme: AppTextStyles.light,
  );

  static ThemeData get dark => _base(
    brightness: Brightness.dark,
    colorExtension: AppColorTheme.dark,
    scaffoldBackground: AppColorTheme.dark.background,
    cardColor: AppColorTheme.dark.surface,
    dividerColor: AppColorTheme.dark.border,
    textTheme: AppTextStyles.dark,
  );

  static ThemeData _base({
    required Brightness brightness,
    required AppColorTheme colorExtension,
    required Color scaffoldBackground,
    required Color cardColor,
    required Color dividerColor,
    required TextTheme textTheme,
  }) {
    return ThemeData(
      brightness: brightness,
      extensions: [colorExtension],
      scaffoldBackgroundColor: scaffoldBackground,
      cardColor: cardColor,
      dividerColor: dividerColor,
      textTheme: textTheme,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: colorExtension.primary,
        onPrimary: Colors.white,
        primaryContainer: colorExtension.primaryContainer,
        onPrimaryContainer: colorExtension.primaryDark,
        secondary: colorExtension.softAccent,
        onSecondary: colorExtension.primaryDark,
        secondaryContainer: colorExtension.mutedSurfaceAccent,
        onSecondaryContainer: colorExtension.primaryDark,
        surface: colorExtension.surface,
        onSurface: colorExtension.primaryDark,
        error: const Color(0xFFBA1A1A),
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorExtension.surface,
        foregroundColor: colorExtension.primaryDark,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.headlineLarge,
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: dividerColor),
        ),
      ),
      dividerTheme: DividerThemeData(color: dividerColor, space: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorExtension.surfaceSoft,
        hintStyle: textTheme.bodyLarge?.copyWith(color: colorExtension.primaryDark.withValues(alpha: 0.4)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorExtension.primary, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorExtension.primary,
          foregroundColor: Colors.white,
          textStyle: AppTextStyles.labelLargeOnPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: colorExtension.primary, textStyle: textTheme.labelLarge),
      ),
    );
  }
}

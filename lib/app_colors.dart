import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Static constants — use these directly if you have a single fixed theme.
// -----------------------------------------------------------------------------

/// Static color palette for the Fintech app.
///
/// Brand colors — used for interactive elements, headings, and data visuals.
/// Neutral foundation — used for backgrounds, surfaces, and structural UI.
abstract final class AppColors {
  // Brand colors
  static const Color primary = Color(0xFF007EA7);
  static const Color primaryDark = Color(0xFF003249);
  static const Color primaryContainer = Color(0xFF64C3CE);
  static const Color softAccent = Color(0xFF9AD1D4);
  static const Color mutedSurfaceAccent = Color(0xFFCCDCDC);

  // Neutral foundation
  static const Color background = Color(0xFFF8FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSoft = Color(0xFFF1F5F7);
  static const Color border = Color(0xFFE5ECEF);

  // Typography colors
  /// #003249 — Headings, amounts, tab labels.
  static const Color textPrimary = Color(0xFF003249);

  /// #5B6B73 — Balance labels, dates, metadata.
  static const Color textSecondary = Color(0xFF5B6B73);

  /// #FFFFFF — Text on primary-colored surfaces (buttons, dark cards).
  static const Color textOnPrimary = Color(0xFFFFFFFF);
}

// -----------------------------------------------------------------------------
// ThemeExtension — use this if you want Theme.of(context) integration while
// keeping the same direct, named access: context.colors.primary
// -----------------------------------------------------------------------------

/// Extend this to support dark mode, white-labeling, or per-tenant theming
/// without changing call sites.
///
/// Register it once in your [MaterialApp]:
/// ```dart
/// theme: ThemeData(
///   extensions: [AppColorTheme.light],
/// ),
/// darkTheme: ThemeData(
///   extensions: [AppColorTheme.dark],
/// ),
/// ```
///
/// Then access anywhere via the extension getter:
/// ```dart
/// context.colors.primary
/// ```
@immutable
class AppColorTheme extends ThemeExtension<AppColorTheme> {
  const AppColorTheme({
    required this.primary,
    required this.primaryDark,
    required this.primaryContainer,
    required this.softAccent,
    required this.mutedSurfaceAccent,
    required this.background,
    required this.surface,
    required this.surfaceSoft,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
  });

  final Color primary;
  final Color primaryDark;
  final Color primaryContainer;
  final Color softAccent;
  final Color mutedSurfaceAccent;
  final Color background;
  final Color surface;
  final Color surfaceSoft;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;

  // Built-in light theme — mirrors AppColors exactly.
  static const AppColorTheme light = AppColorTheme(
    primary: AppColors.primary,
    primaryDark: AppColors.primaryDark,
    primaryContainer: AppColors.primaryContainer,
    softAccent: AppColors.softAccent,
    mutedSurfaceAccent: AppColors.mutedSurfaceAccent,
    background: AppColors.background,
    surface: AppColors.surface,
    surfaceSoft: AppColors.surfaceSoft,
    border: AppColors.border,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
  );

  // Stub dark theme — swap in your dark-mode values when ready.
  static const AppColorTheme dark = AppColorTheme(
    primary: Color(0xFF4DB8D4),
    primaryDark: Color(0xFF9AD1D4),
    primaryContainer: Color(0xFF005F73),
    softAccent: Color(0xFF2A7E8A),
    mutedSurfaceAccent: Color(0xFF1E3A3F),
    background: Color(0xFF0D1B1E),
    surface: Color(0xFF132226),
    surfaceSoft: Color(0xFF1A2D32),
    border: Color(0xFF243C42),
    textPrimary: Color(0xFFE0EEF2),
    textSecondary: Color(0xFF8FA4AC),
  );

  @override
  AppColorTheme copyWith({
    Color? primary,
    Color? primaryDark,
    Color? primaryContainer,
    Color? softAccent,
    Color? mutedSurfaceAccent,
    Color? background,
    Color? surface,
    Color? surfaceSoft,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
  }) {
    return AppColorTheme(
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      softAccent: softAccent ?? this.softAccent,
      mutedSurfaceAccent: mutedSurfaceAccent ?? this.mutedSurfaceAccent,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceSoft: surfaceSoft ?? this.surfaceSoft,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
    );
  }

  /// Flutter calls this when animating between themes (e.g. light ↔ dark).
  @override
  AppColorTheme lerp(AppColorTheme? other, double t) {
    if (other == null) return this;
    return AppColorTheme(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      primaryContainer: Color.lerp(primaryContainer, other.primaryContainer, t)!,
      softAccent: Color.lerp(softAccent, other.softAccent, t)!,
      mutedSurfaceAccent: Color.lerp(mutedSurfaceAccent, other.mutedSurfaceAccent, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSoft: Color.lerp(surfaceSoft, other.surfaceSoft, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
    );
  }
}

// -----------------------------------------------------------------------------
// Convenience extension — keeps call sites short: context.colors.primary
// -----------------------------------------------------------------------------

extension AppColorThemeContext on BuildContext {
  AppColorTheme get colors => Theme.of(this).extension<AppColorTheme>() ?? AppColorTheme.light;
}

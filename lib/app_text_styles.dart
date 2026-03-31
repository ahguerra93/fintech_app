import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fintech_app/app_colors.dart';

/// Centralized typography system.
///
/// Each style maps to a semantic role in the UI — think in terms of purpose,
/// not arbitrary font sizes.
///
/// Usage:
/// ```dart
/// Text('$864,759.00', style: AppTextStyles.displayLarge)
/// Text('Dashboard',   style: AppTextStyles.headlineLarge)
/// ```
///
/// Or via the text theme registered in [AppTheme]:
/// ```dart
/// Theme.of(context).textTheme.displayLarge
/// ```
abstract final class AppTextStyles {
  // ---------------------------------------------------------------------------
  // Light text styles (default)
  // ---------------------------------------------------------------------------

  /// 32 / 700 — Current balance, account totals, transfer amounts.
  static TextStyle get displayLarge =>
      GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5, color: AppColors.textPrimary);

  /// 24 / 700 — Screen titles: Home, Analysis, Cards, Profile.
  static TextStyle get headlineLarge =>
      GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary);

  /// 18 / 600 — Section titles: Recent Expenses, Goals, Cards.
  static TextStyle get titleLarge =>
      GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary);

  /// 16 / 600 — Card labels, transaction titles: Debit Card, Netflix.
  static TextStyle get titleMedium =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary);

  /// 14 / 400 — Descriptions, subtitles, labels.
  static TextStyle get bodyLarge =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textPrimary);

  /// 12 / 400 — Timestamps, account numbers, helper text.
  static TextStyle get bodySmall =>
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textSecondary);

  /// 14 / 600 — Button labels: Transfer, Continue, Pay Now.
  static TextStyle get labelLarge =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary);

  // ---------------------------------------------------------------------------
  // Helpers for text-on-primary surfaces (buttons, dark cards)
  // ---------------------------------------------------------------------------

  /// [labelLarge] in white — for text inside primary-colored buttons.
  static TextStyle get labelLargeOnPrimary => labelLarge.copyWith(color: AppColors.textOnPrimary);

  /// [bodyLarge] in white — for body copy on dark surfaces.
  static TextStyle get bodyLargeOnPrimary => bodyLarge.copyWith(color: AppColors.textOnPrimary);

  // ---------------------------------------------------------------------------
  // TextTheme builders used by AppTheme
  // ---------------------------------------------------------------------------

  /// Light [TextTheme] wired into [AppTheme.light].
  static TextTheme buildTextTheme({required Color textPrimary, required Color textSecondary}) {
    return TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: textPrimary,
      ),
      headlineLarge: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700, color: textPrimary),
      titleLarge: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary),
      titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: textPrimary),
      bodyLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: textPrimary),
      bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: textSecondary),
      labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: textPrimary),
    );
  }

  static final TextTheme light = buildTextTheme(
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
  );

  static final TextTheme dark = buildTextTheme(
    textPrimary: const Color(0xFFE0EEF2),
    textSecondary: const Color(0xFF8FA4AC),
  );
}

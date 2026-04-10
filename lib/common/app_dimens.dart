/// App-wide spacing, padding, radius, and sizing constants.
///
/// Use these instead of raw doubles so layout is consistent and changes
/// propagate everywhere from one place.
///
/// Scale reference:
///   xs   =  4
///   sm   =  8
///   md   = 16
///   lg   = 24
///   xl   = 32
///   xxl  = 48
///   xxxl = 64
abstract final class AppDimens {
  // ---------------------------------------------------------------------------
  // Spacing / padding
  // ---------------------------------------------------------------------------
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;
  static const double spacingXxxl = 64.0;

  // ---------------------------------------------------------------------------
  // Border radius
  // ---------------------------------------------------------------------------
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radiusFull = 999.0;

  // ---------------------------------------------------------------------------
  // Icon sizes
  // ---------------------------------------------------------------------------
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  // ---------------------------------------------------------------------------
  // Elevation
  // ---------------------------------------------------------------------------
  static const double elevationNone = 0.0;
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 8.0;
}

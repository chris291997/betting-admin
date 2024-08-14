part of '../theme.dart';

class AppColors {
  const AppColors._({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.background,
    required this.surface,
    required this.error,
    required this.onPrimary,
    required this.onSecondary,
    required this.onTertiary,
    required this.onBackground,
    required this.onSurface,
    required this.onError,
  });

  /// A primary color is the color displayed most frequently across your app's screens and components.
  final Color primary;

  /// A secondary color provides more ways to accent and distinguish your product. Having a secondary color is optional, and should be applied sparingly to accent select parts of your UI.
  ///
  /// If you don’t have a secondary color, your primary color can also be used to accent elements.
  ///
  /// Secondary colors are best for:
  ///
  /// Floating action buttons
  /// Selection controls, like sliders and switches
  /// Highlighting selected text
  /// Progress bars
  /// Links and headlines
  final Color secondary;

  /// A tertiary color provides more ways to accent and distinguish your product. Having a tertiary color is optional, and should be applied sparingly to accent select parts of your UI.
  final Color tertiary;

  /// The background color appears behind scrollable content. The baseline background and surface color is #FFFFFF.
  final Color background;

  /// Surface colors affect surfaces of components, such as cards, sheets, and menus.
  final Color surface;

  /// Error colors indicate errors in components, such as text fields. It should be used sparingly to not overwhelm users.
  final Color error;
  final Color onPrimary;
  final Color onSecondary;
  final Color onTertiary;
  final Color onBackground;
  final Color onSurface;
  final Color onError;

  factory AppColors.dark() {
    return const AppColors._(
      primary: Color(0xFF4b39ef),
      secondary: Color(0xFF000000),
      tertiary: Color(0xFF000000),
      background: Color(0xFFF1F4F8),
      surface: Color(0xFF1E1E1E),
      error: Color(0xFFCF6679),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      onTertiary: Color(0xFFFFFFFF),
      onBackground: Color(0xFF57636C),
      onSurface: Color(0xFFFFFFFF),
      onError: Color(0xFF000000),
    );
  }
}

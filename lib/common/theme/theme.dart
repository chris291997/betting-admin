import 'package:flutter/material.dart';

part '../../common/theme/color/colors.dart';
part '../../common/theme/layout/layout.dart';
part '../../common/theme/screen_size/screen_size.dart';
part '../../common/theme/typography/text_style.dart';

extension AppTheme on BuildContext {
  ColorScheme get colors => AppColors.scheme;
  AppLayout get layout => AppLayout.layout;
  AppTextStyle get textStyle => AppTextStyle.defaultTextStyle();
}

final themeData = ThemeData(
  colorScheme: AppColors.scheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(AppColors.scheme.primary),
      foregroundColor: WidgetStateProperty.all(AppColors.scheme.onPrimary),
      textStyle:
          WidgetStateProperty.all(AppTextStyle.defaultTextStyle().button),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppLayout.layout.largeRadius,
          ),
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(AppColors.scheme.primary),
      textStyle:
          WidgetStateProperty.all(AppTextStyle.defaultTextStyle().button),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          vertical: AppLayout.layout.mediumPadding,
          horizontal: AppLayout.layout.largePadding,
        ),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppLayout.layout.largeRadius,
          ),
          side: BorderSide(
            color: AppColors.scheme.primary,
            width: 2.0,
          ),
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: AppTextStyle.defaultTextStyle().bodyText2,
    hintStyle: AppTextStyle.defaultTextStyle().bodyText2,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppLayout.layout.mediumRadius,
      ),
      borderSide: BorderSide(
        color: AppColors.scheme.inversePrimary,
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppLayout.layout.mediumRadius,
      ),
      borderSide: BorderSide(
        color: AppColors.scheme.inversePrimary,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppLayout.layout.mediumRadius,
      ),
      borderSide: BorderSide(
        color: AppColors.scheme.primary,
        width: 1,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppLayout.layout.mediumRadius,
      ),
      borderSide: BorderSide(
        color: AppColors.scheme.error,
        width: 1,
      ),
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: AppColors.scheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        AppLayout.layout.mediumRadius,
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    elevation: AppLayout.layout.lowElevation,
    titleTextStyle: AppTextStyle.defaultTextStyle().headline6.copyWith(
          color: AppColors.scheme.onPrimary,
        ),
    color: AppColors.scheme.primary,
    iconTheme: IconThemeData(
      color: AppColors.scheme.onPrimary,
    ),
  ),
  navigationRailTheme: NavigationRailThemeData(
    labelType: NavigationRailLabelType.selected,
    backgroundColor: AppColors.scheme.surface,
    selectedIconTheme: IconThemeData(
      color: AppColors.scheme.onPrimary,
    ),
    unselectedIconTheme: IconThemeData(
      color: AppColors.scheme.onSurface,
    ),
    selectedLabelTextStyle: AppTextStyle.defaultTextStyle().bodyText2.copyWith(
          color: AppColors.scheme.primary,
        ),
    unselectedLabelTextStyle:
        AppTextStyle.defaultTextStyle().bodyText2.copyWith(
              color: AppColors.scheme.onSurface,
            ),
    indicatorColor: AppColors.scheme.primary,
  ),
  dividerTheme: DividerThemeData(
    color: AppColors.scheme.surfaceDim,
    thickness: 1.0,
  ),
  disabledColor: AppColors.scheme.surfaceDim,
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: _NoTransitionPageTransitionsBuilder(),
      TargetPlatform.iOS: _NoTransitionPageTransitionsBuilder(),
      TargetPlatform.linux: _NoTransitionPageTransitionsBuilder(),
      TargetPlatform.macOS: _NoTransitionPageTransitionsBuilder(),
      TargetPlatform.windows: _NoTransitionPageTransitionsBuilder(),
    },
  ),
  fontFamily: 'Outfit',
  useMaterial3: true,
);

class _NoTransitionPageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

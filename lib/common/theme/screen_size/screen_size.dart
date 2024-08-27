part of '../theme.dart';

extension ScreenSizeX on BuildContext {
  Size get deviceSize => MediaQuery.sizeOf(this);
  double get deviceWidth => deviceSize.width;

  bool get isMobileDevice => deviceWidth <= _ScreenType.mobile.size;
  bool get isTabletDevice =>
      deviceWidth > _ScreenType.mobile.size &&
      deviceWidth <= _ScreenType.tablet.size;
  bool get isDesktopDevice =>
      deviceWidth > _ScreenType.tablet.size &&
      deviceWidth <= _ScreenType.desktop.size;
  bool get isLargeDesktopDevice =>
      deviceWidth > _ScreenType.desktop.size &&
      deviceWidth <= _ScreenType.largeDesktop.size;
}

enum _ScreenType {
  mobile(600),
  tablet(900),
  desktop(1200),
  largeDesktop(1400);

  final double size;

  const _ScreenType(this.size);
}

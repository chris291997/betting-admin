import 'package:flutter/material.dart';

part '../../common/theme/color/colors.dart';
part '../../common/theme/layout/layout.dart';
part '../../common/theme/screen_size/screen_size.dart';
part '../../common/theme/typography/text_style.dart';

extension AppTheme on BuildContext {
  AppColors get colors => AppColors.dark();
  AppLayout get layout => AppLayout.defaultLayout();
  ScreenSize get screenSize => ScreenSize();
  AppTextStyle get textStyle => AppTextStyle.defaultTextStyle();
}

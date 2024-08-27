import 'package:bet/common/theme/theme.dart';
import 'package:flutter/material.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    required this.title,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.onTap,
    required this.isSelected,
    super.key,
  });

  final String title;
  final Widget selectedIcon;
  final Widget unselectedIcon;
  final void Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      selectedTileColor: context.colors.surfaceTint,
      selectedColor: context.colors.onPrimary,
      leading: isSelected ? selectedIcon : unselectedIcon,
      title: Text(title),
      onTap: onTap,
    );
  }
}

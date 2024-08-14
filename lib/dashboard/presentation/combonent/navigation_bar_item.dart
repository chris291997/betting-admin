import 'package:bet/common/theme/theme.dart';
import 'package:flutter/material.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isSelected,
    super.key,
  });

  final String title;
  final Widget icon;
  final void Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: context.colors.primary.withOpacity(0.1),
      selected: isSelected,
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? context.colors.primary : context.colors.secondary,
        ),
      ),
      onTap: onTap,
    );
  }
}

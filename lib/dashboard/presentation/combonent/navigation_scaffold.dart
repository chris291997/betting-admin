import 'package:bet/common/theme/theme.dart';
import 'package:bet/dashboard/presentation/combonent/side_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bottom_navigation_bar.dart';

class NavigationScaffold extends StatelessWidget {
  const NavigationScaffold({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: context.isMobileDevice
          ? CustomBottomNavigationBar(navigationShell: navigationShell)
          : null,
      body: Row(
        children: [
          if (!context.isMobileDevice)
            SideNavigationBar(navigationShell: navigationShell),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}

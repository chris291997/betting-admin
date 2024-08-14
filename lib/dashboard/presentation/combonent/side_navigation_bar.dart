import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideNavigationBar extends StatelessWidget {
  const SideNavigationBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: _onTap,
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.event),
          selectedIcon: Icon(Icons.event),
          label: Text('Events'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.sports_mma),
          selectedIcon: Icon(Icons.sports_mma),
          label: Text('Fights'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person),
          selectedIcon: Icon(Icons.person),
          label: Text('Users'),
        ),
      ],
    );
  }
}

import 'package:bet/authentication/presentation/screen/login_screen.dart';
import 'package:bet/common/di/service_locator.dart';
import 'package:bet/common/theme/theme.dart';
import 'package:bet/dashboard/presentation/combonent/navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Betting App',
                  style: context.textStyle.headline6,
                ),
                Gap(context.layout.smallSpacing),
                Text(
                  'Welcome, User',
                  style: context.textStyle.subtitle1,
                ),
              ],
            ),
          ),
          NavigationBarItem(
            title: 'Events',
            selectedIcon: const Icon(Icons.event),
            unselectedIcon: const Icon(Icons.event_outlined),
            onTap: () => _onTap(0),
            isSelected: navigationShell.currentIndex == 0,
          ),
          // NavigationBarItem(
          //   title: 'Fighters',
          //   selectedIcon: const Icon(Icons.sports_mma),
          //   unselectedIcon: const Icon(Icons.sports_mma_outlined),
          //   onTap: () => _onTap(1),
          //   isSelected: navigationShell.currentIndex == 1,
          // ),
          NavigationBarItem(
            title: 'Users',
            selectedIcon: const Icon(Icons.person),
            unselectedIcon: const Icon(Icons.person_outline),
            onTap: () => _onTap(1),
            isSelected: navigationShell.currentIndex == 1,
          ),
          NavigationBarItem(
            title: 'Logout',
            selectedIcon: const Icon(Icons.logout),
            unselectedIcon: const Icon(Icons.logout_outlined),
            onTap: () async {
              await cacheService.remove(StorageKey.accessToken);
              await cacheService.remove(StorageKey.refreshToken);
              context.go(LoginScreen.routeName);
            },
            isSelected: false,
          ),
        ],
      ),
    );
  }
}

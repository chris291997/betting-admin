import 'package:bet/authentication/presentation/screen/login_screen.dart';
import 'package:bet/common/di/service_locator.dart';
import 'package:bet/dashboard/presentation/combonent/navigation_scaffold.dart';
import 'package:bet/event/presentation/screen/event_screen.dart';
import 'package:bet/fight/presentation/screen/fight_screen.dart';
import 'package:bet/user/presentation/screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: EventScreen.routeName,
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavigationScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          routes: [
            GoRoute(
              path: EventScreen.routeName,
              builder: (context, state) {
                return const EventScreen();
              },
            ),
            GoRoute(
              path: FightScreen.routeName,
              builder: (context, state) {
                return const FightScreen();
              },
            ),
            GoRoute(
              path: UsersScreen.routeName,
              builder: (context, state) {
                return const UsersScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
  redirect: (context, state) async {
    final accessToken = await cacheService.read(StorageKey.accessToken);
    if (accessToken != null) {
      return null;
    }

    return LoginScreen.routeName;
  },
);

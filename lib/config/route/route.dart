import 'package:bet/authentication/presentation/screen/login_screen.dart';
import 'package:bet/common/di/service_locator.dart';
import 'package:bet/dashboard/presentation/combonent/navigation_scaffold.dart';
import 'package:bet/event/presentation/screen/event_screen.dart';
import 'package:bet/user/presentation/bloc/account_bloc.dart';
import 'package:bet/user/presentation/screen/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _eventNavigatorKey = GlobalKey<NavigatorState>();
// final _fightertNavigatorKey = GlobalKey<NavigatorState>();
final _usertNavigatorKey = GlobalKey<NavigatorState>();

// no navigation animation
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
          navigatorKey: _eventNavigatorKey,
          routes: [
            GoRoute(
              path: EventScreen.routeName,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: EventScreen());
              },
            ),
          ],
        ),
        // StatefulShellBranch(
        //   navigatorKey: _fightertNavigatorKey,
        //   routes: [
        //     GoRoute(
        //       path: FighterListScreen.routeName,
        //       pageBuilder: (context, state) {
        //         return const NoTransitionPage(child: FighterListScreen());
        //       },
        //     ),
        //   ],
        // ),
        StatefulShellBranch(
          navigatorKey: _usertNavigatorKey,
          routes: [
            GoRoute(
              path: UsersScreen.routeName,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: UsersScreen());
              },
            ),
          ],
        ),
      ],
    ),
  ],
  redirect: (context, state) async {
    final accountBloc = context.read<AccountBloc>();
    final accessToken = await cacheService.read(StorageKey.accessToken);

    if (accessToken != null) {
      if (!JwtDecoder.isExpired(accessToken)) {
        accountBloc.add(AccountEventLoggedUserRequested());

        return null;
      }
    }

    await cacheService.remove(StorageKey.accessToken);
    await cacheService.remove(StorageKey.refreshToken);
    return LoginScreen.routeName;
  },
);

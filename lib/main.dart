import 'package:bet/common/theme/theme.dart';
import 'package:bet/config/route/route.dart';
import 'package:bet/user/data/di/user_service_locator.dart';
import 'package:bet/user/presentation/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatefulHookWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (_) => AccountBloc(userRepository)),
      ],
      child: MaterialApp.router(
        title: 'Betting App',
        theme: themeData,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          if (child == null) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return child;
        },
      ),
    );
  }
}

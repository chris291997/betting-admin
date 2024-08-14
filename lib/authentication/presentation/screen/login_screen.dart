import 'package:bet/authentication/presentation/component/login_form.dart';
import 'package:bet/authentication/presentation/component/login_image.dart';
import 'package:bet/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(context.layout.mediumPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Betting App', style: context.textStyle.headline4),
                  Gap(context.layout.largeSpacing),
                  const Expanded(child: Center(child: LoginForm())),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(context.layout.mediumPadding),
            child: const LoginImage(),
          ),
        ],
      ),
    );
  }
}

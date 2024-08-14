import 'package:bet/authentication/data/di/auth_service_locator.dart';
import 'package:bet/authentication/presentation/component/login_button.dart';
import 'package:bet/authentication/presentation/component/password_textfield.dart';
import 'package:bet/authentication/presentation/component/username_textfield.dart';
import 'package:bet/authentication/presentation/viewmodel/auth_viewmodel.dart';
import 'package:bet/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthViewmodel>(
      create: (context) => AuthViewmodel(authRepository),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 370),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign In', style: context.textStyle.headline4),
            Gap(context.layout.smallSpacing),
            Text(
              "Let's get started by filling out the form below.",
              style: context.textStyle.subtitle1,
            ),
            Gap(context.layout.largeSpacing),
            const UsernameTextfield(),
            Gap(context.layout.smallSpacing),
            const PasswordTextfield(),
            Gap(context.layout.mediumSpacing),
            const LoginButton(),
          ],
        ),
      ),
    );
  }
}

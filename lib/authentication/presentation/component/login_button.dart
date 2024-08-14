import 'package:bet/authentication/presentation/viewmodel/auth_viewmodel.dart';
import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/common/theme/theme.dart';
import 'package:bet/event/presentation/screen/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthViewmodel, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.go(EventScreen.routeName);
        } else if (state.status.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Login failed',
                style: context.textStyle.caption.copyWith(
                  color: context.colors.onError,
                ),
              ),
              backgroundColor: context.colors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return PrimaryButton(
          labelText: 'Login',
          state: state.status.isLoading
              ? PrimaryButtonState.loading
              : PrimaryButtonState.enabled,
          onPressed: () {
            context.read<AuthViewmodel>().add(AuthLoginRequested());
          },
        );
      },
    );
  }
}

import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/fighter/presentation/bloc/create_fighter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FighterAddOrUpdateButton extends StatelessWidget {
  const FighterAddOrUpdateButton({
    super.key,
    required this.createOrUpdateButtonState,
    required this.buttonLabel,
    required this.createOrUpdateButtonOnPressed,
  });

  final PrimaryButtonState createOrUpdateButtonState;
  final String buttonLabel;
  final void Function() createOrUpdateButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: createOrUpdateButtonOnPressed,
      labelText: buttonLabel,
      state: createOrUpdateButtonState,
    );
  }
}

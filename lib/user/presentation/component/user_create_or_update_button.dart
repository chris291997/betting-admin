import 'package:bet/common/component/button/primary_button.dart';
import 'package:flutter/material.dart';

class UserCreateOrUpdateButton extends StatelessWidget {
  const UserCreateOrUpdateButton({
    super.key,
    required this.createOrUpdateButtonOnPressed,
    this.submitButtonState = PrimaryButtonState.enabled,
    this.buttonLabel = 'Submit',
  });

  final PrimaryButtonState submitButtonState;
  final String buttonLabel;
  final void Function() createOrUpdateButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: createOrUpdateButtonOnPressed,
      labelText: buttonLabel,
      state: submitButtonState,
    );
  }
}

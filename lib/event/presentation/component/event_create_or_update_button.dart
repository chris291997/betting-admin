import 'package:bet/common/component/button/primary_button.dart';
import 'package:flutter/material.dart';

class EventSubmitButton extends StatelessWidget {
  const EventSubmitButton({
    super.key,
    required this.createtOrUpdateButtonState,
    required this.buttonLabel,
    required this.createOrUpdateButtonOnPressed,
  });
  final String buttonLabel;
  final PrimaryButtonState createtOrUpdateButtonState;
  final Function() createOrUpdateButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: createOrUpdateButtonOnPressed,
      labelText: buttonLabel,
    );
  }
}

import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.onPressed,
    this.labelText = '',
    this.label,
    this.state = CircularButtonState.enabled,
    this.height,
    this.width,
    super.key,
  });

  final Widget? label;
  final String labelText;
  final void Function() onPressed;
  final CircularButtonState state;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: state.isEnabled ? onPressed : null,
      child: state.isLoading
          ? const CircularProgressIndicator()
          : label ?? Text(labelText),
    );
  }
}

enum CircularButtonState {
  enabled,
  disabled,
  loading;

  bool get isEnabled => this == CircularButtonState.enabled;

  bool get isDisabled => this == CircularButtonState.disabled;

  bool get isLoading => this == CircularButtonState.loading;
}

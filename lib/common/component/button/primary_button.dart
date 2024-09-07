import 'package:bet/common/theme/theme.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    this.labelText = '',
    this.label,
    this.color,
    this.disabledColor,
    this.state = PrimaryButtonState.enabled,
    super.key,
  });

  final Widget? label;
  final String labelText;
  final void Function() onPressed;
  final Color? color;
  final Color? disabledColor;
  final PrimaryButtonState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state.isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? context.colors.primary,
          disabledBackgroundColor: disabledColor ?? context.colors.primaryFixed,
        ),
        child: state.isLoading
            ? SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                  color: context.colors.onPrimary,
                ),
              )
            : label ?? Text(labelText, style: context.textStyle.button),
      ),
    );
  }
}

enum PrimaryButtonState {
  enabled,
  disabled,
  loading;

  bool get isEnabled => this == PrimaryButtonState.enabled;

  bool get isDisabled => this == PrimaryButtonState.disabled;

  bool get isLoading => this == PrimaryButtonState.loading;
}

import 'package:bet/common/theme/theme.dart';
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
    return GestureDetector(
      onTap: state.isEnabled ? onPressed : null,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: context.colors.primary,
          borderRadius: BorderRadius.circular(30.0), // Circular border
          border: Border.all(
            color: context.colors.onPrimary, // Border color
            width: 2.0, // Border width
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: context.layout.mediumPadding,
          horizontal: context.layout.largePadding,
        ),
        child: Center(
          child: state.isLoading
              ? const CircularProgressIndicator()
              : label ?? Text(labelText, style: context.textStyle.button),
        ),
      ),
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

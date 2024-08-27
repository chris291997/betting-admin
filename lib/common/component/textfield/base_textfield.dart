import 'package:bet/common/theme/theme.dart';
import 'package:flutter/material.dart';

class BaseTextfield extends StatelessWidget {
  const BaseTextfield({
    required this.onChanged,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.enabled = true,
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final bool enabled;

  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      focusNode: focusNode,
      autofocus: autofocus,
      onChanged: (value) => onChanged(value),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: context.textStyle.bodyText2,
        hintText: hintText,
        hintStyle: context.textStyle.bodyText2,
      ),
      obscureText: obscureText,
    );
  }
}

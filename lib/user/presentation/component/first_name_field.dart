import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FirstNameField extends HookWidget {
  const FirstNameField({
    super.key,
    required this.onFirstNameChanged,
    this.initialValue = '',
  });
  final String initialValue;
  final Function(String) onFirstNameChanged;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);
    return BaseTextfield(
        onChanged: onFirstNameChanged,
        labelText: "First Name",
        controller: controller);
  }
}

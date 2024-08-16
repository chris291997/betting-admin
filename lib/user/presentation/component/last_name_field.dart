import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LastNameField extends HookWidget {
  const LastNameField({
    super.key,
    required this.onLastNameChanged,
    this.initialValue = '',
  });
  final String initialValue;
  final Function(String) onLastNameChanged;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);
    return BaseTextfield(
      onChanged: onLastNameChanged,
      labelText: "Last Name",
      controller: controller,
    );
  }
}

import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UsernameField extends HookWidget {
  const UsernameField({
    super.key,
    required this.onUsernameChanged,
    this.initialValue = '',
  });
  final String initialValue;
  final Function(String) onUsernameChanged;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);
    return BaseTextfield(
      onChanged: onUsernameChanged,
      labelText: "Username",
      controller: controller,
    );
  }
}

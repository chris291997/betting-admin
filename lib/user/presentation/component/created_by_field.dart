import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CreatedByField extends HookWidget {
  const CreatedByField({
    super.key,
    required this.onCreatedByChanged,
    this.initialValue = '',
  });
  final String initialValue;
  final Function(String) onCreatedByChanged;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);
    return BaseTextfield(
      enabled: false,
      onChanged: onCreatedByChanged,
      labelText: "Created By",
      controller: controller,
    );
  }
}

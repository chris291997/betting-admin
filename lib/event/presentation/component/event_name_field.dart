import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EventNameField extends HookWidget {
  const EventNameField({
    super.key,
    required this.onEventNameChanged,
    this.initialValue = '',
  });
  final String initialValue;
  final Function(String) onEventNameChanged;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);
    return BaseTextfield(
      controller: controller,
      onChanged: onEventNameChanged,
      labelText: "Name",
    );
  }
}

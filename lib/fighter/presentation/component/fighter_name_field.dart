import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FighterNameField extends HookWidget {
  const FighterNameField({
    super.key,
    required this.onFighterNameChanged,
    this.initialValue = '',
  });

  final String initialValue;

  final Function(String) onFighterNameChanged;
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);

    return BaseTextfield(
      onChanged: onFighterNameChanged,
      labelText: "Name",
      controller: controller,
    );
  }
}

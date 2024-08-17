import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FighterTrainerField extends HookWidget {
  const FighterTrainerField({
    super.key,
    required this.onTrainerChanged,
    this.initialValue = '',
  });

  final String initialValue;
  final Function(String) onTrainerChanged;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);

    return BaseTextfield(
        onChanged: onTrainerChanged,
        labelText: "Trainer",
        controller: controller);
  }
}

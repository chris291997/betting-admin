import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FighterBreedField extends HookWidget {
  const FighterBreedField({
    super.key,
    required this.onBreedChanged,
    this.initialValue = '',
  });
  final String initialValue;
  final Function(String) onBreedChanged;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);
    return BaseTextfield(
      onChanged: onBreedChanged,
      labelText: "Breed",
      controller: controller,
    );
  }
}

import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FightNumberField extends HookWidget {
  const FightNumberField({super.key, this.initialValue = ''});

  final String initialValue;
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);

    return BaseTextfield(
        onChanged: (value) {}, labelText: "Fight #", controller: controller);
  }
}

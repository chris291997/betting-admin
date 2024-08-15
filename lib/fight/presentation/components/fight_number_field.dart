import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:bet/fight/presentation/bloc/create_fight_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FightNumberField extends HookWidget {
  const FightNumberField({super.key, this.initialValue = ''});

  final String initialValue;
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);

    return BaseTextfield(
        onChanged: (value) {
          final fightNumber = int.tryParse(value);
          if (fightNumber != null) {
            context
                .read<CreateFightBloc>()
                .add(FightCreateEventFightNumAdded(fightNumber));
          }
        },
        labelText: "Fight #",
        controller: controller);
  }
}

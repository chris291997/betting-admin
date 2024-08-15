import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:bet/fighter/presentation/bloc/create_fighter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FighterOwnerField extends HookWidget {
  const FighterOwnerField({
    super.key,
    this.initialValue = '',
  });

  final String initialValue;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);

    return BaseTextfield(
        onChanged: (value) {
          context.read<CreateFighterBloc>().add(
                FighterCreateEventTrainerAdded(value),
              );
        },
        labelText: "Trainer",
        controller: controller);
  }
}

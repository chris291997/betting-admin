import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/fighter/data/di/fighter_service_locator.dart';
import 'package:bet/fighter/presentation/component/fighter_breed_field.dart';
import 'package:bet/fighter/presentation/component/fighter_name_field.dart';
import 'package:bet/fighter/presentation/component/fighter_trainer_field.dart';
import 'package:bet/fighter/presentation/component/fighter_add_or_update_button.dart';
import 'package:bet/fighter/presentation/component/fighter_weight_field.dart';
import 'package:flutter/material.dart';

class FighterModal extends StatelessWidget {
  const FighterModal({
    super.key,
    required this.type,
    required this.createOrUpdateButtonState,
    required this.onFighterNameChanged,
    required this.onFighterWeightChanged,
    required this.onFighterBreedChanged,
    required this.onFighterTrainerChanged,
    required this.createOrUpdateButtonOnPressed,
    this.initialFighterValue = const FighterOutput(),
  });

  final FighterModalType type;
  final PrimaryButtonState createOrUpdateButtonState;
  final FighterOutput initialFighterValue;
  final Function(String) onFighterNameChanged;
  final Function(String) onFighterWeightChanged;
  final Function(String) onFighterBreedChanged;
  final Function(String) onFighterTrainerChanged;
  final Function() createOrUpdateButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    final buttonLabel = type.isAdd ? "Add" : "Update";
    return AlertDialog(
      title: Text("$buttonLabel Fighter"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FighterNameField(
              initialValue: initialFighterValue.name,
              onFighterNameChanged: onFighterNameChanged,
            ),
            const SizedBox(height: 5),
            FighterWeightField(
              initialValue: initialFighterValue.weight.toString(),
              onWeightChanged: onFighterWeightChanged,
            ),
            const SizedBox(height: 5),
            FighterBreedField(
              initialValue: initialFighterValue.breed,
              onBreedChanged: onFighterBreedChanged,
            ),
            const SizedBox(height: 5),
            FighterTrainerField(
              initialValue: initialFighterValue.trainer,
              onTrainerChanged: onFighterTrainerChanged,
            ),
            const SizedBox(height: 20),
            FighterAddOrUpdateButton(
              createOrUpdateButtonState: createOrUpdateButtonState,
              buttonLabel: buttonLabel,
              createOrUpdateButtonOnPressed: createOrUpdateButtonOnPressed,
            ),
          ],
        ),
      ),
    );
  }
}

enum FighterModalType {
  add,
  edit;

  bool get isAdd => this == FighterModalType.add;
  bool get isEdit => this == FighterModalType.edit;
}

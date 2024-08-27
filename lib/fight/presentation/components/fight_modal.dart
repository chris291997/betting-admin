import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/fight/data/di/fight_service_locator.dart';
import 'package:bet/fight/presentation/components/fight_add_or_update_button.dart';
import 'package:bet/fight/presentation/components/fight_select_fighter.dart';
import 'package:bet/fight/presentation/components/fight_start_time_picker.dart';
import 'package:bet/fighter/data/di/fighter_service_locator.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

class FightModal extends StatelessWidget {
  const FightModal({
    super.key,
    required this.type,
    required this.createOrUpdateFightButtonState,
    required this.onNumberChanged,
    required this.onTimeChanged,
    required this.onMeronSelected,
    required this.onWalaSelected,
    required this.createOrUpdateFightSubmitted,
    this.initialFightValue,
  });

  final FightModalType type;
  final PrimaryButtonState createOrUpdateFightButtonState;
  final FightOutput? initialFightValue;
  final Function(String) onNumberChanged;
  final Function(Time) onTimeChanged;
  final Function(FighterOutput) onMeronSelected;
  final Function(FighterOutput) onWalaSelected;
  final Function() createOrUpdateFightSubmitted;

  @override
  Widget build(BuildContext context) {
    final buttonLabel = type.isAdd ? "Add Fight" : "Update Fight";

    return AlertDialog(
      title: Text(buttonLabel),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FightStartTimePicker(
              // initialTime: initialFightValue?.startTime,
              onTimeChanged: onTimeChanged,
            ),
            const SizedBox(height: 5),
            FightSelectFighter(
              fighterType: FighterType.meron,
              onFighterSelected: onMeronSelected,
              initialSelectedFighter: FighterOutput(
                id: initialFightValue?.meronId ?? '',
              ),
            ),
            const SizedBox(height: 5),
            FightSelectFighter(
              fighterType: FighterType.wala,
              onFighterSelected: onWalaSelected,
              initialSelectedFighter: FighterOutput(
                id: initialFightValue?.walaId ?? '',
              ),
            ),
            const SizedBox(height: 20),
            FightAddOrUpdateButton(
              state: createOrUpdateFightButtonState,
              label: buttonLabel,
              createOrUpdateFightSubmitted: createOrUpdateFightSubmitted,
            ),
          ],
        ),
      ),
    );
  }
}

enum FightModalType {
  add,
  edit;

  bool get isAdd => this == FightModalType.add;
  bool get isEdit => this == FightModalType.edit;
}

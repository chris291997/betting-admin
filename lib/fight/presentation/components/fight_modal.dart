import 'package:bet/fight/presentation/components/fight_add_or_update_button.dart';
import 'package:bet/fight/presentation/components/fight_number_field.dart';
import 'package:bet/fight/presentation/components/fight_select_fighter.dart';
import 'package:bet/fight/presentation/components/fight_start_time_picker.dart';
import 'package:flutter/material.dart';

class FightModal extends StatelessWidget {
  const FightModal({
    super.key,
    required this.type,
  });

  final FightModalType type;

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("Add Fight"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FightNumberField(),
            SizedBox(height: 5),
            FightStartTimePicker(),
            SizedBox(height: 5),
            FightSelectFighter(
              fighterType: FighterType.meron,
            ),
            SizedBox(height: 5),
            FightSelectFighter(
              fighterType: FighterType.wala,
            ),
            SizedBox(height: 20),
            FightAddOrUpdateButton(),
          ],
        ),
      ),
    );
  }
}

enum FightModalType {
  add,
  edit,
}

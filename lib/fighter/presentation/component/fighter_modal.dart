import 'package:bet/fighter/presentation/component/fighter_breed_field.dart';
import 'package:bet/fighter/presentation/component/fighter_name_field.dart';
import 'package:bet/fighter/presentation/component/fighter_owner_field.dart';
import 'package:bet/fighter/presentation/component/fighter_add_or_update_button.dart';
import 'package:bet/fighter/presentation/component/fighter_weight_field.dart';
import 'package:flutter/material.dart';

class FighterModal extends StatelessWidget {
  const FighterModal({
    super.key,
    required this.type,
  });

  final FighterModalType type;

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("Add Fighter"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FighterNameField(),
            SizedBox(height: 5),
            FighterWeightField(),
            SizedBox(height: 5),
            FighterBreedField(),
            SizedBox(height: 5),
            FighterOwnerField(),
            SizedBox(height: 20),
            FighterAddOrUpdateButton(),
          ],
        ),
      ),
    );
  }
}

enum FighterModalType {
  add,
  edit,
}

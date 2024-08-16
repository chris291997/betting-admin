import 'package:bet/fighter/data/di/fighter_service_locator.dart';
import 'package:bet/fighter/presentation/component/fighter_list_view.dart';
import 'package:flutter/material.dart';

Future<void> displayFighterList(BuildContext context,
    {FighterOutput? initialSelectedFighter,
    Function(FighterOutput)? onFighterSelected}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: 600,
          child: Material(
            child: FighterListView(
              initialSelectedFighter: initialSelectedFighter,
              onFighterSelected: onFighterSelected,
            ),
          ),
        ),
      );
    },
  );
}

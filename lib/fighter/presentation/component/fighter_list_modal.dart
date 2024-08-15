import 'package:bet/fighter/presentation/component/fighter_list_view.dart';
import 'package:flutter/material.dart';

Future<void> displayFighterList(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return const _FighterListModal();
    },
  );
}

class _FighterListModal extends StatelessWidget {
  const _FighterListModal();

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      content: SizedBox(
        width: 600,
        child: Material(
          child: FighterListView(),
        ),
      ),
    );
  }
}

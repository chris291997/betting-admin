import 'package:bet/fighter/presentation/component/fighter_list_modal.dart';
import 'package:flutter/material.dart';

class FightSelectFighter extends StatelessWidget {
  const FightSelectFighter({super.key, required this.fighterType});
  final FighterType fighterType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(fighterType.isMeron ? "Meron" : "Wala"),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () async {
            displayFighterList(context);
          },
          child: const Text("Select Fighter"),
        ),
      ],
    );
  }
}

enum FighterType {
  meron,
  wala;

  bool get isMeron => this == FighterType.meron;
  bool get isWala => this == FighterType.wala;
}

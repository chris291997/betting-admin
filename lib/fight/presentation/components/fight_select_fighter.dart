import 'package:bet/fighter/data/di/fighter_service_locator.dart';
import 'package:bet/fighter/presentation/component/fighter_list_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FightSelectFighter extends HookWidget {
  const FightSelectFighter({
    super.key,
    required this.fighterType,
    required this.onFighterSelected,
    this.initialSelectedFighter,
  });
  final FighterType fighterType;
  final FighterOutput? initialSelectedFighter;
  final Function(FighterOutput)? onFighterSelected;

  @override
  Widget build(BuildContext context) {
    final fighter = useState(initialSelectedFighter);

    return Row(
      children: [
        Text(fighterType.isMeron ? "Meron" : "Wala"),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () async {
            displayFighterList(
              context,
              initialSelectedFighter: initialSelectedFighter,
              onFighterSelected: onFighterSelected,
            );
          },
          child: Text(fighter.value?.name ?? "Select Fighter"),
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

import 'package:bet/fight/presentation/components/fighter_details.dart';
import 'package:flutter/material.dart';

class FightDetailsScreen extends StatelessWidget {
  const FightDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fights')),
      body: const Center(
        child: SizedBox(
          width: 800,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FighterDetails(),
              VerticalDivider(
                width: 2,
              ),
              FighterDetails(),
            ],
          ),
        ),
      ),
    );
  }
}

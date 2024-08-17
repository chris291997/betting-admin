import 'package:bet/common/component/button/primary_button.dart';
import 'package:flutter/material.dart';

class FightAddOrUpdateButton extends StatelessWidget {
  const FightAddOrUpdateButton({
    super.key,
    required this.state,
    required this.label,
    required this.createOrUpdateFightSubmitted,
  });

  final PrimaryButtonState state;
  final String label;
  final Function() createOrUpdateFightSubmitted;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: createOrUpdateFightSubmitted,
      labelText: label,
      state: state,
    );
  }
}

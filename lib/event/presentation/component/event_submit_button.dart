import 'package:bet/common/component/button/primary_button.dart';
import 'package:flutter/material.dart';

class EventSubmitButton extends StatelessWidget {
  const EventSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(onPressed: () {}, labelText: 'Submit');
  }
}

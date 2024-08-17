import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';

class EventLocationField extends StatelessWidget {
  const EventLocationField({
    super.key,
    required this.onLocationChanged,
    this.initialValue = '',
  });
  final String initialValue;
  final Function(String) onLocationChanged;

  @override
  Widget build(BuildContext context) {
    return BaseTextfield(
      onChanged: onLocationChanged,
      labelText: "Location",
    );
  }
}

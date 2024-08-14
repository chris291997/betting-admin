import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';

class EventLocationField extends StatelessWidget {
  const EventLocationField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseTextfield(onChanged: (value) {}, labelText: "Location");
  }
}

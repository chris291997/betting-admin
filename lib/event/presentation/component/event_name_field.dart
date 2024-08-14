import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';

class EventNameField extends StatelessWidget {
  const EventNameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseTextfield(onChanged: (value) {}, labelText: "Name");
  }
}

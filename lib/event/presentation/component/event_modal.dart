import 'package:bet/event/presentation/component/event_date_picker.dart';
import 'package:bet/event/presentation/component/event_location_field.dart';
import 'package:bet/event/presentation/component/event_name_field.dart';
import 'package:bet/event/presentation/component/event_submit_button.dart';
import 'package:flutter/material.dart';

class EventModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("Create Event"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EventNameField(),
            EventLocationField(),
            SizedBox(height: 20),
            EventDatePicker(),
            SizedBox(height: 20),
            EventSubmitButton(),
          ],
        ),
      ),
    );
  }
}

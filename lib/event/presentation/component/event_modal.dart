import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/event/data/di/event_service_locator.dart';
import 'package:bet/event/presentation/component/event_date_picker.dart';
import 'package:bet/event/presentation/component/event_location_field.dart';
import 'package:bet/event/presentation/component/event_name_field.dart';
import 'package:bet/event/presentation/component/event_create_or_update_button.dart';
import 'package:flutter/material.dart';

class EventModal extends StatelessWidget {
  const EventModal({
    super.key,
    required this.modalType,
    required this.createOrUpdateButtonState,
    required this.onEventNameChanged,
    required this.onLocationChanged,
    required this.onDateChanged,
    required this.createOrUpdateButtonOnPressed,
    this.initialEventValue = const EventOutput(),
  });

  final EventModalType modalType;
  final PrimaryButtonState createOrUpdateButtonState;
  final EventOutput initialEventValue;
  final Function(String) onEventNameChanged;
  final Function(String) onLocationChanged;
  final Function(DateTime) onDateChanged;
  final Function() createOrUpdateButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    final buttonLabel = modalType.isCreate ? "Submit" : "Update";
    return AlertDialog(
      title: Text("$buttonLabel Event"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EventNameField(
              initialValue: initialEventValue.eventName,
              onEventNameChanged: onEventNameChanged,
            ),
            EventLocationField(
              initialValue: initialEventValue.location,
              onLocationChanged: onLocationChanged,
            ),
            const SizedBox(height: 20),
            EventDatePicker(
              initialDate: initialEventValue.eventDate,
              onDateChanged: onDateChanged,
            ),
            const SizedBox(height: 20),
            EventSubmitButton(
              buttonLabel: buttonLabel,
              createtOrUpdateButtonState: createOrUpdateButtonState,
              createOrUpdateButtonOnPressed: createOrUpdateButtonOnPressed,
            ),
          ],
        ),
      ),
    );
  }
}

enum EventModalType {
  add,
  edit;

  bool get isCreate => this == EventModalType.add;
  bool get isUpdate => this == EventModalType.edit;
}

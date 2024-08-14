import 'package:flutter/material.dart';

class EventDatePicker extends StatelessWidget {
  const EventDatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Event Date:"),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () async {
            await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2022),
            );
          },
          child: const Text("Select Date"),
        ),
      ],
    );
  }
}

import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

class FightStartTimePicker extends StatelessWidget {
  const FightStartTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final time = Time(
      hour: 11,
      minute: 30,
    );
    return Row(
      children: [
        const Text("Fight Start Time:"),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () async {
            Navigator.of(context).push(
              showPicker(
                context: context,
                value: time,
                minuteInterval: TimePickerInterval.FIVE,
                onChange: (_) => {},
              ),
            );
          },
          child: const Text("Select Time"),
        ),
      ],
    );
  }
}

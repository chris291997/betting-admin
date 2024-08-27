import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FightStartTimePicker extends HookWidget {
  const FightStartTimePicker({
    super.key,
    required this.onTimeChanged,
    this.initialTime,
  });

  final Time? initialTime;
  final Function(Time) onTimeChanged;

  @override
  Widget build(BuildContext context) {
    final time = Time(
      hour: 11,
      minute: 30,
    );

    final currentSelectedTime = useState(initialTime);

    return Row(
      children: [
        const Text("Fight Start Time:"),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () async {
            Navigator.of(context).push(
              showPicker(
                context: context,
                value: currentSelectedTime.value ?? time,
                minuteInterval: TimePickerInterval.FIVE,
                onChange: (time) {
                  onTimeChanged.call(time);
                  currentSelectedTime.value = time;
                },
              ),
            );
          },
          child: Text(currentSelectedTime.value != null
              ? '${currentSelectedTime.value?.hour}:${currentSelectedTime.value?.minute} ${currentSelectedTime.value?.period.name}'
              : "Select Time"),
        ),
      ],
    );
  }
}

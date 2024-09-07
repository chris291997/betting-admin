import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class EventDatePicker extends HookWidget {
  const EventDatePicker({
    super.key,
    required this.onDateChanged,
    this.initialDate,
  });
  final DateTime? initialDate;
  final Function(DateTime) onDateChanged;

  @override
  Widget build(BuildContext context) {
    final date = useState(initialDate);

    final dateTimeFormat =
        DateFormat('yyyy-MM-dd').format(date.value ?? DateTime.now());

    return Row(
      children: [
        const Text("Event Date:"),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () async {
            final now = DateTime.now();
            final today = DateTime(now.year, now.month, now.day);

            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: date.value != null && date.value!.isAfter(today)
                  ? date.value!
                  : today,
              firstDate: today,
              lastDate: DateTime(now.year + 1),
            );

            if (selectedDate != null) {
              onDateChanged.call(selectedDate);

              date.value = selectedDate;
            }
          },
          child: Text(date.value == null ? "Select Date" : dateTimeFormat),
        ),
      ],
    );
  }
}

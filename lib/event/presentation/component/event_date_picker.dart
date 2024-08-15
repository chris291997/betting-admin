import 'package:bet/event/presentation/bloc/create_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDatePicker extends StatelessWidget {
  const EventDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CreateEventBloc, CreateEventState, DateTime?>(
      selector: (state) {
        return state.eventInput.eventDate;
      },
      builder: (context, date) {
        return Row(
          children: [
            const Text("Event Date:"),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                final createEventBloc = context.read<CreateEventBloc>();

                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2025),
                );

                if (selectedDate != null) {
                  createEventBloc.add(EventCreateEventDateAdded(selectedDate));
                }
              },
              child: Text(date?.toString() ?? "Select Date"),
            ),
          ],
        );
      },
    );
  }
}

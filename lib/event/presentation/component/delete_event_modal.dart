import 'package:bet/event/presentation/bloc/update_or_delete_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteEventModal extends StatelessWidget {
  const DeleteEventModal({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Delete Event'),
      content: const Text('Are you sure you want to delete this event?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<UpdateOrDeleteEventBloc>(context)
                .add(EventDeleted(eventId));
            Navigator.pop(context);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}

import 'package:bet/common/component/textfield/base_textfield.dart';
import 'package:bet/event/presentation/bloc/create_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventLocationField extends StatelessWidget {
  const EventLocationField({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseTextfield(
        onChanged: (value) {
          context
              .read<CreateEventBloc>()
              .add(EventCreateEventLocationAdded(value));
        },
        labelText: "Location");
  }
}

import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/event/presentation/bloc/create_event_bloc.dart';
import 'package:bet/user/presentation/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventSubmitButton extends StatelessWidget {
  const EventSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
        onPressed: () {
          final creatorId = context.read<AccountBloc>().state.userOutput.id;

          context
              .read<CreateEventBloc>()
              .add(EventCreatedEventCreatorAdded(creatorId));

          context.read<CreateEventBloc>().add(EventCreated());

          Navigator.of(context).pop();
        },
        labelText: 'Submit');
  }
}

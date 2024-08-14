import 'package:bet/event/presentation/component/event_modal.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  static const String routeName = "/events";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Event Creator")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showEventModal(context),
          child: const Text("Create Event"),
        ),
      ),
    );
  }

  void _showEventModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EventModal(),
    );
  }
}

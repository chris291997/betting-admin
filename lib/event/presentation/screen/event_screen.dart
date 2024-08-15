import 'package:bet/common/component/button/secondary_button.dart';
import 'package:bet/event/data/di/event_service_locator.dart';
import 'package:bet/event/presentation/bloc/create_event_bloc.dart';
import 'package:bet/event/presentation/bloc/event_list_bloc.dart';
import 'package:bet/event/presentation/bloc/update_or_delete_event_bloc.dart';
import 'package:bet/event/presentation/component/event_modal.dart';
import 'package:bet/fight/presentation/screen/fight_list_screen.dart';
import 'package:bet/user/presentation/bloc/account_bloc.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  static const String routeName = "/events";
  static const List<String> _columnNames = [
    'Name',
    'Location',
    'Event Date',
  ];
  static final _columns =
      _columnNames.map((column) => DataColumn(label: Text(column))).toList();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) =>
              EventListBloc(eventRepository)..add(EventListEventFetched()),
        ),
        BlocProvider(
          create: (context) => UpdateOrDeleteEventBloc(eventRepository),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Events')),
        body: BlocBuilder<EventListBloc, EventListState>(
          builder: (context, state) {
            if (state.status.isError) {
              return const Center(child: Text('Failed to fetch events'));
            }

            if (state.status.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status.isInitial) {
              return const SizedBox();
            }

            final events = state.events;

            return Center(
              child: SizedBox(
                width: 1000,
                child: DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 100,
                  columns: _columns,
                  showHeadingCheckBox: false,
                  showCheckboxColumn: false,
                  empty: const Center(child: Text('No data')),
                  rows: events
                      .map((event) => DataRow(
                            onSelectChanged: (value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FightListScreen(
                                    eventId: event.id,
                                  ),
                                ),
                              );
                            },
                            cells: [
                              DataCell(
                                Text(event.eventName),
                              ),
                              DataCell(
                                Text(event.location),
                              ),
                              DataCell(
                                Text(event.eventDate.toString()),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
            );
          },
        ),
        floatingActionButton: SecondaryButton(
          height: 30,
          width: 120,
          onPressed: () => _showEventModal(context),
          labelText: 'Add Fight',
        ),
      ),
    );
  }

  void _showEventModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CreateEventBloc(eventRepository),
          ),
          BlocProvider.value(
            value: BlocProvider.of<AccountBloc>(context),
          ),
        ],
        child: EventModal(),
      ),
    );
  }
}

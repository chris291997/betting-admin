import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/common/component/button/secondary_button.dart';
import 'package:bet/common/component/table/custom_data_table.dart';
import 'package:bet/event/data/di/event_service_locator.dart';
import 'package:bet/event/presentation/bloc/create_event_bloc.dart';
import 'package:bet/event/presentation/bloc/event_list_bloc.dart';
import 'package:bet/event/presentation/bloc/update_or_delete_event_bloc.dart';
import 'package:bet/event/presentation/component/event_modal.dart';
import 'package:bet/fight/presentation/screen/fight_list_screen.dart';
import 'package:bet/user/presentation/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  static const String routeName = "/events";

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
      child: const _EventScreen(),
    );
  }
}

class _EventScreen extends StatelessWidget {
  const _EventScreen();

  static const List<String> _columnNames = [
    'Name',
    'Location',
    'Event Date',
  ];
  static final _columns =
      _columnNames.map((column) => DataColumn(label: Text(column))).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: CustomDataTable<EventOutput>(
                columns: _columns,
                objects: events,
                onSelectChanged: (event) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FightListScreen(
                        eventId: event.id,
                      ),
                    ),
                  );
                },
              ),
              // child: DataTable2(
              //   columnSpacing: 12,
              //   horizontalMargin: 12,
              //   minWidth: 100,
              //   columns: _columns,
              //   showHeadingCheckBox: false,
              //   showCheckboxColumn: false,
              //   empty: const Center(child: Text('No data')),
              //   rows: events
              //       .map((event) => DataRow(
              //             onSelectChanged: (value) {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => FightListScreen(
              //                     eventId: event.id,
              //                   ),
              //                 ),
              //               );
              //             },
              //             cells: [
              //               DataCell(
              //                 Text(event.eventName),
              //               ),
              //               DataCell(
              //                 Text(event.location),
              //               ),
              //               DataCell(
              //                 Text(event.eventDate.toString()),
              //               ),
              //             ],
              //           ))
              //       .toList(),
              // ),
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
    );
  }

  void _showEventModal(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CreateEventBloc(eventRepository),
          ),
          BlocProvider.value(
            value: BlocProvider.of<AccountBloc>(context),
          ),
        ],
        child: BlocConsumer<CreateEventBloc, CreateEventState>(
          listener: (context, state){
            if (state.status.isSuccess) {
              BlocProvider.of<EventListBloc>(parentContext)
                  .add(EventListEventFetched());
              Navigator.pop(parentContext);
            }
          },
          builder: (context, state) {
            return EventModal(
              modalType: EventModalType.add,
              createOrUpdateButtonState: state.status.isLoading
                  ? PrimaryButtonState.loading
                  : PrimaryButtonState.enabled,
              onEventNameChanged: (value) =>
                  BlocProvider.of<CreateEventBloc>(parentContext)
                      .add(EventCreateEventNameAdded(value)),
              onLocationChanged: (value) =>
                  BlocProvider.of<CreateEventBloc>(parentContext)
                      .add(EventCreateEventLocationAdded(value)),
              onDateChanged: (value) =>
                  BlocProvider.of<CreateEventBloc>(parentContext)
                      .add(EventCreateEventDateAdded(value)),
              createOrUpdateButtonOnPressed: () {
                BlocProvider.of<EventListBloc>(parentContext)
                    .add(EventListEventFetched());
                Navigator.pop(parentContext);
              },
            );
          },
        ),
      ),
    );
  }
}

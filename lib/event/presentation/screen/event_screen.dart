import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/common/component/button/secondary_button.dart';
import 'package:bet/common/component/table/custom_data_table.dart';
import 'package:bet/event/data/di/event_service_locator.dart';
import 'package:bet/event/presentation/bloc/create_event_bloc.dart';
import 'package:bet/event/presentation/bloc/event_list_bloc.dart';
import 'package:bet/event/presentation/bloc/update_or_delete_event_bloc.dart';
import 'package:bet/event/presentation/component/delete_event_modal.dart';
import 'package:bet/event/presentation/component/event_modal.dart';
import 'package:bet/fight/presentation/screen/fight_list_screen.dart';
import 'package:bet/user/presentation/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  static const String routeName = "/";

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
      body: BlocListener<UpdateOrDeleteEventBloc, UpdateOrDeleteState>(
        listener: (context, state) {
          if (state.deleteStatus.isSuccess || state.updateStatus.isSuccess) {
            BlocProvider.of<EventListBloc>(context)
                .add(EventListEventFetched());
          }
        },
        child: BlocBuilder<EventListBloc, EventListState>(
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

            if (events.isEmpty) {
              return const Center(child: Text('No events found'));
            }

            return BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
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
                    onDelete: (event) => showDialog(
                      context: context,
                      builder: (_) =>
                          BlocProvider<UpdateOrDeleteEventBloc>.value(
                        value: BlocProvider.of<UpdateOrDeleteEventBloc>(
                          context,
                        ),
                        child: DeleteEventModal(
                          eventId: event.id,
                        ),
                      ),
                    ),
                    onUpdate: (event) {
                      _showEventModal(
                        context,
                        EventModalType.edit,
                        initialEventValue: event,
                        creatorId: state.userOutput.id,
                      );
                    },
                  ),
                ),
              );
            });
          },
        ),
      ),
      floatingActionButton: SecondaryButton(
        height: 30,
        width: 120,
        onPressed: () => _showEventModal(context, EventModalType.add),
        labelText: 'Add Event',
      ),
    );
  }

  void _showEventModal(
    BuildContext parentContext,
    EventModalType modalType, {
    EventOutput? initialEventValue,
    String? creatorId,
  }) {
    showDialog(
      context: parentContext,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CreateEventBloc(eventRepository),
          ),
          BlocProvider(
            create: (context) => UpdateOrDeleteEventBloc(eventRepository)
              ..add(
                EventUpdateInitialized(
                  creatorId ?? '',
                  initialEventValue ?? EventOutput.empty,
                ),
              ),
          ),
          BlocProvider.value(
            value: BlocProvider.of<AccountBloc>(context),
          ),
        ],
        child: BlocConsumer<CreateEventBloc, CreateEventState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              BlocProvider.of<EventListBloc>(parentContext)
                  .add(EventListEventFetched());
              Navigator.pop(context);
            }
          },
          builder: (context, createState) {
            return BlocConsumer<UpdateOrDeleteEventBloc, UpdateOrDeleteState>(
              listener: (context, state) {
                if (state.updateStatus.isSuccess) {
                  BlocProvider.of<EventListBloc>(parentContext)
                      .add(EventListEventFetched());
                  Navigator.pop(context);
                }
              },
              builder: (context, updateState) {
                return EventModal(
                  modalType: modalType,
                  initialEventValue: initialEventValue ?? const EventOutput(),
                  createOrUpdateButtonState: createState.status.isLoading ||
                          updateState.updateStatus.isLoading
                      ? PrimaryButtonState.loading
                      : PrimaryButtonState.enabled,
                  onEventNameChanged: (value) {
                    if (modalType.isCreate) {
                      context
                          .read<CreateEventBloc>()
                          .add(EventCreateEventNameAdded(value));
                    } else {
                      context
                          .read<UpdateOrDeleteEventBloc>()
                          .add(EventUpdateEventNameAdded(value));
                    }
                  },
                  onLocationChanged: (value) {
                    if (modalType.isCreate) {
                      context
                          .read<CreateEventBloc>()
                          .add(EventCreateEventLocationAdded(value));
                    } else {
                      context
                          .read<UpdateOrDeleteEventBloc>()
                          .add(EventUpdateEventLocationAdded(value));
                    }
                  },
                  onDateChanged: (value) {
                    if (modalType.isCreate) {
                      context
                          .read<CreateEventBloc>()
                          .add(EventCreateEventDateAdded(value));
                    } else {
                      context
                          .read<UpdateOrDeleteEventBloc>()
                          .add(EventUpdateEventDateAdded(value));
                    }
                  },
                  createOrUpdateButtonOnPressed: () {
                    if (modalType.isCreate) {
                      final creatorId = BlocProvider.of<AccountBloc>(context)
                          .state
                          .userOutput
                          .id;

                      context.read<CreateEventBloc>().add(
                            EventCreatedEventCreatorAdded(
                              creatorId,
                            ),
                          );

                      BlocProvider.of<CreateEventBloc>(context)
                          .add(EventCreated());
                    } else {
                      context.read<UpdateOrDeleteEventBloc>().add(
                            EventUpdateEvent(
                              initialEventValue?.id ?? '',
                            ),
                          );
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

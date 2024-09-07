import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/common/component/table/custom_data_table.dart';
import 'package:bet/fight/data/di/fight_service_locator.dart';
import 'package:bet/fight/presentation/bloc/create_fight_bloc.dart';
import 'package:bet/fight/presentation/bloc/fight_list_bloc.dart';
import 'package:bet/fight/presentation/bloc/fight_update_or_delete_bloc.dart';
import 'package:bet/fight/presentation/components/fight_modal.dart';
import 'package:bet/fight/presentation/screen/fight_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FightListScreen extends StatelessWidget {
  const FightListScreen({super.key, required this.eventId});

  final String eventId;

  static const String routeName = "/fights";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            lazy: false,
            create: (context) => FightListBloc(fightRepository, eventId)
              ..add(
                FightListFetched(eventId),
              )),
        BlocProvider(
          create: (context) =>
              FightUpdateOrDeleteBloc(fightRepository, eventId),
        ),
      ],
      child: _FightListScreen(
        eventId: eventId,
      ),
    );
  }
}

class _FightListScreen extends StatelessWidget {
  const _FightListScreen({
    required this.eventId,
  });

  final String eventId;

  static const List<String> _columnNames = [
    'Fight #',
    'Start Time',
    'Created At',
    'Updated At'
  ];
  static final _columns =
      _columnNames.map((column) => DataColumn(label: Text(column))).toList();

  void _showCreateFightModal(
    BuildContext parentContext,
    FightModalType modalType, {
    FightOutput? fight,
  }) {
    showDialog(
      context: parentContext,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CreateFightBloc(fightRepository, eventId),
          ),
          BlocProvider(
            create: (context) =>
                FightUpdateOrDeleteBloc(fightRepository, eventId)
                  ..add(
                    FightUpdateInitialized(
                      fight ?? const FightOutput(),
                    ),
                  ),
          ),
          BlocProvider.value(
            value: BlocProvider.of<FightListBloc>(parentContext),
          ),
        ],
        child: BlocConsumer<CreateFightBloc, CreateFightState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.read<FightListBloc>().add(FightListFetched(eventId));

              Navigator.pop(context);
            }
          },
          builder: (context, createState) {
            return BlocConsumer<FightUpdateOrDeleteBloc,
                FightUpdateOrDeleteState>(
              listener: (context, state) {
                if (state.updateStatus.isSuccess) {
                  context.read<FightListBloc>().add(FightListFetched(eventId));
                  Navigator.pop(context);
                }
              },
              builder: (context, udpateState) {
                return FightModal(
                  type: modalType,
                  createOrUpdateFightButtonState:
                      createState.status.isLoading ||
                              udpateState.updateStatus.isLoading
                          ? PrimaryButtonState.loading
                          : PrimaryButtonState.enabled,
                  onNumberChanged: (value) {
                    final fightNumber = int.tryParse(value);
                    if (fightNumber != null) {
                      if (modalType.isAdd) {
                        context.read<CreateFightBloc>().add(
                              FightCreateEventFightNumAdded(fightNumber),
                            );
                      } else {
                        context.read<FightUpdateOrDeleteBloc>().add(
                              FightUpdateEventFightNumAdded(fightNumber),
                            );
                      }
                    }
                  },
                  onTimeChanged: (startTime) {
                    if (modalType.isAdd) {
                      context.read<CreateFightBloc>().add(
                            FightCreateEventStartTimeAdded(
                              '${startTime.hour}:${startTime.minute} ${startTime.period.name}',
                            ),
                          );
                    } else {
                      context.read<FightUpdateOrDeleteBloc>().add(
                            FightUpdateEventStartTimeAdded(
                              '${startTime.hour}:${startTime.minute} ${startTime.period.name}',
                            ),
                          );
                    }
                  },
                  onMeronSelected: (fighter) {
                    if (modalType.isAdd) {
                      context.read<CreateFightBloc>().add(
                            FightCreateEventMeronAdded(
                              fighter.id,
                            ),
                          );
                    } else {
                      context.read<FightUpdateOrDeleteBloc>().add(
                            FightUpdateEventMeronAdded(
                              fighter.id,
                            ),
                          );
                    }
                  },
                  onWalaSelected: (fighter) {
                    if (modalType.isAdd) {
                      context.read<CreateFightBloc>().add(
                            FightCreateEventWalaAdded(
                              fighter.id,
                            ),
                          );
                    } else {
                      context.read<FightUpdateOrDeleteBloc>().add(
                            FightUpdateEventWalaAdded(
                              fighter.id,
                            ),
                          );
                    }
                  },
                  createOrUpdateFightSubmitted: () {
                    if (modalType.isAdd) {
                      context.read<CreateFightBloc>().add(FightCreated());
                    } else {
                      context
                          .read<FightUpdateOrDeleteBloc>()
                          .add(FightUpdateEvent(fight?.id ?? ''));
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FightUpdateOrDeleteBloc, FightUpdateOrDeleteState>(
          listener: (context, state) {
            if (state.deleteStatus.isSuccess) {
              context.read<FightListBloc>().add(FightListFetched(eventId));
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Fights')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      context
                          .read<FightListBloc>()
                          .add(FightListFetched(eventId));
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                  // Add
                  IconButton(
                    onPressed: () =>
                        _showCreateFightModal(context, FightModalType.add),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              Expanded(
                child: BlocBuilder<FightListBloc, FightListState>(
                  builder: (context, state) {
                    if (state.status.isError) {
                      return const Center(
                          child: Text('Failed to fetch events'));
                    }

                    if (state.status.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.status.isInitial) {
                      return const SizedBox();
                    }

                    final fights = state.fights
                      ..sort((a, b) {
                        return a.fightNumber.compareTo(b.fightNumber);
                      });

                    return CustomDataTable<FightOutput>(
                      columns: _columns,
                      objects: fights,
                      onSelectChanged: (fight) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FightDetailsScreen(fight: fight),
                          ),
                        );
                      },
                      onDelete: (fight) async {
                        await showDialog(
                          context: context,
                          builder: (_) =>
                              BlocProvider<FightUpdateOrDeleteBloc>.value(
                            value: context.read<FightUpdateOrDeleteBloc>(),
                            child: _DeleteFightDialog(
                              fightNumber: fight.fightNumber,
                              fightId: fight.id,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeleteFightDialog extends StatelessWidget {
  const _DeleteFightDialog({required this.fightNumber, required this.fightId});

  final int fightNumber;
  final String fightId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Fight'),
      content: Text('Are you sure you want to delete fight #$fightNumber?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.read<FightUpdateOrDeleteBloc>().add(FightDeleted(fightId));
            Navigator.pop(context);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}

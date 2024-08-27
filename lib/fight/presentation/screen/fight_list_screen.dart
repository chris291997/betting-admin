import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/common/component/button/secondary_button.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text('Fights')),
      body: BlocBuilder<FightListBloc, FightListState>(
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

          final fights = state.fights;

          return Center(
            child: SizedBox(
              width: 1000,
              child: CustomDataTable<FightOutput>(
                columns: _columns,
                objects: fights,
                onSelectChanged: (fight) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FightDetailsScreen(fight: fight),
                    ),
                  );
                },
                onDelete: (fight) {
                  BlocProvider.of<FightUpdateOrDeleteBloc>(context)
                      .add(FightDeleted(fight.id));
                },
                onUpdate: (fight) {
                  _showCreateFightModal(context, FightModalType.edit,
                      fight: fight);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: SecondaryButton(
        height: 30,
        width: 120,
        onPressed: () => _showCreateFightModal(context, FightModalType.add),
        labelText: 'Add Fight',
      ),
    );
  }
}

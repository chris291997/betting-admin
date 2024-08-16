import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/common/component/button/secondary_button.dart';
import 'package:bet/common/component/table/custom_data_table.dart';
import 'package:bet/fight/data/di/fight_service_locator.dart';
import 'package:bet/fight/presentation/bloc/create_fight_bloc.dart';
import 'package:bet/fight/presentation/bloc/fight_list_bloc.dart';
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
            lazy: false, create: (context) => FightListBloc(fightRepository)),
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

  void _showCreateFighterModal(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CreateFightBloc(fightRepository, eventId),
          ),
          BlocProvider.value(
            value: BlocProvider.of<FightListBloc>(context),
          ),
        ],
        child: BlocConsumer<CreateFightBloc, CreateFightState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              BlocProvider.of<FightListBloc>(parentContext)
                  .add(FightListFetched(eventId));

              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return FightModal(
              type: FightModalType.add,
              createOrUpdateFightButtonState: state.status.isLoading
                  ? PrimaryButtonState.loading
                  : PrimaryButtonState.enabled,
              onNumberChanged: (value) {
                final fightNumber = int.tryParse(value);
                if (fightNumber != null) {
                  BlocProvider.of<CreateFightBloc>(context).add(
                    FightCreateEventFightNumAdded(fightNumber),
                  );
                }
              },
              onTimeChanged: (startTime) {
                BlocProvider.of<CreateFightBloc>(context).add(
                  FightCreateEventStartTimeAdded(startTime.toString()),
                );
              },
              onMeronSelected: (fighter) {
                BlocProvider.of<CreateFightBloc>(context).add(
                  FightCreateEventMeronAdded(
                    fighter.id,
                  ),
                );
              },
              onWalaSelected: (fighter) {
                BlocProvider.of<CreateFightBloc>(context).add(
                  FightCreateEventWalaAdded(
                    fighter.id,
                  ),
                );
              },
              createOrUpdateFightSubmitted: () {
                BlocProvider.of<CreateFightBloc>(context).add(
                  FightCreateEventStartTimeAdded(eventId),
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
                      builder: (context) => const FightDetailsScreen(),
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
              //   rows: fights
              //       .map((fight) => DataRow(
              //             onSelectChanged: (value) {
              //               Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) =>
              //                           const FightDetailsScreen()));
              //             },
              //             cells: [
              //               DataCell(
              //                 Text(fight.fightNumber.toString()),
              //               ),
              //               DataCell(
              //                 Text(fight.startTime),
              //               ),
              //               DataCell(
              //                 Text(fight.createdAt.toString()),
              //               ),
              //               DataCell(
              //                 Text(fight.updatedAt.toString()),
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
        onPressed: () => _showCreateFighterModal(context),
        labelText: 'Add Fight',
      ),
    );
  }
}

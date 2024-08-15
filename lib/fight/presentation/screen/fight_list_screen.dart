import 'package:bet/common/component/button/secondary_button.dart';
import 'package:bet/fight/data/di/fight_service_locator.dart';
import 'package:bet/fight/presentation/bloc/create_fight_bloc.dart';
import 'package:bet/fight/presentation/bloc/fight_list_bloc.dart';
import 'package:bet/fight/presentation/components/fight_modal.dart';
import 'package:bet/fight/presentation/screen/fight_details_screen.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FightListScreen extends StatelessWidget {
  const FightListScreen({super.key, required this.eventId});

  final String eventId;

  static const String routeName = "/fights";
  static const List<String> _columnNames = [
    'Fight #',
    'Start Time',
    'Created At',
    'Updated At'
  ];
  static final _columns =
      _columnNames.map((column) => DataColumn(label: Text(column))).toList();

  void _showCreateFighterModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CreateFightBloc(fightRepository, eventId),
          ),
        ],
        child: const FightModal(
          type: FightModalType.add,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            lazy: false, create: (context) => FightListBloc(fightRepository)),
      ],
      child: Scaffold(
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
                child: DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 100,
                  columns: _columns,
                  showHeadingCheckBox: false,
                  showCheckboxColumn: false,
                  rows: fights
                      .map((fight) => DataRow(
                            onSelectChanged: (value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FightDetailsScreen()));
                            },
                            cells: [
                              DataCell(
                                Text(fight.fightNumber.toString()),
                              ),
                              DataCell(
                                Text(fight.startTime),
                              ),
                              DataCell(
                                Text(fight.createdAt.toString()),
                              ),
                              DataCell(
                                Text(fight.updatedAt.toString()),
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
          onPressed: () => _showCreateFighterModal(context),
          labelText: 'Add Fight',
        ),
      ),
    );
  }
}

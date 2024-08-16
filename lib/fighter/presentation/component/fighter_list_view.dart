import 'package:bet/fighter/data/di/fighter_service_locator.dart';
import 'package:bet/fighter/presentation/bloc/fighter_list_bloc.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FighterListView extends StatelessWidget {
  const FighterListView({
    super.key,
    this.initialSelectedFighter,
    this.onFighterSelected,
  });

  final FighterOutput? initialSelectedFighter;
  final Function(FighterOutput)? onFighterSelected;

  static const List<String> _columnNames = [
    'Name',
    'Weight',
    'Breed',
    'Trainer'
  ];
  static final _columns =
      _columnNames.map((column) => DataColumn(label: Text(column))).toList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FighterListBloc, FighterListState>(
      builder: (context, state) {
        if (state.status.isError) {
          return const Center(child: Text('Failed to fetch fighters'));
        }

        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status.isInitial) {
          return const SizedBox();
        }

        final fighters = state.fighters;

        return DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 100,
          columns: _columns,
          showHeadingCheckBox: false,
          showCheckboxColumn: false,
          rows: fighters
              .map((fighter) => DataRow(
                    color: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        if (fighter.id == (initialSelectedFighter?.id ?? '')) {
                          return Colors.grey;
                        }
                        return null;
                      },
                    ),
                    onSelectChanged: (value) {},
                    cells: [
                      DataCell(
                        Text(fighter.name),
                      ),
                      DataCell(
                        Text(fighter.weight.toString()),
                      ),
                      DataCell(
                        Text(fighter.breed),
                      ),
                      DataCell(
                        Text(fighter.trainer),
                      ),
                    ],
                  ))
              .toList(),
        );
      },
    );
  }
}

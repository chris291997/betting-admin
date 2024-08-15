import 'package:bet/common/component/button/secondary_button.dart';
import 'package:bet/fight/presentation/components/fight_modal.dart';
import 'package:bet/fight/presentation/screen/fight_details_screen.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class FightListScreen extends StatelessWidget {
  const FightListScreen({super.key});

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
      builder: (context) => FightModal(
        type: FightModalType.add,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fights')),
      body: Center(
        child: SizedBox(
          width: 1000,
          child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 100,
            columns: _columns,
            showHeadingCheckBox: false,
            showCheckboxColumn: false,
            rows: List<DataRow>.generate(
              100,
              (index) => DataRow(
                onSelectChanged: (value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FightDetailsScreen()));
                },
                cells: const [
                  DataCell(
                    Text('A'),
                  ),
                  DataCell(
                    Text('B'),
                  ),
                  DataCell(
                    Text('C'),
                  ),
                  DataCell(
                    Text(
                      'D',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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

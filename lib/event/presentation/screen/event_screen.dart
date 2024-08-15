import 'package:bet/common/component/button/secondary_button.dart';
import 'package:bet/event/presentation/component/event_modal.dart';
import 'package:bet/fight/presentation/screen/fight_list_screen.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
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
                        builder: (context) => const FightListScreen()),
                  );
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
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: SecondaryButton(
        height: 30,
        width: 120,
        onPressed: () => _showEventModal(context),
        labelText: 'Add Fight',
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

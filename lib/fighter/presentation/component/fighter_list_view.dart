import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class FighterListView extends StatelessWidget {
  const FighterListView({super.key});
  static const List<String> _columnNames = ['Name', 'Weight', 'Breed', 'Owner'];
  static final _columns =
      _columnNames.map((column) => DataColumn(label: Text(column))).toList();

  @override
  Widget build(BuildContext context) {
    return DataTable2(
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
            print('row $index selected');
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
    );
  }
}

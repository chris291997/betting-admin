import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class CustomDataTable extends StatelessWidget {
  const CustomDataTable({
    super.key,
    required this.columns,
    required this.objects,
    required this.onSelectChanged,
  });

  final List<DataColumn> columns;
  final List<Map<String, dynamic>> objects;
  final void Function(bool?) onSelectChanged;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 100,
      columns: columns,
      showHeadingCheckBox: false,
      showCheckboxColumn: false,
      rows: List<DataRow>.generate(
        objects.length,
        (index) {
          final object = objects[index];
          final cells = object.values
              .map((value) => DataCell(Text(value.toString())))
              .toList();

          return DataRow(
            onSelectChanged: onSelectChanged,
            cells: cells,
          );
        },
      ),
    );
  }
}

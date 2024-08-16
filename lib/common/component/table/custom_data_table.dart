import 'package:bet/common/abstract/json_serializable.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class CustomDataTable<T extends JsonSerializable> extends StatelessWidget {
  const CustomDataTable({
    super.key,
    required this.columns,
    required this.objects,
    required this.onSelectChanged,
  });

  final List<DataColumn> columns;
  final List<T> objects;
  final void Function(T) onSelectChanged;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 100,
      columns: columns,
      showHeadingCheckBox: false,
      showCheckboxColumn: false,
      rows: objects
          .map((object) => DataRow(
                onSelectChanged: (_) => onSelectChanged(object),
                cells: (object.toTableJson())
                    .values
                    .map((value) => DataCell(Text(value.toString())))
                    .toList(),
              ))
          .toList(),
    );
  }
}

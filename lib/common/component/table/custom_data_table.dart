import 'package:bet/common/abstract/json_serializable.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class CustomDataTable<T extends JsonSerializable> extends StatelessWidget {
  const CustomDataTable({
    super.key,
    required this.columns,
    required this.objects,
    required this.onSelectChanged,
    required this.onUpdate,
    required this.onDelete,
  });

  final List<DataColumn> columns;
  final List<T> objects;
  final void Function(T) onSelectChanged;
  final void Function(T) onUpdate;
  final void Function(T) onDelete;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 100,
      columns: [
        ...columns,
        const DataColumn(
          label: Text(''),
        ),
        const DataColumn(
          label: Text(''),
        )
      ],
      showHeadingCheckBox: false,
      showCheckboxColumn: false,
      rows: objects
          .map((object) => DataRow(
                onSelectChanged: (_) => onSelectChanged(object),
                cells: [
                  ...(object.toTableJson()).values.map(
                        (value) => DataCell(
                          Text(
                            value.toString(),
                          ),
                        ),
                      ),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => onUpdate(object),
                    ),
                  ),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => onDelete(object),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}

import 'package:bet/common/abstract/json_serializable.dart';
import 'package:bet/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class CustomDataTable<T extends JsonSerializable> extends StatelessWidget {
  const CustomDataTable({
    super.key,
    required this.columns,
    required this.objects,
    required this.onSelectChanged,
    this.onUpdate,
    this.onDelete,
  });

  final List<DataColumn> columns;
  final List<T> objects;
  final void Function(T) onSelectChanged;
  final void Function(T)? onUpdate;
  final void Function(T)? onDelete;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 100,
      headingRowDecoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: Color(0xFF2c4972),
      ),
      headingTextStyle: context.textStyle.bodyText1.copyWith(
        color: context.colors.onPrimary,
      ),
      dataRowColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return const Color(0xFF6a96b9).withOpacity(0.3);
          }
          if (states.contains(WidgetState.hovered)) {
            return const Color(0xFF6a96b9).withOpacity(0.6);
          }
          return const Color(0xFF6a96b9).withOpacity(0.5);
        },
      ),
      dataTextStyle: context.textStyle.caption.copyWith(
        color: context.colors.primary,
      ),
      columns: [
        ...columns,
        if (onUpdate != null || onDelete != null)
          const DataColumn(label: Text('')),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (onUpdate != null)
                          GestureDetector(
                            child: Icon(
                              Icons.edit,
                              color: context.colors.primary,
                            ),
                            onTap: () => onUpdate?.call(object),
                          ),
                        if (onDelete != null)
                          GestureDetector(
                            child: Icon(
                              Icons.delete,
                              color: context.colors.errorContainer
                                  .withOpacity(0.7),
                            ),
                            onTap: () => onDelete?.call(object),
                          ),
                      ],
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}

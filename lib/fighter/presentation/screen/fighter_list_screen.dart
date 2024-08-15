import 'package:bet/common/component/button/secondary_button.dart';
import 'package:bet/fighter/presentation/component/fighter_list_view.dart';
import 'package:bet/fighter/presentation/component/fighter_modal.dart';
import 'package:flutter/material.dart';

class FighterListScreen extends StatelessWidget {
  const FighterListScreen({super.key});

  static const String routeName = "/fights";

  void _showCreateFighterModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FighterModal(
        type: FighterModalType.add,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fighters')),
      body: const Center(
        child: SizedBox(
          width: 1000,
          child: FighterListView(),
        ),
      ),
      floatingActionButton: SecondaryButton(
        height: 30,
        width: 120,
        onPressed: () => _showCreateFighterModal(context),
        labelText: 'Add Fighter',
      ),
    );
  }
}

// class FighterScreen extends StatelessWidget {
//   FighterScreen({super.key});

//   static const String routeName = "/fights";

//   final List<PlutoColumn> columns = [
//     PlutoColumn(
//       title: 'Name',
//       field: 'name_field',
//       type: PlutoColumnType.text(),
//     ),

//     /// Number Column definition
//     PlutoColumn(
//       title: 'Weight',
//       field: 'weight_field',
//       type: PlutoColumnType.number(),
//     ),

//     PlutoColumn(
//       title: 'Breed',
//       field: 'breed_field',
//       type: PlutoColumnType.text(),
//     ),

//     PlutoColumn(
//       title: 'Owner',
//       field: 'owner_field',
//       type: PlutoColumnType.text(),
//     ),

//     /// Select Column definition
//     // PlutoColumn(
//     //   title: 'Breed',
//     //   field: 'select_field',
//     //   type: PlutoColumnType.select(['item1', 'item2', 'item3']),
//     // ),

//     // /// Datetime Column definition
//     // PlutoColumn(
//     //   title: 'date column',
//     //   field: 'date_field',
//     //   type: PlutoColumnType.date(),
//     // ),

//     // /// Time Column definition
//     // PlutoColumn(
//     //   title: 'time column',
//     //   field: 'time_field',
//     //   type: PlutoColumnType.time(),
//     // ),
//   ];

//   final List<PlutoRow> rows = [
//     PlutoRow(
//       type: PlutoRowType.normal(),
//       cells: {
//         // 'text_field': PlutoCell(value: 'Text cell value1'),
//         // 'number_field': PlutoCell(value: 2020),
//         // 'select_field': PlutoCell(value: 'item1'),
//         // 'date_field': PlutoCell(value: '2020-08-06'),
//         // 'time_field': PlutoCell(value: '12:30'),
//         'name_field': PlutoCell(value: 'Rex'),
//         'weight_field': PlutoCell(value: 20),
//         'breed_field': PlutoCell(value: 'Pitbull'),
//         'owner_field': PlutoCell(value: 'John Doe'),
//       },
//     ),
//     PlutoRow(
//       cells: {
//         // 'text_field': PlutoCell(value: 'Text cell value2'),
//         // 'number_field': PlutoCell(value: 2021),
//         // 'select_field': PlutoCell(value: 'item2'),
//         // 'date_field': PlutoCell(value: '2020-08-07'),
//         // 'time_field': PlutoCell(value: '18:45'),
//         'name_field': PlutoCell(value: 'Rex'),
//         'weight_field': PlutoCell(value: 20),
//         'breed_field': PlutoCell(value: 'Pitbull'),
//         'owner_field': PlutoCell(value: 'Jane Doe'),
//       },
//     ),
//     PlutoRow(
//       cells: {
//         // 'text_field': PlutoCell(value: 'Text cell value3'),
//         // 'number_field': PlutoCell(value: 2022),
//         // 'select_field': PlutoCell(value: 'item3'),
//         // 'date_field': PlutoCell(value: '2020-08-08'),
//         // 'time_field': PlutoCell(value: '23:59'),
//         'name_field': PlutoCell(value: 'Rex'),
//         'weight_field': PlutoCell(value: 20),
//         'breed_field': PlutoCell(value: 'Pitbull'),
//         'owner_field': PlutoCell(value: 'John Doe'),
//       },
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Event Creator")),
//       body: Center(
//         child: PlutoGrid(
//           columns: columns,
//           rows: rows,
//           onChanged: (PlutoGridOnChangedEvent event) {
//             print(event);
//           },
//           onLoaded: (PlutoGridOnLoadedEvent event) {
//             print(event);
//           },
//           configuration: PlutoGridConfiguration(

//           ),
//         ),
//       ),
//     );
//   }

//   // void _showEventModal(BuildContext context) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) => EventModal(),
//   //   );
//   // }
// }

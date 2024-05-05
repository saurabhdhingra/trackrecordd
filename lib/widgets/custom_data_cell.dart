import 'package:flutter/material.dart';
import 'package:trackrecordd/models/exercise.dart';
// import 'package:trackrecord/screens/exerciseScreen.dart';

class CustomDataTable extends StatelessWidget {
  final Exercise exercise;

  const CustomDataTable({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowHeight: 0,
      dividerThickness: 0,
      columns: const <DataColumn>[
        DataColumn(label: SizedBox()),
        DataColumn(label: SizedBox()),
        DataColumn(label: SizedBox()),
      ],
      rows: List.generate(
        exercise.sets.length,
        (index) {
          return DataRow(
            cells: <DataCell>[
              DataCell(
                Text('Set ${index + 1}'),
              ),
              DataCell(
                Text('${exercise.sets[index]["reps"]} reps'),
              ),
              DataCell(
                Text('${exercise.sets[index]["weight"]} kgs'),
              ),
            ],
          );
        },
      ),
    );
  }
}

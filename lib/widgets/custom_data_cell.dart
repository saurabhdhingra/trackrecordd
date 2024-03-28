import 'package:flutter/material.dart';
// import 'package:trackrecord/screens/exerciseScreen.dart';

class CustomDataTable extends StatefulWidget {
  final String name;
  final String reps1;
  final String weight1;
  final String reps2;
  final String weight2;
  final String reps3;
  final String weight3;

  const CustomDataTable(
      {Key? key,
      required this.reps1,
      required this.weight1,
      required this.reps2,
      required this.weight2,
      required this.reps3,
      required this.weight3,
      required this.name})
      : super(key: key);

  @override
  _CustomDataTableState createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  String weight1 = "";
  String weight2 = "";
  String weight3 = "";
  String weight4 = "";
  String weight5 = "";

  bool set2 = true;
  bool set3 = true;
  bool set4 = true;
  bool set5 = true;

  void check() {
    if (widget.reps2 == 'null') {
      set2 = false;
    }
    if (widget.reps3 == 'null') {
      set3 = false;
    }
    // if (widget.reps4 == 'null') {
    //   set4 = false;
    // }
    // if (widget.reps5 == 'null') {
    //   set5 = false;
    // }
    if (widget.weight1 == 'null') {
      weight1 = "-";
    }
    if (widget.weight2 == 'null') {
      weight2 = "-";
    }
    if (widget.weight3 == 'null') {
      weight3 = "-";
    }
    // if (widget.weight4 == 'null') {
    //   weight4 = "-";
    // }
    // if (widget.weight5 == 'null') {
    //   weight5 = "-";
    // }
  }

  @override
  void initState() {
    check();
    super.initState();

    weight1 = widget.weight1;
    weight2 = widget.weight2;
    weight3 = widget.weight3;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ExerciseScreen(
        //               name: widget.name,
        //             )));
      },
      // child: ListView.separated(
      //     itemBuilder: (context, i) => Row(),
      //     separatorBuilder: (context, i) => Divider(
      //           thickness: 1,
      //         ),
      //     itemCount: itemCount),
      child: DataTable(
        headingRowHeight: 0,
        dividerThickness: 0,
        columns: const <DataColumn>[
          DataColumn(label: SizedBox()),
          DataColumn(label: SizedBox()),
          DataColumn(label: SizedBox()),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              const DataCell(
                Text('Set 1'),
              ),
              DataCell(
                Text('${widget.reps1} reps'),
              ),
              DataCell(
                Text('$weight1 kgs'),
              ),
            ],
          ),
          set2
              ? DataRow(
                  cells: <DataCell>[
                    const DataCell(
                      Text('Set 2'),
                    ),
                    DataCell(
                      Text('${widget.reps2} reps'),
                    ),
                    DataCell(
                      Text('$weight2 kgs'),
                    ),
                  ],
                )
              : const DataRow(cells: [
                  DataCell(SizedBox()),
                  DataCell(SizedBox()),
                  DataCell(SizedBox())
                ]),
          set3
              ? DataRow(
                  cells: <DataCell>[
                    const DataCell(
                      Text('Set 3'),
                    ),
                    DataCell(
                      Text('${widget.reps3} reps'),
                    ),
                    DataCell(
                      Text('$weight3 kgs'),
                    ),
                  ],
                )
              : const DataRow(cells: [
                  DataCell(SizedBox()),
                  DataCell(SizedBox()),
                  DataCell(SizedBox())
                ]),
        ],
      ),
    );
  }
}

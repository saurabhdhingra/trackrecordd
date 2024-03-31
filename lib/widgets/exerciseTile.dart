// import 'package:trackrecord/screens/exerciseScreen.dart';
// import 'package:trackrecord/screens/updateScreen.dart';
import 'package:flutter/material.dart';
import 'custom_data_cell.dart';
import 'package:trackrecordd/utils/constants.dart';

class ExerciseWidget extends StatefulWidget {
  final String name;
  final String muscle;
  final String reps1;
  final String weight1;
  final String reps2;
  final String weight2;
  final String reps3;
  final String weight3;
  final int screen;

  const ExerciseWidget({
    Key? key,
    required this.name,
    required this.reps1,
    required this.weight1,
    required this.reps2,
    required this.weight2,
    required this.reps3,
    required this.weight3,
    required this.screen,
    required this.muscle,
  }) : super(key: key);

  @override
  _ExerciseWidgetState createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);

    final List<String> weights = [
      '',
      '1 kg',
      '2.5',
      '5',
      '7.5',
      '10',
      '12.5',
      '15',
      '17.5',
      '20',
      '22.5',
      '25',
      '27.5',
      '30',
      '32.5',
      '35',
      '37.5',
      '40',
      '42.5',
      '45',
      '47.5',
      '50',
      '55',
      '60',
      '65',
      '70',
      '75',
      '80',
      '85',
      '90',
      '95',
      '100',
      '110',
      '120',
      '130',
      '140',
      '150',
      '160',
      '170',
      '180',
      '190',
      '200',
      '210',
      '220',
      '230',
      '240',
      '250',
      '260',
      '270',
      '280',
      '290',
      '300',
    ];
    final List reps = [
      '',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
    ];

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (widget.screen == 1) {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ExerciseScreen(
              //               name: widget.name,
              //             )));
            }
          },
          onLongPress: () {
            if (widget.screen == 1) {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => UpdateScreen(
              //               name: widget.name,
              //               muscle: widget.muscle,
              //               reps1: reps.indexOf(widget.reps1),
              //               reps2: reps.indexOf(widget.reps2),
              //               reps3: reps.indexOf(widget.reps3),
              //               weight1: weights.indexOf(widget.weight1),
              //               weight2: weights.indexOf(widget.weight2),
              //               weight3: weights.indexOf(widget.weight3),
              //             )));
            }
          },
          child: SizedBox(
            width: width,
            child: Container(
              width: width * 0.9,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(height / 38)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.07,
                      ),
                      Text(
                        widget.name,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ],
                  ),
                  CustomDataTable(
                    name: widget.name,
                    weight1: widget.weight1,
                    weight2: widget.weight2,
                    weight3: widget.weight3,
                    reps1: widget.reps1,
                    reps2: widget.reps2,
                    reps3: widget.reps3,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: height * 0.01)
      ],
    );
  }
}

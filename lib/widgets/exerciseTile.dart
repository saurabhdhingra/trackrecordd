import 'package:flutter/material.dart';
import 'package:trackrecordd/models/exercise.dart';
import 'customDataCell.dart';
import 'package:trackrecordd/utils/constants.dart';

class ExerciseWidget extends StatelessWidget {
  final Exercise exercise;

  const ExerciseWidget({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);

    return Column(
      children: [
        SizedBox(
          width: width,
          child: Container(
            width: width * 0.9,
            margin: EdgeInsets.symmetric(horizontal: width * 0.05),
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
                      exercise.name,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ],
                ),
                CustomDataTable(
                  exercise: exercise,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: height * 0.01)
      ],
    );
  }
}

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
// import 'package:trackrecord/database/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:trackrecordd/widgets/dropdownSelector.dart';

import '../widgets/customField.dart';
// import 'addScreen.dart';

class CreateExercise extends StatefulWidget {
  final bool isExercise;
  const CreateExercise({Key? key, required this.isExercise}) : super(key: key);

  @override
  State<CreateExercise> createState() => _CreateExerciseState();
}

class _CreateExerciseState extends State<CreateExercise> {
  String exerciseName = "";
  int targetMuscle = 0;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    final List<String> muscles = [
      'Chest',
      'Back',
      'Shoulders',
      'Biceps',
      'Triceps',
      'Legs',
      'Core'
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // if (_formKey.currentState!.validate() && widget.isExercise) {
          //   DatabaseHelper.instance.insertExercise({
          //     DatabaseHelper.colExerciseName: exerciseName,
          //     DatabaseHelper.colTargetMuscle: muscles[targetMuscle]
          //   });
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => AddScreen(
          //         name: exerciseName,
          //         muscle: muscles[targetMuscle],
          //       ),
          //     ),
          //   );
          // } else if (_formKey.currentState!.validate() &&
          //     widget.isExercise == false) {
          //   DatabaseHelper.instance.insertExercise({
          //     DatabaseHelper.colExerciseName: exerciseName,
          //     DatabaseHelper.colTargetMuscle: muscles[targetMuscle]
          //   });
          //   Navigator.pushReplacement(context,
          //       MaterialPageRoute(builder: (context) => ExercisesEdit()));
          // }
        },
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        child: const Text(
          'Add',
          style: TextStyle(color: Color.fromRGBO(13, 125, 255, 1)),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: const Color.fromRGBO(243, 242, 247, 1),
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SafeArea(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.01),
              rowText(width, "Enter the name of the exercise"),
              SizedBox(height: height * 0.01),
              CustomField(
                setValue: (value) => setState(() => exerciseName = value),
              ),
              nameInput(width),
              SizedBox(height: height * 0.01),
              rowText(width, "Select target muscle"),
              SizedBox(height: height * 0.01),
              DropdownSelector(
                setState: (value) => setState(() => targetMuscle = value),
                items: muscles,
                dropDownValue: muscles[targetMuscle],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding muscleSelector(
      width, height, List<String> muscles, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.053, vertical: 16),
      child: Platform.isIOS
          ? CupertinoPicker(
              diameterRatio: 0.8,
              useMagnifier: true,
              magnification: 2,
              itemExtent: height * 0.035,
              onSelectedItemChanged: (int value) {
                setState(() {
                  targetMuscle = value;
                });
              },
              children: muscles
                  .map(
                    (e) => Center(
                      child: Text(
                        e.toString(),
                        style: TextStyle(
                            fontSize: width * 0.04,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  )
                  .toList(),
            )
          : DropdownButton<String>(
              isExpanded: true,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold),
              value: muscles[targetMuscle],
              onChanged: (value) {
                int intValue = value == null ? 0 : muscles.indexOf(value);
                setState(() {
                  targetMuscle = intValue;
                });
              },
              items: muscles
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Center(
                        child: Text(
                          e.toString(),
                          style: TextStyle(
                              fontSize: width * 0.04,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }

  Padding nameInput(width) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.07, vertical: 16),
      child: Form(
        key: _formKey,
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          cursorColor: Colors.black,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              exerciseName = value;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Row rowText(width, String text) {
    return Row(
      children: [
        SizedBox(width: width * 0.08),
        Text(
          text,
          style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
// import 'package:trackrecord/database/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:trackrecordd/database/exerciseInfoDataStore.dart';
import 'package:trackrecordd/models/exerciseInfo.dart';
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
  final List<String> muscleGroups = [
    'Chest',
    'Back',
    'Shoulders',
    'Biceps',
    'Triceps',
    'Legs',
    'Core'
  ];
  int muscleIndex = -1;
  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pop(
            context,
            ExerciseInfo(
              name: exerciseName,
              muscleGroup: muscleGroups[muscleIndex],
            ),
          );
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
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SafeArea(
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.01),
                CustomField(
                  setValue: (value) => setState(() => exerciseName = value),
                  hintText: "Name",
                ),
                SizedBox(height: height * 0.01),
                rowText(width, "Select target muscle"),
                SizedBox(height: height * 0.01),
                Container(
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(height / 50)),
                  ),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: muscleGroups.length,
                    itemBuilder: (context, i) {
                      final item = muscleGroups[i];
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, height * 0.01, 0, height * 0.01),
                        child: ListTile(
                          title: Text(
                            item,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          trailing: Icon(
                            muscleIndex == i
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off_outlined,
                            color: muscleIndex == i
                                ? Colors.blue
                                : Theme.of(context).colorScheme.secondary,
                          ),
                          onTap: () {
                            setState(() {
                              muscleIndex = i;
                            });
                          },
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        height: 1,
                        thickness: 1,
                        indent: width * 0.03,
                        endIndent: width * 0.03,
                      );
                    },
                  ),
                )
              ],
            ),
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

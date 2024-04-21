// import 'package:trackrecordd/screens/todayScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:trackrecordd/database/exerciseDataStore.dart';
import 'package:trackrecordd/models/exercise.dart';
import 'package:trackrecordd/utils/constants.dart';
// import 'package:trackrecord/database/db.dart';
import 'package:trackrecordd/utils/functions.dart';
import 'dart:io' show Platform;

import 'package:trackrecordd/views/homeView.dart';
import 'package:trackrecordd/widgets/customField.dart';
import 'package:trackrecordd/widgets/submitButton.dart';

class AddView extends StatefulWidget {
  final String name;
  final String muscle;

  const AddView({Key? key, required this.name, required this.muscle})
      : super(key: key);

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<Map<String, dynamic>> sets = [
    {
      "weight": 0,
      "reps": 0,
    }
  ];

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          widget.name,
          style: TextStyle(
            fontSize: width * 0.06,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.01),
              ...sets.map(
                (e) => setTile(height, width, sets.indexOf(e)),
              ),
              addButton(height, width),
              SizedBox(height: height * 0.01),
              SubmitButton(
                onSubmit: () {
                  Exercise exercise = Exercise(
                    date: DateTime.now(),
                    name: widget.name,
                    muscleGroup: widget.muscle,
                    sets: sets,
                  );
                  ExerciseDataStore dataStore = ExerciseDataStore();
                  dataStore.addExercise(exercise: exercise).then(
                        (value) => Navigator.pop(
                            context, "${exercise.toJson()},$value"),
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Divider divider(width) {
    return Divider(
        height: 0.01,
        thickness: 2,
        indent: width * 0.05,
        endIndent: width * 0.05);
  }

  SizedBox setTile(height, width, int index) {
    return SizedBox(
      height: height * 0.23,
      width: width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(width * 0.05, 0, 0, 0),
                child: Text(
                  "Set ${index + 1}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: height * 0.025),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, width * 0.05, 0),
                child: IconButton(
                  onPressed: () => setState(() {
                    sets.removeAt(index);
                  }),
                  icon: const Icon(CupertinoIcons.minus),
                ),
              ),
            ],
          ),
          CustomField(
            initialValue: sets[index]["reps"].toString(),
            setValue: (value) => sets[index]["reps"] = value,
            formKey: GlobalKey<FormState>(),
            hintText: "Reps",
          ),
          SizedBox(height: height * 0.02),
          CustomField(
            initialValue: sets[index]["weight"].toString(),
            setValue: (value) => sets[index]["weight"] = value,
            formKey: GlobalKey<FormState>(),
            hintText: "Weight",
            unit: "kgs",
          ),
        ],
      ),
    );
  }

  GestureDetector addButton(height, width) {
    return GestureDetector(
      onTap: () => setState(() {
        sets = sets +
            [
              {
                "weight": 0,
                "reps": 0,
              }
            ];
      }),
      child: Container(
        width: width * 0.85,
        height: height * 0.08,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(235, 235, 235, 1),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Row titleText(width) {
    return Row(
      children: [
        SizedBox(width: width * 0.05),
        Text(
          widget.name,
          style: TextStyle(
            fontSize: width * 0.06,
          ),
        ),
      ],
    );
  }
}

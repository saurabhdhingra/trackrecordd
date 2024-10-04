import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:trackrecordd/models/exercise.dart';
import 'package:trackrecordd/models/exerciseInfo.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:trackrecordd/widgets/customField.dart';
import 'package:trackrecordd/widgets/submitButton.dart';

import '../widgets/rowText.dart';

class AddOrEditView extends StatefulWidget {
  final Map<String, List> exerciseLists;
  final Exercise? exercise;
  const AddOrEditView({super.key, required this.exerciseLists, this.exercise});

  @override
  State<AddOrEditView> createState() => _AddOrEditViewState();
}

class _AddOrEditViewState extends State<AddOrEditView> {
  final _formKey = GlobalKey<FormState>();

  List muscleGroups = [
    "Chest",
    "Shoulders",
    "Back",
    "Core",
    "Biceps",
    "Triceps",
    "Legs"
  ];

  List<ExerciseInfo> exerciseList = [
    ExerciseInfo(name: "Select muscle group", muscleGroup: "")
  ];
  List exerciseListsData = [];

  int exerciseIndex = -1;

  int muscleIndex = -1;
  List<Map<String, dynamic>> sets = [
    {
      "weight": 0,
      "reps": 0,
    }
  ];

  void setEditDetails() {
    sets = widget.exercise!.sets;
    muscleIndex = muscleGroups.indexOf(widget.exercise!.muscleGroup);
    exerciseList = exerciseListsData[muscleIndex];
    for (int i = 0; i < exerciseList.length; i++) {
      if (exerciseList[i].name == widget.exercise!.name) {
        exerciseIndex = i;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    exerciseListsData.add(widget.exerciseLists["chest"] ?? []);
    exerciseListsData.add(widget.exerciseLists["shoulder"] ?? []);
    exerciseListsData.add(widget.exerciseLists["back"] ?? []);
    exerciseListsData.add(widget.exerciseLists["core"] ?? []);
    exerciseListsData.add(widget.exerciseLists["bicep"] ?? []);
    exerciseListsData.add(widget.exerciseLists["tricep"] ?? []);
    exerciseListsData.add(widget.exerciseLists["legs"] ?? []);

    if (widget.exercise != null) {
      setEditDetails();
      _mapEditExerciseToState(EditExercise());
    } else {
      _mapAddExerciseToState(AddExercise());
    }
  }

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
          "Add Exercise",
          style: TextStyle(
            fontSize: width * 0.06,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const RowText(text: "Target Muscle Group"),
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
                            HapticFeedback.heavyImpact();
                            setState(() {
                              muscleIndex = i;
                              exerciseIndex = -1;
                              exerciseList = exerciseListsData[i];
                            });
                          },
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.black38,
                      );
                    },
                  ),
                ),
                const RowText(
                  text: "Exercise",
                  topPadding: true,
                ),
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
                    itemCount: exerciseList.length,
                    itemBuilder: (context, i) {
                      final ExerciseInfo item = exerciseList[i];
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, height * 0.01, 0, height * 0.01),
                        child: ListTile(
                          title: Text(
                            item.name,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          trailing: muscleIndex != -1
                              ? Icon(
                                  exerciseIndex == i
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off_outlined,
                                  color: exerciseIndex == i
                                      ? Colors.blue
                                      : Theme.of(context).colorScheme.secondary,
                                )
                              : const SizedBox(),
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            setState(() {
                              exerciseIndex = i;
                            });
                          },
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.black38,
                      );
                    },
                  ),
                ),
                SizedBox(height: height * 0.01),
                ...sets.map(
                  (e) => setTile(height, width, sets.indexOf(e)),
                ),
                addButton(height, width),
                SizedBox(height: height * 0.01),
                SubmitButton(
                  onSubmit: () {
                    if (muscleIndex != -1 &&
                        exerciseIndex != -1 &&
                        allSetsHaveNonZeroReps(sets)) {
                      Exercise exercise = Exercise(
                        date: DateTime.now(),
                        name: exerciseList[exerciseIndex].name,
                        muscleGroup: muscleGroups[muscleIndex],
                        sets: sets,
                      );

                      Navigator.pop(context, exercise);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter valid data")));
                    }
                  },
                ),
                SizedBox(height: height * 0.05)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Divider divider(width) {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Colors.black38,
    );
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
            hintText: "Reps",
          ),
          SizedBox(height: height * 0.02),
          CustomField(
            initialValue: sets[index]["weight"].toString(),
            setValue: (value) => sets[index]["weight"] = value,
            hintText: "Weight",
            unit: "kgs",
          ),
        ],
      ),
    );
  }

  GestureDetector addButton(height, width) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.heavyImpact();
        setState(() {
          sets = sets +
              [
                {
                  "weight": 0,
                  "reps": 0,
                }
              ];
        });
      },
      child: Container(
        width: width * 0.85,
        height: height * 0.08,
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.075, vertical: height * 0.04),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor == Colors.black
              ? Colors.grey.shade900
              : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
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
          "Add exercise",
          style: TextStyle(
            fontSize: width * 0.06,
          ),
        ),
      ],
    );
  }

  bool allSetsHaveNonZeroReps(List<Map<String, dynamic>> sets) {
    for (var set in sets) {
      var reps = set['reps'];

      if (reps is String) {
        int? parsedReps = int.tryParse(reps);
        if (parsedReps == null || parsedReps == 0) {
          return false;
        }
      } else if (reps is int) {
        if (reps == 0) {
          return false;
        }
      } else {
        return false;
      }
    }
    return true;
  }
}

class EditExercise {}

class AddExercise {}

void _mapEditExerciseToState(EditExercise event) {}
void _mapAddExerciseToState(AddExercise event) {}

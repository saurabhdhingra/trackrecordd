import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackrecordd/database/exerciseDataStore.dart';
import 'package:trackrecordd/database/exerciseInfoDataStore.dart';
import 'package:trackrecordd/models/exercise.dart';
import 'package:trackrecordd/models/workout.dart';
import 'package:trackrecordd/models/workoutDetailed.dart';
import 'package:trackrecordd/views/addView.dart';
import 'package:trackrecordd/views/recordsView.dart';
import 'package:trackrecordd/views/settingsView.dart';

import '../database/workoutDataStore.dart';
import '../utils/constants.dart';
import '../utils/functions.dart';
import '../utils/uiUtils.dart';
import '../widgets/exerciseTile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late List<String> exercises = [];

  late WorkoutDetails data;
  late Workout workout;
  late List muscles = [];
  late List<Map> androidmuscles = [];
  late List<Map<String, dynamic>> titleData = [];
  bool isLoading = true;
  bool showUndo = false;
  int deletedIndex = 0;
  Exercise? deletedItem;
  String addName = "";
  String addMuscle = "";
  String selectedExercise = "";

  Future<List<Exercise>> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      WorkoutDataStore dataStore = WorkoutDataStore();
      Map<String, dynamic> result =
          await dataStore.getWorkoutDetails(date: DateTime.now());

      data = result["details"];
      workout = result["metaData"];
      setState(() {
        isLoading = false;
      });
      return data.exercises;
    } catch (e) {
      print("Some error occurred.");
      return [];
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
    intialExercisesArray();
  }

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF403F3C),
            ),
          )
        : Scaffold(
            floatingActionButton: floatingActionRow(context, width, height),
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shadowColor: const Color.fromRGBO(243, 242, 247, 1),
              elevation: 0,
              iconTheme: Theme.of(context).iconTheme,
            ),
            drawer: sideMenu(height, context),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: height / 65,
                  ),
                  homeViewHeading(height, width, context),
                  SizedBox(
                    height: height / 40,
                  ),
                  homeViewList(),
                ],
              ),
            ),
          );
  }

  Expanded homeViewList() {
    return Expanded(
      child: ListView.builder(
        itemCount: data.exercises.length,
        itemBuilder: (context, i) {
          final item = data.exercises[i];
          return Center(
            child: Dismissible(
              background:
                  Container(color: Colors.red, child: const Icon(Icons.delete)),
              key: Key(workout.exercises[i]),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) async {
                setState(() {
                  isLoading = true;
                });
                if (deletedItem != null) {
                  // await DatabaseHelper.instance
                  //     .deleteLog(deletedItem['indecs']);
                } else {}
                setState(() {
                  deletedItem = data.exercises.removeAt(i);
                  showUndo = true;
                  isLoading = false;
                });
              },
              child: ExerciseWidget(
                exercise: item,
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox homeViewHeading(height, width, BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          SizedBox(
            width: width * 0.07,
          ),
          SizedBox(
            width: width * 0.61,
            child: RichText(
              text: TextSpan(
                text: workout.muscleGroups.isNotEmpty
                    ? '${workout.muscleGroups[0]}\n'
                    : 'Add' '\n',
                style: TextStyle(
                  fontSize: height / 24,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: workout.muscleGroups.isNotEmpty
                        ? titleData.length > 1
                            // ignore: prefer_interpolation_to_compose_strings
                            ? 'and ' + workout.muscleGroups[1]
                            : ''
                        : 'exercises',
                    style: TextStyle(
                        fontSize: height / 24,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: width * 0.05,
          ),
          SizedBox(
            height: height * 0.1,
            child: const VerticalDivider(
              width: 2,
              thickness: 4,
            ),
          ),
          SizedBox(
            width: width * 0.06,
          ),
          Column(
            children: <Widget>[
              Text(
                months[month],
                style: TextStyle(
                    fontSize: height / 35,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey),
              ),
              Text(
                date.toString(),
                style: TextStyle(
                  fontSize: height / 19,
                  fontWeight: FontWeight.w900,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Drawer sideMenu(height, BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: height * 0.1),
          // DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: Color(0xFF77EEA3),
          //   ),
          //   child: ListTile(
          //     title:
          //         Text('Name', style: TextStyle(color: Colors.black)),
          //     subtitle: Text('Joined Nov 2021',
          //         style: TextStyle(color: Colors.grey.shade800)),
          //     leading: CircleAvatar(
          //         backgroundImage: AssetImage('images/user.jpg')),
          //   ),
          // ),
          ListTile(
            leading: const Icon(Icons.paste),
            title: const Text('Logs'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecordsView(),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.linear_scale),
          //   title: Text('Measurements'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => MeasurementScreen(),
          //       ),
          //     );
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsView(),
                ),
              );
            },
          ),
          const Divider(
            thickness: 3,
            indent: 10,
            endIndent: 10,
          ),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About app'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AboutPage(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }

  Row floatingActionRow(BuildContext context, double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        showUndo
            ? Padding(
                padding: EdgeInsets.only(left: width * 0.09),
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      data.exercises.insert(
                          deletedIndex - 1,
                          deletedItem ??
                              Exercise(
                                  date: DateTime.now(),
                                  name: "",
                                  muscleGroup: "",
                                  sets: []));
                      showUndo = false;
                      deletedItem = null;
                    });
                  },
                  backgroundColor: Colors.orange[400],
                  child: Icon(Icons.undo),
                  heroTag: "btn1",
                ),
              )
            : const SizedBox(),
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add),
            heroTag: "btn2",
            onPressed: () async {
              // setState(() {
              //   showUndo = false;
              // });
              // if (deletedItem.isNotEmpty) {
              //   await DatabaseHelper.instance.deleteLog(deletedItem['indecs']);
              // }
              // ignore: use_build_context_synchronously
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Platform.isIOS
                      ? cupertinoAddExec(height, width, context)
                      : androidAddExec(context, width);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  AlertDialog androidAddExec(BuildContext context, double width) {
    return AlertDialog(
      title: Text(addExecTitle),
      content: Text(addExecSubtitle),
      actions: [
        DropdownButton<String>(
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          value: addName,
          onChanged: (value) {
            // setState(() {
            //   addName = exercises[exercises.indexOf(value!)];
            //   addMuscle = muscles[exercises.indexOf(value)];
            // });
            // if (addName == '') {
            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     content: Text('Please select an exercise to add.'),
            //   ));
            // } else {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AddScreen(
            //       name: addName,
            //       muscle: addMuscle,
            //     ),
            //   ),
            // );
            // }
          },
          items: exercises
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
        TextButton(
          child: const Text('Create'),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => CreateExercise(
            //       isExercise: true,
            //     ),
            //   ),
            // );
          },
        )
      ],
    );
  }

  CupertinoAlertDialog cupertinoAddExec(
      double height, double width, BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(addExecTitle),
      content: Text(addExecSubtitle),
      actions: [
        CupertinoPicker(
          diameterRatio: 1,
          useMagnifier: true,
          magnification: 1.5,
          itemExtent: height * 0.035,
          onSelectedItemChanged: (value) {
            addName = exercises[value];
            addMuscle = muscles[value];
          },
          children: exercises
              .map(
                (e) => Center(
                  child: Text(
                    e.toString(),
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontSize: width * 0.03,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              )
              .toList(),
        ),
        CupertinoDialogAction(
          child: const Text('Add'),
          onPressed: () {
            // if (addName == '') {
            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     content: Text('Please select an exercise to add.'),
            //   ));
            // } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddView(
                    name: "Bench Press", //addName,
                    muscle: "Chest" //addMuscle,
                    ),
              ),
            );
            // }
          },
        ),
        CupertinoDialogAction(
          child: const Text('Create'),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => CreateExercise(isExercise: true),
            //   ),
            // );
          },
        )
      ],
    );
  }
}

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackrecordd/database/exerciseDataStore.dart';
import 'package:trackrecordd/database/exerciseInfoDataStore.dart';
import 'package:trackrecordd/models/exercise.dart';
import 'package:trackrecordd/models/workout.dart';
import 'package:trackrecordd/models/workoutDetailed.dart';
import 'package:trackrecordd/views/aboutView.dart';
import 'package:trackrecordd/views/addOrEditView.dart';
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
  late Map<String, List> exercises;

  late WorkoutDetails data;
  late Workout workout;

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

  Future<void> fetchexercisesList() async {
    try {
      ExerciseInfoDataStore store = ExerciseInfoDataStore();
      Map<String, List> request = await store.getSortedExercises();
      exercises = request;
    } catch (e) {
      print("Some error occurred while fetching list of exercises");
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
    fetchexercisesList();
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
                        ? workout.muscleGroups.length > 1
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
            onTap: () async {
              Navigator.pop(context);
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsView(
                    exercisesLists: exercises,
                  ),
                ),
              );
              if (result) {
                fetchexercisesList();
              }
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutView(),
                ),
              );
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
            heroTag: "btn2",
            onPressed: () async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddOrEditView(exerciseLists: exercises),
                ),
              );
              if (result != null && result is Exercise) {
                ExerciseDataStore store = ExerciseDataStore();
                await store.addExercise(exercise: result).then((value) {
                  workout.exercises.add(value);
                  data.exercises.add(result);
                  workout.muscleGroups.add(result.muscleGroup);
                  setState(() {});
                });
              }
              // setState(() {
              //   showUndo = false;
              // });
              // if (deletedItem.isNotEmpty) {
              //   await DatabaseHelper.instance.deleteLog(deletedItem['indecs']);
              // }
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

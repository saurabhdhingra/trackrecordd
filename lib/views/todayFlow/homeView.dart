import 'dart:io';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:trackrecordd/database/exerciseDataStore.dart';
import 'package:trackrecordd/database/exerciseInfoDataStore.dart';
import 'package:trackrecordd/models/exercise.dart';
import 'package:trackrecordd/models/workout.dart';
import 'package:trackrecordd/models/workoutDetailed.dart';
import 'package:trackrecordd/views/settingsViews/aboutAppFlow/aboutView.dart';
import 'package:trackrecordd/views/todayFlow/addOrEditView.dart';
import 'package:trackrecordd/views/graphView.dart';
import 'package:trackrecordd/views/recordsView.dart';
import 'package:trackrecordd/views/settingsViews/settingsView.dart';
import 'package:trackrecordd/widgets/showcaseView.dart';

import '../../database/workoutDataStore.dart';
import '../../models/userInfo.dart';
import '../../utils/constants.dart';
import '../../utils/functions.dart';
import '../../widgets/exerciseTile.dart';
import '../authViews/signInFlow/login.dart';

class HomeView extends StatefulWidget {
  final UserInformation userInformation;
  final double action;
  const HomeView({
    super.key,
    required this.userInformation,
    required this.action,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Map<String, List> exercises;

  late WorkoutDetails data;
  late Workout workout;

  final GlobalKey addFAB = GlobalKey();
  final GlobalKey undoFAB = GlobalKey();
  final GlobalKey exeTile = GlobalKey();
  final GlobalKey menuDrw = GlobalKey();

  bool isLoading = true;
  bool showUndo = false;

  int deletedIndex = 0;
  Exercise? deletedItem;

  String addName = "";
  String addMuscle = "";
  String selectedExercise = "";

  String? firstName;
  DateTime? dateJoined;

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

  Future<void> deleteExercise(bool isDeleteAction) async {
    if (deletedItem != null) {
      ExerciseDataStore store = ExerciseDataStore();
      String muscleGroup = deletedItem!.muscleGroup;
      await store
          .deleteExercise(
        id: workout.exercises[deletedIndex],
        index: deletedIndex,
        muscleGroup: deletedItem!.muscleGroup,
      )
          .then((value) {
        if (value) {
          workout.muscleGroups
              .removeAt(workout.muscleGroups.indexOf(muscleGroup));
          WorkoutDataStore workoutDataStore = WorkoutDataStore();
          workoutDataStore.updateWorkout(
              workout: workout, id: workoutId(DateTime.now()));
        }
      });
    }

    if (!isDeleteAction) {
      setState(() {
        showUndo = false;
        deletedIndex = -1;
        deletedItem = null;
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (widget.action == 0) {
          ShowCaseWidget.of(context).startShowCase([addFAB]);
        } else if (widget.action == 6) {
          ShowCaseWidget.of(context).startShowCase([exeTile, menuDrw]);
        }
      },
    );
    fetchData();
    fetchexercisesList();
    firstName = widget.userInformation.firstName;
    dateJoined = widget.userInformation.dateJoined;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);

    final ShowcaseActionProvider actionProvider =
        Provider.of<ShowcaseActionProvider>(context);
    final double action = actionProvider.currAction;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
          )
        : Scaffold(
            floatingActionButton: floatingActionRow(
                context, width, height, action, actionProvider),
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shadowColor: const Color.fromRGBO(243, 242, 247, 1),
              elevation: 0,
              iconTheme: Theme.of(context).iconTheme,
              leading: ShowCaseView(
                globalKey: menuDrw,
                description:
                    "Open menu for settings, adding new exercises, privacy policy, theme settings and knowing more the app.",
                enabled: action == 5,
                child: const Icon(Icons.menu),
              ),
            ),
            drawer: sideMenu(height, width, context),
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
                  homeViewList(action),
                ],
              ),
            ),
          );
  }

  Expanded homeViewList(double action) {
    return Expanded(
      child: ListView.builder(
        itemCount: data.exercises.length,
        itemBuilder: (context, i) {
          final item = data.exercises[i];
          return Center(
            child: Dismissible(
              background:
                  Container(color: Colors.red, child: const Icon(Icons.delete)),
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) async {
                deletedItem = data.exercises.removeAt(i);
                setState(() {});
                await deleteExercise(true);

                setState(() {
                  deletedIndex = i;
                  showUndo = true;
                });
              },
              child: GestureDetector(
                onTap: () async {
                  ExerciseDataStore dataStore = ExerciseDataStore();
                  Map<String, dynamic> result =
                      await dataStore.getBarChartData(item.name);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BarGraphView(
                          exerciseName: item.name,
                          data: result["data"],
                          //  result["data"],
                          maxValue: result["max"],
                        );
                      },
                    ),
                  );
                },
                onDoubleTap: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddOrEditView(
                          exerciseLists: exercises,
                          exercise: item,
                          action: 10,
                        );
                      },
                    ),
                  );

                  if (result != null && result is Exercise) {
                    ExerciseDataStore store = ExerciseDataStore();
                    await store
                        .updateExercise(
                            exercise: result, id: workout.exercises[i])
                        .then((value) {
                      data.exercises[i] = result;
                      if (!workout.muscleGroups.contains(result.muscleGroup)) {
                        workout.muscleGroups.add(result.muscleGroup);
                      }

                      setState(() {});
                    });
                  }
                },
                child: ShowCaseView(
                  globalKey: exeTile,
                  enabled: i == 0 && action == 5,
                  description:
                      'Double tap to edit.\nLong press for statistics.\nSwipe left to delete.',
                  child: ExerciseWidget(
                    exercise: item,
                  ),
                ),
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
                      color: Colors.grey,
                    ),
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

  Drawer sideMenu(height, width, BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: height * 0.1),
          ListTile(
            title: Text(firstName ?? 'Loading...',
                style: TextStyle(fontSize: width * 0.06)),
            subtitle: Text(
              dateJoined != null
                  ? 'Joined ${DateFormat.yMMMd().format(dateJoined!)}'
                  : 'Loading...',
              style: TextStyle(
                  color: Colors.grey.shade800, fontSize: width * 0.045),
            ),
          ),
          const Divider(thickness: 1),
          ListTile(
            leading: const Icon(Icons.paste),
            title: const Text('Logs'),
            onTap: () {
              Navigator.pop(context);
              deleteExercise(false);
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
              deleteExercise(false);
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsView(
                    exercisesLists: exercises,
                  ),
                ),
              );
              if (result ?? false) {
                fetchexercisesList();
              }
            },
          ),
          const Divider(thickness: 1),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About app'),
            onTap: () {
              Navigator.pop(context);
              deleteExercise(false);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutView(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              auth.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginView(
                    isLogout: true,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Row floatingActionRow(BuildContext context, double width, double height,
      double action, ShowcaseActionProvider provider) {
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
                          deletedIndex,
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
                  heroTag: "btn1",
                  child: const Icon(Icons.undo),
                ),
              )
            : const SizedBox(),
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: ShowCaseView(
            enabled: action == 0,
            globalKey: addFAB,
            description: "Click here to add your first exercise",
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              heroTag: "btn2",
              onPressed: () async {
                var result;
                if (action == 0) {
                  provider.setNewAction(1);
                  setState(() {
                    action = 1;
                  });
                  result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return ShowCaseWidget(
                          builder: (context) => AddOrEditView(
                            exerciseLists: exercises,
                            action: 1,
                          ),
                        );
                      },
                    ),
                  );
                  if (result != null && result is Exercise) {
                    ShowCaseWidget.of(context)
                        .startShowCase([exeTile, menuDrw]);
                    provider.setNewAction(6);
                    setState(() {
                      action = 6;
                    });
                  }
                } else {
                  result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return ShowCaseWidget(
                          builder: (context) => AddOrEditView(
                            exerciseLists: exercises,
                            action: 1,
                          ),
                        );
                      },
                    ),
                  );
                }

                if (result != null && result is Exercise) {
                  ExerciseDataStore store = ExerciseDataStore();
                  await store.addExercise(exercise: result).then((value) {
                    workout.exercises.add(value);
                    data.exercises.add(result);
                    workout.muscleGroups.add(result.muscleGroup);
                    // TODO : add muscleList func
                    setState(() {});
                  });
                }
                setState(() {
                  showUndo = false;
                });
                deleteExercise(false);
              },
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}

String workoutId(DateTime date) {
  print('${date.day}-${date.month}-${date.year}');
  return '${date.day}-${date.month}-${date.year}';
}

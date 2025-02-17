import 'package:flutter/material.dart';
import 'package:trackrecordd/database/exerciseInfoDataStore.dart';
// import 'package:trackrecord/database/db.dart';
import 'package:trackrecordd/utils/constants.dart';

import '../../../models/exerciseInfo.dart';
import 'createExerciseView.dart';

class AllExercisesInfoView extends StatefulWidget {
  final Map<String, List> exercisesLists;
  const AllExercisesInfoView({Key? key, required this.exercisesLists})
      : super(key: key);

  @override
  State<AllExercisesInfoView> createState() => _AllExercisesInfoViewState();
}

class _AllExercisesInfoViewState extends State<AllExercisesInfoView> {
  bool isEdit = false;

  bool isDeleting = false;
  ExerciseInfo? deletedItem;
  int deletedIndex = -1;
  List? deletedList;
  bool showUndo = false;

  Future<void> deleteExercise(bool isDeleteAction) async {
    if (deletedItem != null && deletedIndex != -1) {
      ExerciseInfoDataStore store = ExerciseInfoDataStore();
      setState(() => isDeleting = true);
      await store.deleteExercise(id: deletedItem!.id ?? "");
      setState(() => isDeleting = false);
    }

    if (!isDeleteAction) {
      setState(() {
        showUndo = false;
        deletedIndex = -1;
        deletedItem = null;
        deletedList = null;
      });
    }
  }

  Future<void> addExercise(ExerciseInfo exerciseInfo) async {
    deleteExercise(false);
    ExerciseInfoDataStore store = ExerciseInfoDataStore();
    await store.addExercise(exercise: exerciseInfo).then((value) {
      exerciseInfo.id = value;
      widget.exercisesLists[tagMap[exerciseInfo.muscleGroup]]!
          .add(exerciseInfo);
      setState(() {});
    });
  }

  Map<String, String> tagMap = {
    "Chest": "chest",
    "Back": "back",
    "Shoulders": "shoulder",
    "Biceps": "bicep",
    "Triceps": "tricep",
    "Legs": "legs",
    "Core": "core",
  };

  Map<String, bool> expMap = {
    "Chest": false,
    "Back": false,
    "Shoulders": false,
    "Biceps": false,
    "Triceps": false,
    "Legs": false,
    "Core": false,
  };

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);

    return Scaffold(
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            showUndo
                ? FloatingActionButton(
                    backgroundColor: Colors.orange[400],
                    child: const Icon(Icons.undo),
                    onPressed: () {
                      setState(() {
                        deletedList!.insert(
                            deletedIndex,
                            deletedItem ??
                                ExerciseInfo(
                                  id: "",
                                  name: "",
                                  muscleGroup: "",
                                ));
                        showUndo = false;
                        deletedItem = null;
                        deletedIndex = -1;
                      });
                    },
                  )
                : const SizedBox(),
            SizedBox(
              width: width * 0.63,
            ),
            FloatingActionButton(
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add),
              onPressed: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateExercise(
                      isExercise: false,
                    ),
                  ),
                );
                if (result != null && result is ExerciseInfo) {
                  addExercise(result);
                }
              },
            )
          ]),
      appBar: AppBar(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width * 0.08),
          onPressed: () {
            deleteExercise(false);
            Navigator.pop(context, isEdit);
          },
        ),
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
        automaticallyImplyLeading: true,

        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: width * 0.08, vertical: 0.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...listTitle(height, 'Chest', width, context, controller,
                    widget.exercisesLists["chest"] ?? []),
                SizedBox(height: height * 0.02),
                ...listTitle(height, 'Back', width, context, controller,
                    widget.exercisesLists["back"] ?? []),
                SizedBox(height: height * 0.02),
                ...listTitle(height, 'Shoulders', width, context, controller,
                    widget.exercisesLists["shoulder"] ?? []),
                SizedBox(height: height * 0.02),
                ...listTitle(height, 'Biceps', width, context, controller,
                    widget.exercisesLists["bicep"] ?? []),
                SizedBox(height: height * 0.02),
                ...listTitle(height, 'Triceps', width, context, controller,
                    widget.exercisesLists["tricep"] ?? []),
                SizedBox(height: height * 0.02),
                ...listTitle(height, 'Legs', width, context, controller,
                    widget.exercisesLists["legs"] ?? []),
                SizedBox(height: height * 0.02),
                ...listTitle(height, 'Core', width, context, controller,
                    widget.exercisesLists["core"] ?? []),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List listTitle(height, String text, width, BuildContext context,
      ScrollController controller, List list) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: TextStyle(
                  fontSize: height * 0.04, fontWeight: FontWeight.bold)),
          IconButton(
              onPressed: () {
                setState(() {
                  expMap[text] = !expMap[text]!;
                });
              },
              icon: Icon(expMap[text]!
                  ? Icons.keyboard_arrow_up_outlined
                  : Icons.keyboard_arrow_down_outlined))
        ],
      ),
      Container(
        width: width * 0.9,
        height: null,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(height / 50)),
        ),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: false,
          itemCount: expMap[text]! ? list.length : 0,
          itemBuilder: (context, i) {
            final ExerciseInfo item = list[i];
            return Dismissible(
              key: Key("${item.name} ${item.muscleGroup}"),
              background: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topLeft:
                            i == 0 ? Radius.circular(height / 50) : Radius.zero,
                        topRight:
                            i == 0 ? Radius.circular(height / 50) : Radius.zero,
                        bottomLeft: i == list.length - 1
                            ? Radius.circular(height / 50)
                            : Radius.zero,
                        bottomRight: i == list.length - 1
                            ? Radius.circular(height / 50)
                            : Radius.zero),
                  ),
                  child: const Icon(Icons.delete)),
              direction: DismissDirection.endToStart,
              child: Padding(
                padding:
                    EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.01),
                child: ListTile(
                  title: Text(
                    item.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onTap: () {
                    // setState(() {
                    //   exerciseIndex = i;
                    // });
                  },
                ),
              ),
              onDismissed: (direction) async {
                if (isDeleting) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text("Another request in process. Please wait")));
                } else {
                  await deleteExercise(true);

                  setState(() {
                    deletedItem = list.removeAt(i);
                    deletedIndex = i;
                    deletedList = list;
                    showUndo = true;
                  });
                }
              },
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
    ];
  }
}

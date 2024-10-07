import 'package:flutter/material.dart';
import 'package:trackrecordd/database/exerciseInfoDataStore.dart';
// import 'package:trackrecord/database/db.dart';
import 'package:trackrecordd/utils/constants.dart';

import '../../../models/exerciseInfo.dart';
import 'createExerciseView.dart';

class EditExercisesView extends StatefulWidget {
  final Map<String, List> exercisesLists;
  const EditExercisesView({Key? key, required this.exercisesLists})
      : super(key: key);

  @override
  State<EditExercisesView> createState() => _EditExercisesViewState();
}

class _EditExercisesViewState extends State<EditExercisesView> {
  bool isEdit = false;

  Map<String, String> tagMap = {
    "Chest": "chest",
    "Back": "back",
    "Shoulders": "shoulder",
    "Biceps": "bicep",
    "Triceps": "tricep",
    "Legs": "legs",
    "Core": "core",
  };
  @override
  Widget build(BuildContext context) {
    ScrollController _controller = new ScrollController();
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);

    return Scaffold(
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // showUndo
            //     ? FloatingActionButton(
            //         backgroundColor: Colors.orange[400],
            //         child: const Icon(Icons.undo),
            //         onPressed: () {},
            //       )
            //     : const SizedBox(),
            // SizedBox(
            //   width: width * 0.63,
            // ),
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
                  ExerciseInfoDataStore store = ExerciseInfoDataStore();
                  await store.addExercise(exercise: result).then((value) {
                    if (value) {
                      widget.exercisesLists[tagMap[result.muscleGroup]]!
                          .add(result);
                      setState(() {});
                    }
                  });
                }
              },
            )
          ]),
      appBar: AppBar(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width * 0.08),
          onPressed: () {
            Navigator.pop(context, isEdit);
          },
        ),
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
        automaticallyImplyLeading: true,
        actions: [],
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
                listTitle(height, 'Chest'),
                listWidget(width, height, context, _controller,
                    widget.exercisesLists["chest"] ?? []),
                SizedBox(height: height * 0.02),
                listTitle(height, 'Back'),
                listWidget(width, height, context, _controller,
                    widget.exercisesLists["back"] ?? []),
                SizedBox(height: height * 0.02),
                listTitle(height, 'Shoulders'),
                listWidget(width, height, context, _controller,
                    widget.exercisesLists["shoulder"] ?? []),
                SizedBox(height: height * 0.02),
                listTitle(height, 'Biceps'),
                listWidget(width, height, context, _controller,
                    widget.exercisesLists["bicep"] ?? []),
                SizedBox(height: height * 0.02),
                listTitle(height, 'Triceps'),
                listWidget(width, height, context, _controller,
                    widget.exercisesLists["tricep"] ?? []),
                SizedBox(height: height * 0.02),
                listTitle(height, 'Legs'),
                listWidget(width, height, context, _controller,
                    widget.exercisesLists["legs"] ?? []),
                SizedBox(height: height * 0.02),
                listTitle(height, 'Core'),
                listWidget(width, height, context, _controller,
                    widget.exercisesLists["core"] ?? []),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text listTitle(height, String text) {
    return Text(text,
        style: TextStyle(fontSize: height * 0.04, fontWeight: FontWeight.bold));
  }

  Container listWidget(width, height, BuildContext context,
      ScrollController controller, List list) {
    return Container(
      width: width * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(height / 50)),
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        itemCount: list.length,
        itemBuilder: (context, i) {
          final ExerciseInfo item = list[i];
          return Padding(
            padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.01),
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
    );
  }
}

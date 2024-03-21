import 'package:flutter/material.dart';
// import 'package:trackrecord/database/db.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:trackrecordd/utils/functions.dart';
import 'package:provider/provider.dart';

import 'createExerciseView.dart';

class EditExercisesView extends StatefulWidget {
  const EditExercisesView({Key? key}) : super(key: key);

  @override
  State<EditExercisesView> createState() => _EditExercisesViewState();
}

class _EditExercisesViewState extends State<EditExercisesView> {
  late List exercisesCore = [];
  late List exercisesChest = [];
  late List exercisesBack = [];
  late List exercisesLegs = [];
  late List exercisesShoulders = [];
  late List exercisesBiceps = [];
  late List exercisesTriceps = [];

  bool isLoading = false;
  bool showUndo = false;

  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  // Future getData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   List<Map<String, dynamic>> exercises =
  //       await DatabaseHelper.instance.queryExercises();
  //   List<String> chest = [];
  //   List<String> back = [];
  //   List<String> shoulders = [];
  //   List<String> legs = [];
  //   List<String> core = [];
  //   List<String> biceps = [];
  //   List<String> triceps = [];

  //   for (int i = 0; i < exercises.length; i++) {
  //     if (exercises[i]['muscle'] == 'Chest') {
  //       chest.add(exercises[i]['name']);
  //     }
  //     if (exercises[i]['muscle'] == 'Back') {
  //       back.add(exercises[i]['name']);
  //     }
  //     if (exercises[i]['muscle'] == 'Shoulders') {
  //       shoulders.add(exercises[i]['name']);
  //     }
  //     if (exercises[i]['muscle'] == 'Core') {
  //       core.add(exercises[i]['name']);
  //     }
  //     if (exercises[i]['muscle'] == 'Triceps') {
  //       triceps.add(exercises[i]['name']);
  //     }
  //     if (exercises[i]['muscle'] == 'Biceps') {
  //       biceps.add(exercises[i]['name']);
  //     }
  //     if (exercises[i]['muscle'] == 'Legs') {
  //       legs.add(exercises[i]['name']);
  //     }
  //   }
  //   exercisesChest = chest;
  //   exercisesBack = back;
  //   exercisesLegs = legs;
  //   exercisesTriceps = triceps;
  //   exercisesBiceps = biceps;
  //   exercisesShoulders = shoulders;
  //   exercisesCore = core;

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

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
            showUndo
                ? FloatingActionButton(
                    backgroundColor: Colors.orange[400],
                    child: Icon(Icons.undo),
                    onPressed: () {},
                  )
                : SizedBox(width: 0, height: 0),
            SizedBox(
              width: width * 0.63,
            ),
            FloatingActionButton(
              backgroundColor: Colors.blue,
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateExercise(
                      isExercise: false,
                    ),
                  ),
                );
              },
            )
          ]),
      appBar: AppBar(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                listWidget(width, height, context, _controller, exercisesChest),
                SizedBox(height: height * 0.02),
                listTitle(height, 'Back'),
                listWidget(width, height, context, _controller, exercisesBack),
                SizedBox(height: height * 0.02),
                listTitle(height, 'Shoulders'),
                listWidget(
                    width, height, context, _controller, exercisesShoulders),
                SizedBox(height: height * 0.02),
                listTitle(height, 'Biceps'),
                listWidget(
                    width, height, context, _controller, exercisesBiceps),
                SizedBox(height: height * 0.02),
                listTitle(height, 'Triceps'),
                listWidget(
                    width, height, context, _controller, exercisesTriceps),
                SizedBox(height: height * 0.02),
                listTitle(height, 'Legs'),
                listWidget(width, height, context, _controller, exercisesLegs),
                SizedBox(height: height * 0.02),
                listTitle(height, 'Core'),
                listWidget(width, height, context, _controller, exercisesCore),
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
      height: height * 0.078 * list.length,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(height / 50)),
      ),
      child: ListView.separated(
        controller: controller,
        itemCount: list.length,
        itemBuilder: (context, i) {
          final item = list[i];
          return SizedBox(
            height: height * 0.06,
            child: ListTile(
              title: Text(item),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            thickness: 1,
            indent: width * 0.03,
            endIndent: width * 0.03,
          );
        },
      ),
    );
  }
}

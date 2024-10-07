import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trackrecordd/database/workoutDataStore.dart';
import 'package:trackrecordd/models/workout.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:trackrecordd/widgets/dayTile.dart';

class RecordsView extends StatefulWidget {
  const RecordsView({Key? key}) : super(key: key);

  @override
  State<RecordsView> createState() => _RecordsViewState();
}

class _RecordsViewState extends State<RecordsView> {
  late List<Workout> data = [];
  bool isLoading = false;
  bool isLimitReached = false;
  DocumentSnapshot? lastDoc;

  Future<void> fetchWorkoutsList(DocumentSnapshot? lastDoc) async {
    setState(() {
      isLoading = true;
    });
    try {
      WorkoutDataStore store = WorkoutDataStore();
      Map request = await store.getWorkoutList(startAfterDoc: lastDoc);
      data = request["list"];
      isLimitReached = request["limit"];
      lastDoc = request["lastDoc"];
      print(data.length);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("Some error occurred while fetching list of workouts")));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWorkoutsList(null);
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
            appBar: AppBar(
              iconTheme: Theme.of(context).iconTheme,
              leading: IconButton(
                icon: Icon(Icons.chevron_left, size: width * 0.07),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shadowColor: const Color(0xFFFFFFFF),
              elevation: 0,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    data.isEmpty
                        ? SizedBox(
                            height: height * 0.9,
                            child: Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: 'Nothing to show,',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "\nrecord your",
                                        style:
                                            const TextStyle(color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap =
                                              () => Navigator.of(context).pop(),
                                      ),
                                      const TextSpan(text: "\nfirst workout")
                                    ]),
                              ),
                            ),
                          )
                        : ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, i) {
                              Workout item = data[i];
                              return DayTile(
                                number: item.exercises.length,
                                day: item.date,
                                muscle1: item.muscleGroups[0],
                                muscle2: item.muscleGroups.length > 1
                                    ? item.muscleGroups[1]
                                    : "",
                              );
                            },
                          ),
                    isLimitReached
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () {
                              fetchWorkoutsList(lastDoc);
                            },
                            child: SizedBox(
                              height: height * 0.1,
                              child: const Center(
                                child: Text(
                                  "LOAD MORE",
                                  style: TextStyle(
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
          );
  }
}

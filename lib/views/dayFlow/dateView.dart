import 'package:flutter/material.dart';

import 'package:trackrecordd/models/exercise.dart';
import 'package:trackrecordd/models/workout.dart';
import 'package:trackrecordd/models/workoutDetailed.dart';

import '../../database/workoutDataStore.dart';
import '../../utils/constants.dart';
import '../../utils/functions.dart';

import '../../widgets/exerciseTile.dart';

class DateView extends StatefulWidget {
  final DateTime date;
  const DateView({super.key, required this.date});

  @override
  State<DateView> createState() => _DateViewState();
}

class _DateViewState extends State<DateView> {
  bool isLoading = true;

  late WorkoutDetails data;
  late Workout metaData;

  Future<List<Exercise>> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      WorkoutDataStore dataStore = WorkoutDataStore();
      Map<String, dynamic> result =
          await dataStore.getWorkoutDetails(date: widget.date);

      data = result["details"];
      metaData = result["metaData"];

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
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shadowColor: const Color.fromRGBO(243, 242, 247, 1),
              elevation: 0,
              iconTheme: Theme.of(context).iconTheme,
            ),
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
            child: ExerciseWidget(
              exercise: item,
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
                text: '${metaData.muscleGroups[0]}\n',
                style: TextStyle(
                  fontSize: height / 24,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: metaData.muscleGroups.isNotEmpty
                        ? metaData.muscleGroups.length > 1
                            ? 'and ${data.muscleGroups[1]}'
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
}

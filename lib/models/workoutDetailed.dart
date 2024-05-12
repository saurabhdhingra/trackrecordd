import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackrecordd/models/exercise.dart';

class WorkoutDetails {
  DateTime date;
  List<String> muscleGroups;
  List<Exercise> exercises;

  WorkoutDetails({
    required this.date,
    required this.muscleGroups,
    required this.exercises,
  });

  factory WorkoutDetails.fromJson(Map<String, dynamic> json) => WorkoutDetails(
        date: json["date"].toDate(),
        muscleGroups: json["muscleGroups"],
        exercises: json["exercises"],
      );

  Map<String, dynamic> toFirestore() => {
        "date": date,
        "muscleGroups": muscleGroups,
        "exercises": exercises,
      };

  factory WorkoutDetails.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return WorkoutDetails(
      date: data?["date"],
      muscleGroups: data?["muscleGroups"],
      exercises: data?["exercises"],
    );
  }
}

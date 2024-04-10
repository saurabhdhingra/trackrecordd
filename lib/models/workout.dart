import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackrecordd/models/exercise.dart';

class Workout {
  DateTime date;
  List<String> muscleGroups;
  List<String> exercises;

  Workout({
    required this.date,
    required this.muscleGroups,
    required this.exercises,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        date: json["date"],
        muscleGroups: json["muscleGroups"],
        exercises: json["exercises"],
      );

  Map<String, dynamic> toFirestore() => {
        "date": date,
        "muscleGroups": muscleGroups,
        "exercises": exercises,
      };

  factory Workout.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Workout(
      date: data?["date"],
      muscleGroups: data?["muscleGroups"],
      exercises: data?["exercises"],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  DateTime date;
  String muscleGroup;
  List<Map<String, dynamic>> sets;

  Exercise({
    required this.date,
    required this.muscleGroup,
    required this.sets,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        date: json["date"],
        muscleGroup: json["muscleGroup"],
        sets: json["sets"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "muscleGroup": muscleGroup,
        "sets": sets,
      };

  factory Exercise.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Exercise(
      date: data?["date"],
      muscleGroup: data?["muscleGroup"],
      sets: data?["sets"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "date": date,
      "muscleGroup": muscleGroup,
      "sets": sets,
    };
  }
}

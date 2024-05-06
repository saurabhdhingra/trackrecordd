import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseInfo {
  String muscleGroup;
  String name;

  ExerciseInfo({
    required this.name,
    required this.muscleGroup,
  });

  factory ExerciseInfo.fromJson(Map<String, dynamic> json) => ExerciseInfo(
        name: json["name"],
        muscleGroup: json["muscleGroup"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "muscleGroup": muscleGroup,
      };

  factory ExerciseInfo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ExerciseInfo(
      name: data?["name"],
      muscleGroup: data?["muscleGroup"],
    );
  }
}

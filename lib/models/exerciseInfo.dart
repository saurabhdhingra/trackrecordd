import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseInfo {
  String muscleGroup;
  String name;
  String? id;

  ExerciseInfo({
    required this.name,
    required this.muscleGroup,
    required this.id,
  });

  factory ExerciseInfo.fromJson(Map<String, dynamic> json, String id) =>
      ExerciseInfo(
        name: json["name"],
        muscleGroup: json["muscleGroup"],
        id: id,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "muscleGroup": muscleGroup,
        "id": id,
      };

  factory ExerciseInfo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ExerciseInfo(
      id: snapshot.id,
      name: data?["name"],
      muscleGroup: data?["muscleGroup"],
    );
  }
}

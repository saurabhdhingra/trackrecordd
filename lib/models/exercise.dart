import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  DateTime date;
  String muscleGroup;
  String name;
  List<Map<String, dynamic>> sets;

  Exercise({
    required this.date,
    required this.name,
    required this.muscleGroup,
    required this.sets,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    var array = json["sets"];
    List<Map<String, dynamic>> sets = List<Map<String, dynamic>>.from(array);
    return Exercise(
      date: json["date"].toDate(),
      name: json["name"],
      muscleGroup: json["muscleGroup"],
      sets: sets,
    );
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "name": name,
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
      name: data?["name"],
      muscleGroup: data?["muscleGroup"],
      sets: data?["sets"],
    );
  }
}

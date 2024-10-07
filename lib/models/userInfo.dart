import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserInformation {
  String firstName;
  String lastName;
  DateTime dateOfBirth;
  DateTime dateJoined;
  Map? measurements;

  UserInformation({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.dateJoined,
    this.measurements,
  });

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      UserInformation(
          firstName: json["firstName"],
          lastName: json["lastName"],
          dateOfBirth: json["dateOfBirth"].toDate(),
          dateJoined: json["dateJoined"].toDate(),
          measurements: json["measurements"]);

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "dateOfBirth": dateOfBirth,
        "dateJoined": dateJoined,
        "measurements": measurements
      };

  factory UserInformation.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserInformation(
        firstName: data?["firstName"],
        lastName: data?["lastName"],
        dateOfBirth: data?["dateOfBirth"].toDate(),
        dateJoined: data?["dateJoined"].toDate(),
        measurements: data?["measurements"]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "dateOfBirth": dateOfBirth,
      "dateJoined": dateJoined,
      "measurements": measurements
    };
  }
}

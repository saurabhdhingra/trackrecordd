import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String firstName;
  String lastName;
  DateTime? dateOfBirth;
  DateTime? dateJoined;
  Map? measurements;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
    this.dateJoined,
    this.measurements,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        dateOfBirth: json["dateOfBirth"],
        dateJoined: json["dateJoined"],
      );

  Map<String, dynamic> toJson() => {
        "userId": id,
        "firstName": firstName,
        "lastName": lastName,
        "dateOfBirth": dateOfBirth,
        "dateJoined": dateJoined,
      };

  // factory User.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return User(
  //     name: data?['name'],
  //     state: data?['state'],
  //     country: data?['country'],
  //     capital: data?['capital'],
  //     population: data?['population'],
  //     regions:
  //         data?['regions'] is Iterable ? List.from(data?['regions']) : null,
  //   );
  // }

  // Map<String, dynamic> toFirestore() {
  //   return {
  //     if (name != null) "name": name,
  //     if (state != null) "state": state,
  //     if (country != null) "country": country,
  //     if (capital != null) "capital": capital,
  //     if (population != null) "population": population,
  //     if (regions != null) "regions": regions,
  //   };
  // }
}

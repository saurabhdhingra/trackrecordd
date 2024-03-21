class User {
  String id;
  String firstName;
  String lastName;
  String dateOfBirth;
  String dateJoined;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.dateJoined,
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
        "dateJoined" : dateJoined,
      };
}

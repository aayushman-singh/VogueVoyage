import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String name;
  final int age;
  final String gender;
  final String bodyTypeOption;
  final String skinColorOption;

  const User({
    required this.uid,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.bodyTypeOption,
    required this.skinColorOption,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      name: snapshot["name"] ?? 'Anon',
      uid: snapshot["uid"] ?? '1111111111111',
      email: snapshot["email"] ?? 'travxaianon@gmail.com',
      age: snapshot["age"] ?? 0,
      gender: snapshot["gender"] ?? 'other',
      bodyTypeOption: snapshot["bodyTypeOption"] ?? 'mesomorph',
      skinColorOption: snapshot["skinColorOption"] ?? 'neutral',
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "email": email,
        "age": age,
        "gender": gender,
        "bodyTypeOption": bodyTypeOption,
        "skinColorOption": skinColorOption,
      };
}

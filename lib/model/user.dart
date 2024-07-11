import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String username;
  final String phone;
  final String gender;
  final String age;
  final String uid;

  // ignore: use_key_in_constructor
  const User({
    required this.uid,
    required this.email,
    required this.username,
    required this.phone,
    required this.gender,
    required this.age,
  });
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'username': username,
        'phone': phone,
        'gender': gender,
        'age': age,
      };

  static Future<User> fromSnap(DocumentSnapshot snapshot) async {
    var data = snapshot.data() as Map<String, dynamic>;
    return Future.value(User(
      uid: data['uid'],
      email: data['email'],
      username: data['username'],
      phone: data['phone'],
      gender: data['gender'],
      age: data['age'],
    ));
  }
}

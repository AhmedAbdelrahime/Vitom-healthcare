import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/homepage/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/model/user.dart' as model;

// Firebase Authentication Service

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // Sign in with email and password

  Future<String> singupUser({
    required String email,
    required String password,
    required String username,
    required String phone,
    required String gender,
    required String age,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          phone.isNotEmpty ||
          gender.isNotEmpty) {
        // Create user

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // Add user to model class

        model.User user = model.User(
          uid: cred.user!.uid,
          username: username,
          email: email,
          phone: phone,
          gender: gender,
          age: age,
        );

        // Add user to firestore
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = 'success';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        res = 'Email already in use';
      } else if (e.code == 'weak-password') {
        res = 'Password is too weak';
      } else if (e.code == 'invalid-email') {
        res = 'Invalid email';
      } else {
        res = e.message!;
      }
    }
    return res;
  }

// Login with email and password
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        res = 'User not found';
      } else if (err.code == 'wrong-password') {
        res = 'Wrong password';
      } else {
        res = err.message!;
      }
    }
    // catch (err) {
    //   res = err.toString();
    // }
    return res;
  }

  Future<String> updateUserProfile({
    required String username,
    required String age,
  }) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        // Update user data in Firestore
        await _firestore.collection('users').doc(currentUser.uid).update({
          'username': username,
          'age': age,
        });
        return 'Profile updated successfully';
      } else {
        return 'User not logged in';
      }
    } catch (e) {
      return 'Error updating profile: $e';
    }
  }

  Future<void> _loginAnonymously() async {
    try {
      // Log in anonymously
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      // If login is successful, navigate to HomeBody
      if (userCredential.user != null) {
        // Set username to "Guest" and age to undefined
        await _updateUserData(userCredential.user!.uid);
        // Navigate to HomeBody
        Get.off(RiveAppHome());
      }
    } catch (e) {
      print("Failed to sign in anonymously: $e");
      // Handle error
    }
  }

  Future<void> _updateUserData(String uid) async {
    // Update user data with username as "Guest" and age as undefined
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'username': 'Guest',
      'age': FieldValue.delete(), // Delete age field
    });
  }
}

// Show snackbar message
showSnakBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

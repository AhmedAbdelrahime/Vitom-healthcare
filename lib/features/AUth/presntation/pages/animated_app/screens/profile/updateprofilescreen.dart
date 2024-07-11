import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/core/Widgets/itemedit.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';
import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/on_boardibg/on_boarding_screen.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/profile/profile_body.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phonedController = TextEditingController();

  // import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication package

// Inside your _UpdateProfileScreenState class

  void updateUserProfile(
      String newName, String newEmail, String newPhoneNumber) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Update user profile data in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'name': newName,
          'email': newEmail,
          'phone': newPhoneNumber,
        });

        // Update user profile data in Firebase Authentication (optional)
        await user.updateDisplayName(newName);
        await user.updateEmail(newEmail);

        // If needed, you can also update other user profile data using additional methods provided by FirebaseAuth

        // Show a success message or perform any other actions
        print('User profile updated successfully');
      }
    } catch (e) {
      // Handle any errors that occur during the update process
      print('Failed to update user profile: $e');
    }
  }
// Inside your StatefulWidget class

  void saveProfileChanges() {
    String newName = nameController.text;
    String newEmail = emailController.text;
    String newPhoneNumber = phonedController.text;

    // Call the function to update user profile data
    updateUserProfile(newName, newEmail, newPhoneNumber);
  }

  void deleteAccountAndLogout() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.delete();

        //   await FirebaseAuth.instance.signOut();
      } catch (e) {
        print("Failed to delete account: $e");
      }
    }
  }

  void deleteAccount() {
    // Add your logic to delete the account here
    // For example, you can display a confirmation dialog before deleting the account
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete your account?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                deleteAccountAndLogout();
                Get.to(OnbodingScreen());
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );
  }

  void changePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updatePassword(newPassword);

        print('Password changed successfully');
      }
    } catch (e) {
      print('Failed to change password: $e');
    }
  }
  // Inside your StatefulWidget class

  void savePasswordChanges() {
    String newPassword = passwordController.text;

    // Call the function to change the password
    changePassword(newPassword);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phonedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // -- IMAGE with ICON

              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    EditItem(
                      label: 'UserName',
                      prefixIcon: Icon(LineAwesomeIcons.user),
                      controller: nameController,
                      onChanged: (bool value) {},
                    ),
                    const SizedBox(height: 20),
                    EditItem(
                      label: 'Email',
                      prefixIcon: Icon(LineAwesomeIcons.envelope_1),
                      controller: emailController,
                      onChanged: (bool value) {},
                    ),
                    const SizedBox(height: 20),
                    EditItem(
                      label: 'PhoneNumber',
                      prefixIcon: Icon(LineAwesomeIcons.phone),
                      controller: phonedController,
                      onChanged: (bool value) {},
                    ),
                    const SizedBox(height: 20),
                    EditItem(
                      obscureText: true,
                      label: 'Password',
                      prefixIcon: Icon(LineAwesomeIcons.fingerprint),
                      suffixIcon: IconButton(
                        icon: const Icon(LineAwesomeIcons.eye_slash),
                        onPressed: () {},
                      ),
                      controller: passwordController,
                      onChanged: (bool value) {
                        // Toggle the visibility of the password text based on the value
                      },
                    ),
                    const SizedBox(height: 40),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          saveProfileChanges();
                          savePasswordChanges();
                          Get.to(ProfileBody());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: KMainColor,
                          // side: const BorderSide.none(),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'Update Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // -- Created Date and Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Created at ',
                            style: const TextStyle(fontSize: 12),
                            children: const [
                              TextSpan(
                                text: '2022-01-01',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            deleteAccount();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent
                                .withOpacity(0.8), // Darker shade of red
                            elevation: 0,
                            shape: const StadiumBorder(),
                            // Add a border for better visibility
                            side:
                                const BorderSide(color: Colors.red, width: 0.9),
                          ),
                          child: Text(
                            'Delete Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

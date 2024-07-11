import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/on_boardibg/on_boarding_screen.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/profile/profile_body.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
  }

  String username = '';
  String phone = '';
  String email = '';
  bool _obscurePassword = true; // Define _obscurePassword variable

  @override
  void initState() {
    super.initState();
    // Load user data when the page loads
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      // Get the current user's data from Firestore
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      // Update local variables with user data
      setState(() {
        username = snapshot.get('username') ?? '';
        phone = snapshot.get('phone') ?? '';
        email = snapshot.get('email') ?? '';
        // Initialize controllers with stored values
        _usernameController = TextEditingController(text: username);
        _phoneController = TextEditingController(text: phone);
        _emailController = TextEditingController(text: email);
      });
    } catch (error) {
      print('Error loading user data: $error');
    }
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
    String newPassword = _passwordController.text;

    // Call the function to change the password
    changePassword(newPassword);
  }

  void updateUserProfile() async {
    try {
      // Update user profile in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'username': _usernameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
      savePasswordChanges();

      // Navigate to profile body page after a delay
      Future.delayed(Duration(seconds: 1), () {
        Get.to(ProfileBody());
      });
      // Show success message or navigate back to profile page
      // You can add your own logic here
    } catch (error) {
      // Handle errors
      print('Error updating user profile: $error');
      // Show error message (AlertDialog)
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update profile. Please try again later.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Eedit Profile page'),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.to(const ProfileBody()),
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  'Username',
                  _usernameController,
                  Icon(LineAwesomeIcons.user),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                    'Phone', _phoneController, Icon(LineAwesomeIcons.phone)),
                const SizedBox(height: 20),
                _buildTextField('Email', _emailController,
                    Icon(LineAwesomeIcons.envelope_1)),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(80)),
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(LineAwesomeIcons.fingerprint),
                    suffixIcon: IconButton(
                      icon: _obscurePassword
                          ? Icon(LineAwesomeIcons.eye_slash)
                          : Icon(LineAwesomeIcons.eye),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: updateUserProfile,
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
                // ElevatedButton(
                //   onPressed: updateUserProfile,
                //   child: const Text('Save Changes'),
                // ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                        side: const BorderSide(color: Colors.red, width: 0.9),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String labelText, TextEditingController controller, Widget prefixIcon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(80)),
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon,
      ),
    );
  }
}

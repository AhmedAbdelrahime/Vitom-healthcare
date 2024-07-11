import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PasswordResetEmailScreen extends StatefulWidget {
  const PasswordResetEmailScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetEmailScreen> createState() =>
      _PasswordResetEmailScreenState();
}

class _PasswordResetEmailScreenState extends State<PasswordResetEmailScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    // Add logic here to validate email address

    dispose() {
      emailController.dispose();
      super.dispose();
    }

    // Add logic here to send password reset email
    Future sendPasswordResetEmail() async {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());
        Get.snackbar(
          'Success',
          'Password reset link has been sent to your email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
        );
        Get.back();
      } catch (e) {
        print('Error sending password reset email: $e');
        String errorMessage =
            'An error occurred while sending the password reset email.';
        if (e is FirebaseAuthException) {
          errorMessage = e.message ?? errorMessage;
        }
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Forgot_password.png', // Add your image path
                height: 300,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 30),
              Text(
                'Forget Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Enter your email address below to reset your password.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                // Add logic here to validate email address
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  labelText: 'Email Address',
                  hintText: 'Enter your email address',
                  prefixIcon: Icon(LineAwesomeIcons.envelope_1),
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      KMainColor), // Set your main color here
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: sendPasswordResetEmail,
                child: Text(
                  'Send Reset Link',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

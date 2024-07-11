import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PasswordResetPhoneScreen extends StatelessWidget {
  const PasswordResetPhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
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
                'Enter your phone number below to reset your password.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(80)),
                  labelText: 'Phone Number',
                  hintText: 'Enter your Phone Number',
                  prefixIcon: Icon(LineAwesomeIcons.phone),
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      KMainColor), // Set your main color here
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  // Add logic here to send password reset email
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.white70,
                      content: Text(
                        'Password reset link sent to your phone.',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  );
                },
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

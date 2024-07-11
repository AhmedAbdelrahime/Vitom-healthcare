import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/homepage/home.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/forgetpassword/forgetpassworddialog.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/on_boardibg/on_boarding_screen.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/singin/sing_in_form.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/singup/sing_up_dialoge.dart';

Future<void> loginAnonymously(BuildContext context) async {
  try {
    // Call the sign-in Anonymously method from FirebaseAuth instance
    await FirebaseAuth.instance.signInAnonymously();
    print('Logged in anonymously');

    // Navigate to the home page upon successful login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RiveAppHome()),
    );
  } catch (e) {
    // If there's any error, show a snackbar with the error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error logging in anonymously: $e'),
      ),
    );
    print('Error logging in anonymously: $e');
  }
}

class SingInDialoge extends StatefulWidget {
  final ValueChanged onValue;

  const SingInDialoge({Key? key, required this.onValue}) : super(key: key);

  @override
  _SingInDialogeState createState() => _SingInDialogeState();
}

class _SingInDialogeState extends State<SingInDialoge> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 660,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 30),
              blurRadius: 60,
            ),
            const BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 30),
              blurRadius: 60,
            ),
          ],
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 34,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Sing in to enjoy the features we’ve provided, and stay healthy!.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SignInForm(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: GestureDetector(
                            onTap: () {
                              Get.to(ForgetPasswordDialog(
                                onValue: (value) {},
                              ));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 14,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        "Sign up with Email,  Or login as a guest",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(SingUpDialoge(
                              onValue: (value) {},
                            ));
                          },
                          padding: EdgeInsets.zero,
                          icon: Column(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/email_box.svg",
                                height: 64,
                                width: 64,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            loginAnonymously(
                                context); // Call the login method when the button is pressed
                          },
                          padding: EdgeInsets.zero,
                          icon: Column(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/google_box.svg",
                                height: 64,
                                width: 64,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Guset",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  onPressed: () {
                    Get.to(OnbodingScreen());
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

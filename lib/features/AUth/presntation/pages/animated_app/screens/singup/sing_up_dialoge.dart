import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/on_boardibg/on_boarding_screen.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/singin/singin_dialog.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/singup/singup_form.dart';

class SingUpDialoge extends StatefulWidget {
  final ValueChanged onValue;

  const SingUpDialoge({Key? key, required this.onValue}) : super(key: key);

  @override
  _SingUpDialogeState createState() => _SingUpDialogeState();
}

class _SingUpDialogeState extends State<SingUpDialoge> {
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
                      "Sign UP",
                      style: TextStyle(
                        fontSize: 34,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Sing up to our app to enjoy the features we’ve provided, and stay healthy!.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SignUpForm(),
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
                        "Already have an account?",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(SingInDialoge(
                              onValue: (value) {
                                // Do something with the value returned from the dialog
                              },
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
                              Text(
                                "login with email",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
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

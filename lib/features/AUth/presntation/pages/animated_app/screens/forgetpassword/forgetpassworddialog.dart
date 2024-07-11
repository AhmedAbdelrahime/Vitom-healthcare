import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/forgetpassword/forgetpasswordform.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/on_boardibg/on_boarding_screen.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/singup/sing_up_dialoge.dart';

class ForgetPasswordDialog extends StatefulWidget {
  final ValueChanged onValue;

  const ForgetPasswordDialog({Key? key, required this.onValue})
      : super(key: key);

  @override
  _ForgetPasswordDialogState createState() => _ForgetPasswordDialogState();
}

class _ForgetPasswordDialogState extends State<ForgetPasswordDialog> {
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
                      "Forget Password?",
                      style: TextStyle(
                        fontSize: 34,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "We'll send you a link to reset your password to your email address.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const ForgetPasswordForm(),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Row(
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              Get.to(SingUpDialoge(
                                onValue: (value) {},
                              ));
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 14,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
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

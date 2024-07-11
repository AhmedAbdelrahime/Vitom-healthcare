import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/core/Widgets/btnnavigationbar.dart';
import 'package:complex_ui_rive_animation/features/AUth/firebase_auth_services.dart';
import 'package:rive/rive.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger error;
  late SMITrigger success;
  late SMITrigger reset;

  late SMITrigger confetti;
  //firebase auth
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isloading = false;

  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  void _onCheckRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    artboard.addController(controller!);
    error = controller.findInput<bool>('Error') as SMITrigger;
    success = controller.findInput<bool>('Check') as SMITrigger;
    reset = controller.findInput<bool>('Reset') as SMITrigger;
  }

  void _onConfettiRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);

    confetti = controller.findInput<bool>("Trigger explosion") as SMITrigger;
  }

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    try {
      setState(() {
        isloading = true; // Set isloading to true when sending the email
      });
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      final snackBar = SnackBar(
        content: Text('Password reset link has been sent to your email.'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                onPressed: () {
                  Get.back();
                  setState(() {
                    isloading =
                        false; // Set isloading to false when there's an error
                  });
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        isloading =
            false; // Set isloading to false when the operation is completed
      });
    }
  }

  // void singIn(BuildContext context) {
  //   // confetti.fire();
  //   setState(() {
  //     isShowConfetti = true;
  //     isShowLoading = true;
  //   });
  //   Future.delayed(
  //     const Duration(seconds: 1),
  //     () {
  //       if (_formKey.currentState!.validate()) {
  //         success.fire();
  //         Future.delayed(
  //           const Duration(seconds: 2),
  //           () {
  //             setState(() {
  //               isShowLoading = false;
  //             });
  //             confetti.fire();
  //             // Navigate & hide confetti
  //             Future.delayed(const Duration(seconds: 1), () {
  //               // Navigator.pop(context);
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => const EntryPoint(),
  //                 ),
  //               );
  //             });
  //           },
  //         );
  //       } else {
  //         error.fire();
  //         Future.delayed(
  //           const Duration(seconds: 2),
  //           () {
  //             setState(() {
  //               isShowLoading = false;
  //             });
  //             reset.fire();
  //           },
  //         );
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Email",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " Please enter your email address";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset("assets/icons/email.svg"),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                child: ElevatedButton.icon(
                  onPressed: () {
                    sendPasswordResetEmail(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF199A8E),
                    minimumSize: const Size(double.infinity, 56),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                    ),
                  ),
                  icon: const Icon(
                    CupertinoIcons.mail,
                    color: Colors.white,
                  ),
                  label: isloading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(" Send Reset Link",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                ),
              ),
            ],
          ),
        ),
        isShowLoading
            ? CustomPositioned(
                child: RiveAnimation.asset(
                  'assets/RiveAssets/check.riv',
                  fit: BoxFit.cover,
                  onInit: _onCheckRiveInit,
                ),
              )
            : const SizedBox(),
        isShowConfetti
            ? CustomPositioned(
                scale: 6,
                child: RiveAnimation.asset(
                  "assets/RiveAssets/confetti.riv",
                  onInit: _onConfettiRiveInit,
                  fit: BoxFit.cover,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, this.scale = 1, required this.child});

  final double scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 100,
            width: 100,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

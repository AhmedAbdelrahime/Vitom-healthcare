import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/core/Widgets/btnnavigationbar.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';
import 'package:complex_ui_rive_animation/features/AUth/firebase_auth_services.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/homepage/home.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:rive/rive.dart';
import 'package:group_button/group_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger error;
  late SMITrigger success;
  late SMITrigger reset;

  late SMITrigger confetti;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  //final confirmIdController = TextEditingController();
  final passwordController = TextEditingController();
  final phonedController = TextEditingController();

  // final confirmPasswordController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  bool isloading = false;
  bool _isEmailValid(String email) {
    // Regular expression pattern for email validation
    final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailPattern.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    // Check if password meets the required length
    return password.length >= 6;
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    ageController.dispose();
    phonedController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

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

  void _singUp(BuildContext context) async {
    // Check if email and password are valid
    if (!_isEmailValid(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid email address.'),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!_isPasswordValid(passwordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password must be at least 6 characters long.'),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          behavior: SnackBarBehavior.floating, // Position at the top
        ),
      );
      return;
    }

    setState(() {
      isShowConfetti = true;
      isShowLoading = true;
    });

    // Proceed with sign up
    try {
      final userCredential = await FirebaseAuthService().singupUser(
        email: emailController.text,
        username: nameController.text,
        phone: phonedController.text,
        gender: genderController.text,
        age: ageController.text,
        password: passwordController.text,
      );

      // Check userCredential and navigate accordingly
      // Handle errors as before
      if (userCredential != null) {
        success.fire();

        await Future.delayed(const Duration(seconds: 2));

        setState(() {
          isShowLoading = false;
        });

        confetti.fire();

        await Future.delayed(const Duration(seconds: 1));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RiveAppHome(),
          ),
        );
      } else {
        throw FirebaseAuthException(
          code: 'user_null',
          message: 'User is null',
        );
      }
    } catch (e) {
      _handleSignUpError(context, e);
    }
  }

  // Future<void> _singUp(BuildContext context) async {
  //   setState(() {
  //     isShowConfetti = true;
  //     isShowLoading = true;
  //   });

  //   try {
  //     final userCredential = await FirebaseAuthService().singupUser(
  //       email: emailController.text,
  //       username: nameController.text,
  //       phone: phonedController.text,
  //       gender: genderController.text,
  //       age: ageController.text,
  //       password: passwordController.text,
  //     );

  //     // Check if userCredential is not null, indicating successful sign-up
  //     if (userCredential != null) {
  //       success.fire();

  //       await Future.delayed(const Duration(seconds: 2));

  //       setState(() {
  //         isShowLoading = false;
  //       });

  //       confetti.fire();

  //       await Future.delayed(const Duration(seconds: 1));

  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const RiveAppHome(),
  //         ),
  //       );
  //     } else {
  //       throw FirebaseAuthException(
  //         code: 'user_null',
  //         message: 'User is null',
  //       );
  //     }
  //   } catch (e) {
  //     _handleSignUpError(context, e.toString());
  //   }
  // }

  void _handleSignUpError(BuildContext context, dynamic error) {
    String errorMessage;
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'email-already-in-use':
          errorMessage =
              'The email address is already in use by another account.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'user-disabled':
          errorMessage = 'The user account has been disabled.';
          break;
        case 'user-token-expired':
          errorMessage =
              'The user\'s credential is no longer valid. The user must sign in again.';
          break;
        // Add more cases as needed
        default:
          errorMessage = 'Error signing up: ${error.message}';
      }
    } else {
      errorMessage = 'Error signing up: ${error.toString()}';
    }

    error.fire();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 120, 120),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    setState(() {
      isShowLoading = false;
    });

    reset.fire();
  }

  // void singup() async {
  //   setState(() {
  //     isloading = true;
  //     isShowConfetti = true;
  //   });
  //   // Get.to(const BotNavbar());
  //   String res = await FirebaseAuthService().singupUser(
  //     email: emailController.text,
  //     username: nameController.text,
  //     phone: phonedController.text,
  //     gender: genderController.text,
  //     age: ageController.text,
  //     password: passwordController.text,
  //   );
  //   if (res != 'success') {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           res,
  //           style: TextStyle(color: Colors.white, fontSize: 16),
  //         ),
  //         backgroundColor: const Color.fromARGB(255, 255, 120, 120),
  //         duration: Duration(seconds: 3),
  //         elevation: 10,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //       ),
  //     );
  //     setState(() {
  //       isloading = false;
  //       isShowConfetti = false;
  //     });
  //   } else {
  //     Get.to(const EntryPoint());
  //   }
  // }

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
                "Enter Your Name",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " Please Enter Your Name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        LineAwesomeIcons.user,
                        color: Colors.black54,
                        size: 20,
                      ),
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
                      child: Icon(
                        LineAwesomeIcons.envelope,
                        color: Colors.black54,
                        size: 20,
                      ),
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
              const Text(
                "Enter Your Phone",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  controller: phonedController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " Please enter your phone number";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        LineAwesomeIcons.phone,
                        color: Colors.black54,
                        size: 20,
                      ),
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
              const Text(
                "Enter Your password",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " Please enter your password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        LineAwesomeIcons.eye,
                        color: Colors.black54,
                        size: 20,
                      ),
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
              const Text(
                "Enter Your Age'",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " Please enter your age";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        LineAwesomeIcons.calendar_check,
                        color: Colors.black54,
                        size: 20,
                      ),
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
              const Text(
                "Enter your Gender",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: GroupButton(
                  onSelected: (value, index, isSelected) {
                    genderController.text = value;
                  },
                  buttons: const ["Male", "Female"],
                  options: GroupButtonOptions(
                    spacing: 15,
                    buttonWidth: 114,
                    buttonHeight: 60,
                    selectedColor: KMainColor,
                    borderRadius: BorderRadius.circular(20),
                    unselectedColor: Colors.white,
                    mainGroupAlignment: MainGroupAlignment.center,
                    crossGroupAlignment: CrossGroupAlignment.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _singUp(context);
                    }
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
                    CupertinoIcons.person_add,
                    color: Colors.white,
                  ),
                  label: const Text("Sign Up",
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/homepage/home.dart';
import 'package:rive/rive.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isShowLoading = false;
  bool _isShowConfetti = false;
  late SMITrigger error;
  late SMITrigger success;
  late SMITrigger reset;

  late SMITrigger confetti;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isloading = false;

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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

  Future<void> _signIn(BuildContext context) async {
    setState(() {
      _isShowConfetti = true;
      _isShowLoading = true;
    });

    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Check if userCredential is not null, indicating successful sign-in
      if (userCredential.user != null) {
        success.fire();

        await Future.delayed(const Duration(seconds: 2));

        setState(() {
          _isShowLoading = false;
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
      _handleSignInError(context, e.toString());
    }
  }

  void _handleSignInError(BuildContext context, String errorMessage) {
    error.fire();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Error signing in: $errorMessage',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 120, 120),
        duration: Duration(seconds: 3),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    setState(() {
      _isShowLoading = false;
    });

    reset.fire();
  }

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
                  controller: _emailController,
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
              const Text(
                "Password",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  controller: _passwordController,
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
                      child: SvgPicture.asset("assets/icons/password.svg"),
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
                    if (_formKey.currentState!.validate()) {
                      _signIn(context);
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
                    CupertinoIcons.arrow_right,
                    color: Color.fromARGB(255, 238, 240, 240),
                  ),
                  label: const Text("Sign In"),
                ),
              ),
            ],
          ),
        ),
        _isShowLoading
            ? CustomPositioned(
                child: RiveAnimation.asset(
                  'assets/RiveAssets/check.riv',
                  fit: BoxFit.cover,
                  onInit: _onCheckRiveInit,
                ),
              )
            : const SizedBox(),
        _isShowConfetti
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

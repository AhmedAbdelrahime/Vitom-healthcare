import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/singin/singin_dialog.dart';
import 'package:rive/rive.dart';

class OnbodingScreen extends StatefulWidget {
  const OnbodingScreen({
    super.key,
  });

  @override
  State<OnbodingScreen> createState() => _OnbodingScreenState();
}

class _OnbodingScreenState extends State<OnbodingScreen> {
  late RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 100,
            bottom: 100,
            child: Image.asset(
              "assets/Backgrounds/Spline.png",
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset(
            "assets/RiveAssets/shapes.riv",
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isShowSignInDialog ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const SizedBox(
                      width: 260,
                      child: Column(
                        children: [
                          Text(
                            " Vitom",
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              height: 1.2,
                              color: KMainColor,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text("Empowering Your Health Journey",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                height: 1.2,
                              )),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),

                    GestureDetector(
                      onTap: () {
                        _btnAnimationController.isActive = true;

                        Future.delayed(
                          const Duration(milliseconds: 800),
                          () {
                            setState(() {
                              isShowSignInDialog = true;
                            });
                            showDialog(
                              context: context,
                              builder: (context) => SingInDialoge(
                                onValue: (_) {
                                  setState(() {
                                    isShowSignInDialog = false;
                                  });
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: SizedBox(
                        height: 64,
                        width: 236,
                        child: Stack(
                          children: [
                            RiveAnimation.asset(
                              "assets/RiveAssets/button.riv",
                              controllers: [_btnAnimationController],
                            ),
                            Positioned.fill(
                              top: 8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(CupertinoIcons.arrow_right),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Start ",
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    // press: () {
                    //   _btnAnimationController.isActive = true;

                    //   Future.delayed(
                    //     const Duration(milliseconds: 800),
                    //     () {
                    //       setState(() {
                    //         isShowSignInDialog = true;
                    //       });
                    //       showDialog(
                    //         context: context,
                    //         builder: (context) => SingInDialoge(
                    //           onValue: (_) {
                    //             setState(() {
                    //               isShowSignInDialog = false;
                    //             });
                    //           },
                    //         ),
                    //       );
                    //     },
                    //   );
                    // },

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        "Unleash the Power of AI & Sensors.",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: KMainColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/homepage/pages/search.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/navigation/custom_tab_bar.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/navigation/home_tab_view.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/on_boardibg/on_boarding_screen.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/profile/profile_body.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/theme.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/chatbot/pages/chat_page.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/body_checkup/widgets/svaed.dart';
import 'package:rive/rive.dart' hide LinearGradient;
import 'dart:math' as math;

// Common Tab Scene for the tabs other than 1st one, showing only tab name in center
Widget commonTabScene(String tabName) {
  return Container(
      color: RiveAppTheme.background,
      alignment: Alignment.center,
      child: Text(tabName,
          style: const TextStyle(
              fontSize: 28, fontFamily: "Poppins", color: Colors.black)));
}

class RiveAppHome extends StatefulWidget {
  const RiveAppHome({Key? key}) : super(key: key);

  static const String route = '/course-rive';

  @override
  State<RiveAppHome> createState() => _RiveAppHomeState();
}

class _RiveAppHomeState extends State<RiveAppHome>
    with TickerProviderStateMixin {
  late AnimationController? _animationController;
  late AnimationController? _onBoardingAnimController;
  late Animation<double> _onBoardingAnim;
  late Animation<double> _sidebarAnim;

  late SMIBool _menuBtn;

  bool _showOnBoarding = false;
  Widget _tabBody = Container(color: RiveAppTheme.background);
  final List<Widget> _screens = [
    HomeTabView(),
    SearchPage(),
    SavedCheckupsPage(),
    ChatPage(),
    ProfileBody(),
  ];

  final springDesc = const SpringDescription(
    mass: 0.1,
    stiffness: 40,
    damping: 5,
  );

  void onMenuPress() {
    if (_menuBtn.value) {
      final springAnim = SpringSimulation(springDesc, 0, 1, 0);
      _animationController?.animateWith(springAnim);
    } else {
      _animationController?.reverse();
    }
    _menuBtn.change(!_menuBtn.value);

    SystemChrome.setSystemUIOverlayStyle(_menuBtn.value
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light);
  }

  bool isAnonymous() {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null && user.isAnonymous;
  }

  void onTabChange(int tabIndex) {
    if (tabIndex == 4 && isAnonymous()) {
      // Show a dialog or display a message indicating that the profile page
      // is not accessible for anonymous users
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Profile Access'),
            content: Text('You need to log in to access the profile page.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        _tabBody = _screens[tabIndex];
      });
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      upperBound: 1,
      vsync: this,
    );
    _onBoardingAnimController = AnimationController(
      duration: const Duration(milliseconds: 350),
      upperBound: 1,
      vsync: this,
    );

    _sidebarAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.linear,
    ));

    _onBoardingAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _onBoardingAnimController!,
      curve: Curves.linear,
    ));

    _tabBody = _screens.first;
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _onBoardingAnimController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned(child: Container(color: RiveAppTheme.background2)),

          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _showOnBoarding ? _onBoardingAnim : _sidebarAnim,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 -
                      (_showOnBoarding
                          ? _onBoardingAnim.value * 0.08
                          : _sidebarAnim.value * 0.1),
                  child: Transform.translate(
                    offset: Offset(_sidebarAnim.value * 265, 0),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY((_sidebarAnim.value * 30) * math.pi / 180),
                      child: child,
                    ),
                  ),
                );
              },
              child: _tabBody,
            ),
          ),
          AnimatedBuilder(
            animation: _sidebarAnim,
            builder: (context, child) {
              return Positioned(
                top: MediaQuery.of(context).padding.top + 20,
                right: (_sidebarAnim.value * -100) + 16,
                child: child!,
              );
            },
            child: GestureDetector(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: RiveAppTheme.shadow.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: const Icon(Icons.person_outline),
                ),
              ),
              onTap: () {
                Get.defaultDialog(
                  title: "LOGOUT",
                  titleStyle: const TextStyle(fontSize: 20),
                  content: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text("Are you sure, you want to Logout?"),
                  ),
                  confirm: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      // AuthenticationRepository.instance.logout();
                      Get.to(const OnbodingScreen());
                    },
                    // onPressed: () => AuthenticationRepository.instance.logout(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        side: BorderSide.none),
                    child: const Text("Yes"),
                  ),
                  cancel: OutlinedButton(
                      onPressed: () => Get.back(), child: const Text("No")),
                );

                // Get.to(const OnbodingScreen());
                // _presentOnBoarding(true);
              },
            ),
          ),
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _sidebarAnim,
              builder: (context, child) {
                return SafeArea(
                  child: Row(
                    children: [
                      // There's an issue/behaviour in flutter where translating the GestureDetector or any button
                      // doesn't translate the touch area, making the Widget unclickable, so instead setting a SizedBox
                      // in a Row to have a similar effect
                      SizedBox(width: _sidebarAnim.value * 216),
                      child!,
                    ],
                  ),
                );
              },
              child: GestureDetector(
                onTap: onMenuPress,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    width: 44,
                    height: 44,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(44 / 2),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: RiveAppTheme.shadow.withOpacity(0.2),
                      //     blurRadius: 5,
                      //     offset: const Offset(0, 5),
                      //   )
                      // ],
                    ),
                    // child: RiveAnimation.asset(
                    //   'assets/RiveAssets/menu_button.riv',
                    //   stateMachines: const ["State Machine"],
                    //   animations: const ["open", "close"],
                    //   onInit: _onMenuIconInit,
                    // ),
                  ),
                ),
              ),
            ),
          ),
          if (_showOnBoarding)
            RepaintBoundary(
              child: AnimatedBuilder(
                animation: _onBoardingAnim,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                        0,
                        -(MediaQuery.of(context).size.height +
                                MediaQuery.of(context).padding.bottom) *
                            (1 - _onBoardingAnim.value)),
                    child: child!,
                  );
                },
                child: SafeArea(
                  top: false,
                  maintainBottomViewPadding: true,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 40,
                            offset: const Offset(0, 40))
                      ],
                    ),
                    // child: OnBoardingView(
                    //   closeModal: () {
                    //     _presentOnBoarding(false);
                    //   },
                    // ),
                  ),
                ),
              ),
            ),
          // White underlay behind the bottom tab bar
          IgnorePointer(
            ignoring: true,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedBuilder(
                  animation: !_showOnBoarding ? _sidebarAnim : _onBoardingAnim,
                  builder: (context, child) {
                    return Container(
                      height: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            RiveAppTheme.background.withOpacity(0),
                            RiveAppTheme.background.withOpacity(1 -
                                (!_showOnBoarding
                                    ? _sidebarAnim.value
                                    : _onBoardingAnim.value))
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: RepaintBoundary(
        child: AnimatedBuilder(
          animation: !_showOnBoarding ? _sidebarAnim : _onBoardingAnim,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                  0,
                  !_showOnBoarding
                      ? _sidebarAnim.value * 300
                      : _onBoardingAnim.value * 200),
              child: child,
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomTabBar(onTabChange: onTabChange
                  // (tabIndex) {
                  //   setState(() {
                  //     _tabBody = _screens[tabIndex];
                  //   });
                  // },
                  )
            ],
          ),
        ),
      ),
    );
  }
}

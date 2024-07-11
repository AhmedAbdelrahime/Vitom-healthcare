import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/homepage/home.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/homepage/pages/search.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/on_boardibg/on_boarding_screen.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/profile/aboutus.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/profile/billingDetails.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/profile/profile_body.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/profile/updatetest.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/body_checkup/widgets/body_checkup_body.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/body_checkup/widgets/svaed.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/lung_checkup/widgets/lung.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/models/mainmenuscreen.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/resource_library_screen/resource_library_screen.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/robotcontrol/controlpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/core/widgets/card.dart';
import 'package:complex_ui_rive_animation/features/AUth/firebase_auth_services.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/theme.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/chatbot/pages/chat_page.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/body_checkup/body_checkup_view.dart';
import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/formheartrate/heartrateform.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/lung_checkup/lung_checkup_view.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:complex_ui_rive_animation/model/user.dart' as model;

class HomeTabView extends StatefulWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  String username = '';
  String age = '';
  final FirebaseAuthService _authService = FirebaseAuthService();
  final GlobalKey<BodyCheckupBodyState> bodyCheckupKey =
      GlobalKey<BodyCheckupBodyState>();
  final GlobalKey<LungCheckupBodyState> lungCheckupKey =
      GlobalKey<LungCheckupBodyState>();

  @override
  void initState() {
    super.initState();
    _initAlanButton();
    getUserData();
  }

  void _initAlanButton() {
    AlanVoice.addButton(
      "540af993d72e6c789e1136ad1509e77d2e956eca572e1d8b807a3e2338fdd0dc/stage",
      buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT,
    );

    AlanVoice.onCommand.add((command) {
      String commandName = command.data["command"];
      debugPrint("Received command: ${command.data}");
      switch (commandName) {
        case "GreetUser":
          _greetUser();
          break;
        case "NavigateToHome":
          _navigateTo(RiveAppHome());
          break;
        case "NavigateToAboutUsPage":
          _navigateTo(AboutUsPage());
          break;
        case "NavigateToBillingPage":
          _navigateTo(BillingDetailsPage());
          break;
        case "NavigateToProfile":
          _navigateTo(ProfileBody());
          break;
        case "NavigateToEditProfilePage":
          _navigateTo(EditProfilePage());
          break;
        case "NavigateToSearchPage":
          _navigateTo(SearchPage());
          break;
        case "NavigateToSavedCheckupsPage":
          _navigateTo(SavedCheckupsPage());
          break;
        case "NavigateToChatPage":
          _navigateTo(ChatPage());
          break;
        case "NavigateToBodyCheckupView":
          _navigateTo(BodyCheckupView());
          break;
        case "NavigateToLungCheckupView":
          _navigateTo(LungCheckupView());
          break;
        case "NavigateToControlScreen":
          _navigateTo(ControlScreen());
          break;
        case "NavigateToHeartRateForm":
          _navigateTo(HeartAttackRiskForm());
          break;
        case "StartCheckup":
          _startCheckup();
          break;
        case "ShowCheckupResults":
          _showCheckupResults();
          break;
        case "SaveCheckupResults":
          _saveCheckupResults();
          break;
        case "StartLungCheckups":
          _startLungCheckups();
          break;
        case "ViewLungCheckupResults":
          _viewLungCheckupResults();
          break;
        case "SaveLungCheckupResults":
          _saveLungCheckupResults();
          break;
        case "LogOut":
          _logOut();
          break;
        case "GoBack":
          _goBack();
          break;
        default:
          debugPrint("Unhandled command: $commandName");
      }
    });
  }

  void _navigateTo(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void _goBack() {
    Navigator.pop(context);
  }

  void _logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => OnbodingScreen()),
    );
  }

  void _startCheckup() {
    bodyCheckupKey.currentState?.sendRealTimeData();
  }

  void _showCheckupResults() {
    bodyCheckupKey.currentState?.seeCheckup();
  }

  void _saveCheckupResults() {
    bodyCheckupKey.currentState?.saveCheckup();
  }

  void _startLungCheckups() {
    lungCheckupKey.currentState?.sendRealTimeData();
    lungCheckupKey.currentState?.loadImage();
  }

  void _viewLungCheckupResults() {
    lungCheckupKey.currentState?.seeCheckup();
  }

  void _saveLungCheckupResults() {
    lungCheckupKey.currentState?.saveCheckup();
  }

  void getUserData() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    model.User user = await _authService.getUserDetails();

    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

    // Get initial user data
    DocumentSnapshot userSnapshot = await userRef.get();
    setState(() {
      username = userSnapshot['username'];
      age = userSnapshot['age'];
    });

    // Set up listener for real-time updates
    userRef.snapshots().listen((event) {
      setState(() {
        username = event['username'];
        age = event['age'];
      });
    });
  }

  void _greetUser() {
    if (username.isNotEmpty) {
      AlanVoice.playText('Hi, $username. How can I help you?');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: RiveAppTheme.background,
          borderRadius: BorderRadius.circular(30),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 60,
              bottom: MediaQuery.of(context).padding.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${FirebaseAuth.instance.currentUser!.isAnonymous ? 'Undefined' : age} Years Old',
                      style: const TextStyle(
                        color: Color(0xFF002A20),
                        fontSize: 22,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'Hello ${FirebaseAuth.instance.currentUser!.isAnonymous ? 'Guest' : username}',
                      style: const TextStyle(
                        color: Color(0xFF00906D),
                        fontSize: 22,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      'Explore checkups',
                      style: TextStyle(
                        color: Color(0xFF002A20),
                        fontSize: 30,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomCard(
                  description: 'lung',
                  image: 'assets/images/lung.png',
                  title: 'Lung Checkup',
                  onTap: () {
                    Get.to(const LungCheckupView());
                  },
                ),
                const SizedBox(width: 40),
                CustomCard(
                  description: 'body',
                  image: 'assets/images/body.png',
                  title: 'Body Checkup',
                  onTap: () {
                    Get.to(const BodyCheckupView());
                  },
                ),
              ]),
              const SizedBox(height: 40),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomCard(
                  description: 'heart',
                  image: 'assets/images/heartratecard.png',
                  title: 'Heart Checkup',
                  onTap: () {
                    Get.to(HeartAttackRiskForm());
                  },
                ),
                const SizedBox(width: 40),
                CustomCard(
                  description: 'chatbot',
                  image: 'assets/images/chatbot.png',
                  title: 'MediBot',
                  onTap: () {
                    Get.to(const ChatPage());
                  },
                ),
              ]),
              const SizedBox(height: 40),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomCard(
                  description: 'resourece Library',
                  image: 'assets/resours.png',
                  title: 'resourece Library',
                  onTap: () {
                    Get.to(ResourceLibraryScreen());
                  },
                ),
                const SizedBox(width: 40),
                CustomCard(
                  description: '',
                  image: 'assets/ed.png',
                  title: 'education system',
                  onTap: () {
                    Get.to(MainMenuScreen());
                  },
                ),
              ]),
              SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Controling ',
                  style: TextStyle(
                    color: Color(0xFF002A20),
                    fontSize: 30,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: CustomCard(
                  description: 'Move and Control Vitom',
                  image: 'assets/images/robotmov.png',
                  title: 'Move and Control Vitom',
                  onTap: () {
                    Get.to(ControlScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

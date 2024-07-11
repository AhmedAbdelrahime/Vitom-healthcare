import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/profile/aboutus.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/profile/billingDetails.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/body_checkup/widgets/svaed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:complex_ui_rive_animation/core/Widgets/profilemenuwidget.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';

import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/homepage/home.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/on_boardibg/on_boarding_screen.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/profile/updatetest.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  Uint8List? image;
  // void selectImage() async {
  //   Uint8List im = await pickImage(ImageSource.camera);
  //   setState(() {
  //     image = im;
  //   });
  // }

  String username = '';
  String age = '';
  String phone = '';
  String email = '';
  String gender = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
      age = (snap.data() as Map<String, dynamic>)['age'];
      phone = (snap.data() as Map<String, dynamic>)['phone'];
      email = (snap.data() as Map<String, dynamic>)['email'];
      gender = (snap.data() as Map<String, dynamic>)['gender'];
    });
  }

  // final int? phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('  Profile page'),

        backgroundColor: Colors.white,

        // title:
        //     Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: gender == 'Male'
                          ? Image.asset('assets/images/Male.png',
                              fit: BoxFit.cover)
                          : Image.asset('assets/images/Female.png',
                              fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                username,
                style: Theme.of(context).textTheme.titleLarge,
                selectionColor: KMainColor,
              ),
              Text(email, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),
              Text(phone, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const EditProfilePage()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: KMainColor,
                      elevation: 0,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Update Profile',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              // ProfileMenuWidget(
              //     title: "Settings",
              //     icon: LineAwesomeIcons.cog,
              //     onPress: () {}),

              ProfileMenuWidget(
                  title: "Billing Details",
                  icon: LineAwesomeIcons.wallet,
                  onPress: () {
                    Get.to(BillingDetailsPage());
                  }),
              const Divider(),

              ProfileMenuWidget(
                  title: "Saved Checkups",
                  icon: LineAwesomeIcons.stethoscope,
                  onPress: () {
                    Get.to(SavedCheckupsPage());
                  }),
              const Divider(),

              ProfileMenuWidget(
                  title: "About Us",
                  icon: LineAwesomeIcons.info,
                  onPress: () {
                    Get.to(AboutUsPage());
                  }),

              const SizedBox(height: 10),
              const Divider(),

              ProfileMenuWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
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
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

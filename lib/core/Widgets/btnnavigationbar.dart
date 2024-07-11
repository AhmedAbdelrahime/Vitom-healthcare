import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';

import 'package:complex_ui_rive_animation/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BotNavbar extends StatefulWidget {
  const BotNavbar({Key? key});

  @override
  State<BotNavbar> createState() => _BotNavbarState();
}

class _BotNavbarState extends State<BotNavbar> {
  final List<Widget> _screens = const [
    //  HomeView(),
    //   ProfileView(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
            activeIcon: Icon(Icons.person),
          )
        ],
        backgroundColor: Colors.grey[50],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 5.0,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(color: KMainColor),
        selectedItemColor: KMainColor,
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (value) {
          if (FirebaseAuth.instance.currentUser!.isAnonymous) {
            // Display a message to the user
            Get.snackbar(
              "Access Denied",
              "You cannot access the profile page as an anonymous user. Please sign up or log in to continue.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              duration: const Duration(seconds: 3),
              mainButton: TextButton(
                onPressed: () {
                  //  Get.to( );
                },
                child: Text("Sign Up"),
              ),
            );
          } else {
            // Navigate to the selected screen
            setState(() {
              _selectedIndex = value;
            });
          }
        },
      ),
      body: _screens[_selectedIndex],
    );
  }
}

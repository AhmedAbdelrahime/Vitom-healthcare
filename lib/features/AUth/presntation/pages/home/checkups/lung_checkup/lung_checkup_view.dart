import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/homepage/home.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/lung_checkup/widgets/lung.dart';

class LungCheckupView extends StatelessWidget {
  const LungCheckupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lung Checkup',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: Colors.white,
        //  backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.to(() => RiveAppHome(), preventDuplicates: true);
          },
        ),
        centerTitle: true,
      ),
      body: LungCheckupBody(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget(
      {super.key,
      this.name,
      required this.title,
      required this.subtitle,
      this.image,
      double? scaleFactor});
  final String? name;
  final String title;
  final String subtitle;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 231,
            height: 263,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage(image!),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            child: Column(
              children: [
                Text(
                  name!,
                  style: const TextStyle(
                    color: KMainColor,
                    fontSize: 50.11,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF101522),
                    fontSize: 22,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0.06,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF707684),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    // height: 0.09,
                    letterSpacing: 0.50,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

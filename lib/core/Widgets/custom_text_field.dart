import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.suffixIcon,
    required this.keyboardType,
    required this.obscureText,
    required this.controller,
    required this.scaleFactor,
    this.validator,
  }) : super(key: key);

  final Widget suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final String hintText;
  final double scaleFactor;
  final String? validator;

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        //  label: Text(hintText),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18 * scaleFactor),
          borderSide: BorderSide.none,
        ),
        fillColor: KMainColor.withOpacity(0.1),
        filled: true,
        prefixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 16 * scaleFactor),
      ),
      controller: controller,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';

import '../utils/size_config.dart';

class CustomGeneralButton extends StatelessWidget {
  const CustomGeneralButton({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  // ignore: use_key_in_widget_constructors<ctrl63>   // ignore: use_key_in_widget_constructors<ctrl63>   // ignore: use_key_in_widget_constructors
  // ignore: use_key_in_widget_constructors

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: SizeConfigs.screenWidth,
        decoration: BoxDecoration(
          color: KMainColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon(
      {super.key, required this.text, this.iconData, this.onTap, this.color});
  final String text;

  final IconData? iconData;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: SizeConfigs.screenWidth,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xff000000))),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}

class CustomBottonForAny extends StatelessWidget {
  const CustomBottonForAny(
      {super.key, required this.text, this.onTap, this.colorbt, this.colortx});
  final String text;
  final VoidCallback? onTap;
  final Color? colorbt;
  final Color? colortx;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 263,
        height: 56,
        decoration: ShapeDecoration(
          color: colorbt,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: KMainColor),
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colortx,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0.09,
            ),
          ),
        ),
      ),
    );
  }
}

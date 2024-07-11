import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';

class ButtonWidget extends StatelessWidget {
  final String text;

  const ButtonWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: KMainColor.withOpacity(.8),
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Text(text),
        onPressed: () => (),
      );
}

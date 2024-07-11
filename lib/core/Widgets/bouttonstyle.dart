import 'package:flutter/material.dart';

class BoutonStyle extends StatefulWidget {
  const BoutonStyle({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color1,
    required this.color2,
    required this.color3,
  });

  final String text;
  final VoidCallback onPressed;
  final Color color1;
  final Color color2;
  final Color color3;

  @override
  State<BoutonStyle> createState() => _BoutonStyleState();
}

class _BoutonStyleState extends State<BoutonStyle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: 70,
        width: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            widget.color1,
            widget.color2,
            widget.color3,
          ]),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

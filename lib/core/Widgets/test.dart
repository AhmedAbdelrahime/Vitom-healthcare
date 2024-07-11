import 'package:flutter/material.dart';

class CamTest extends StatefulWidget {
  const CamTest({super.key});

  @override
  State<CamTest> createState() => _CamTestState();
}

class _CamTestState extends State<CamTest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Image.asset('assets/images/test.png'),
    );
  }
}

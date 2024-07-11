import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class NumbersWidget extends StatefulWidget {
  @override
  _NumbersWidgetState createState() => _NumbersWidgetState();
}

class _NumbersWidgetState extends State<NumbersWidget> {
  final DatabaseReference temperatureRef =
      FirebaseDatabase.instance.reference().child('temp');
  final DatabaseReference heartRateRef =
      FirebaseDatabase.instance.reference().child('heartrate');
  final DatabaseReference oxygenLevelRef =
      FirebaseDatabase.instance.reference().child('oxygenlevel');

  String temp = '';
  String heartRate = '';
  String oxygenLevel = '';

  @override
  void initState() {
    super.initState();
    _setUpListeners();
  }

  void _setUpListeners() {
    temperatureRef.onValue.listen((event) {
      setState(() {
        temp = event.snapshot.value?.toString() ?? '';
      });
    });
    heartRateRef.onValue.listen((event) {
      setState(() {
        heartRate = event.snapshot.value?.toString() ?? '';
      });
    });
    oxygenLevelRef.onValue.listen((event) {
      setState(() {
        oxygenLevel = event.snapshot.value?.toString() ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, temp, ' °C', LineAwesomeIcons.thermometer),
          buildDivider(),
          buildButton(context, heartRate, ' bpm', LineAwesomeIcons.heart),
          buildDivider(),
          buildButton(context, '$oxygenLevel %', 'SpO2', Icons.favorite_border),
        ],
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(
          BuildContext context, String value, String text, IconData icon) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(width: 2),
                Text(
                  text,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 4),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: KMainColor.withOpacity(0.1),
              ),
              child: Icon(icon, color: KMainColor),
            ),
          ],
        ),
      );
}

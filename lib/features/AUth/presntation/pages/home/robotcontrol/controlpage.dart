import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/homepage/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ControlScreen extends StatefulWidget {
  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  late final DatabaseReference _databaseRef;

  // Variables to track button states
  bool _isForwardPressed = false;
  bool _isBackwardPressed = false;
  bool _isLeftPressed = false;
  bool _isRightPressed = false;
  bool _isStopPressed = false;

  @override
  void initState() {
    super.initState();
    _databaseRef = FirebaseDatabase.instance.reference();
  }

  // Method to update Firebase with the current control value
  void _updateFirebase(int controlValue) {
    _databaseRef.update({
      'control': controlValue,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controlling'),
        leading: IconButton(
            onPressed: () => Get.to(RiveAppHome()),
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Forward Button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isForwardPressed = true;
                      _isBackwardPressed = false;
                      _isLeftPressed = false;
                      _isRightPressed = false;
                      _isStopPressed = false;
                      _updateFirebase(2);
                    });
                  },
                  child: Icon(Icons.arrow_upward),
                  style: ButtonStyle(
                    backgroundColor: _isForwardPressed
                        ? MaterialStateProperty.all<Color>(Colors.blue)
                        : null,
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(60, 60)), // Adjust size
                    elevation: MaterialStateProperty.all<double>(
                        8), // Adjust elevation
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left Button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isForwardPressed = false;
                      _isBackwardPressed = false;
                      _isLeftPressed = true;
                      _isRightPressed = false;
                      _isStopPressed = false;
                      _updateFirebase(4);
                    });
                  },
                  child: Icon(Icons.arrow_back),
                  style: ButtonStyle(
                    backgroundColor: _isLeftPressed
                        ? MaterialStateProperty.all<Color>(Colors.blue)
                        : null,
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(60, 60)), // Adjust size
                    elevation: MaterialStateProperty.all<double>(
                        8), // Adjust elevation
                  ),
                ),
                SizedBox(width: 20),
                // Stop Button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isForwardPressed = false;
                      _isBackwardPressed = false;
                      _isLeftPressed = false;
                      _isRightPressed = false;
                      _isStopPressed = true;
                      _updateFirebase(0);
                    });
                  },
                  child: Icon(Icons.stop),
                  style: ButtonStyle(
                    backgroundColor: _isStopPressed
                        ? MaterialStateProperty.all<Color>(Colors.blue)
                        : null,
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(60, 60)), // Adjust size
                    elevation: MaterialStateProperty.all<double>(
                        8), // Adjust elevation
                  ),
                ),
                SizedBox(width: 20),

                // Right Button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isForwardPressed = false;
                      _isBackwardPressed = false;
                      _isLeftPressed = false;
                      _isRightPressed = true;
                      _isStopPressed = false;
                      _updateFirebase(3);
                    });
                  },
                  child: Icon(Icons.arrow_forward),
                  style: ButtonStyle(
                    backgroundColor: _isRightPressed
                        ? MaterialStateProperty.all<Color>(Colors.blue)
                        : null,
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(60, 60)), // Adjust size
                    elevation: MaterialStateProperty.all<double>(
                        8), // Adjust elevation
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Backward Button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isForwardPressed = false;
                      _isBackwardPressed = true;
                      _isLeftPressed = false;
                      _isRightPressed = false;
                      _isStopPressed = false;
                      _updateFirebase(1);
                    });
                  },
                  child: Icon(Icons.arrow_downward),
                  style: ButtonStyle(
                    backgroundColor: _isBackwardPressed
                        ? MaterialStateProperty.all<Color>(Colors.blue)
                        : null,
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(60, 60)), // Adjust size
                    elevation: MaterialStateProperty.all<double>(
                        8), // Adjust elevation
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:complex_ui_rive_animation/core/Widgets/bouttonstyle.dart';
import 'package:complex_ui_rive_animation/core/Widgets/vitalsingcard.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/body_checkup/widgets/svaed.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BodyCheckupBody extends StatefulWidget {
  const BodyCheckupBody({Key? key}) : super(key: key);

  @override
  State<BodyCheckupBody> createState() => BodyCheckupBodyState();
}

class BodyCheckupBodyState extends State<BodyCheckupBody>
    with SingleTickerProviderStateMixin {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();
  final DatabaseReference temperatureRef =
      FirebaseDatabase.instance.reference().child('temperature/value');
  final DatabaseReference heartRateRef =
      FirebaseDatabase.instance.reference().child('heartbeat/value');
  final DatabaseReference oxygenLevelRef =
      FirebaseDatabase.instance.reference().child('oxygen_level/value');
  final CollectionReference checkupsRef =
      FirebaseFirestore.instance.collection('bodycheckups');

  String temp = '';
  String heartRate = '';
  String oxygenLevel = '';
  String results = '';
  String advice = '';
  IconData resultIcon = Icons.check_circle_outline;
  Color resultColor = Colors.green;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _setUpListeners();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

  void sendRealTimeData() {
    databaseReference.child('control_sensor').set({'sensors': true});
    Future.delayed(Duration(seconds: 5), () {
      databaseReference.child('control_sensor').set({'sensors': false});
    });
  }

  void seeCheckup() async {
    try {
      final snapshot1 = await temperatureRef.get();
      final snapshot2 = await heartRateRef.get();
      final snapshot3 = await oxygenLevelRef.get();

      if (snapshot1.exists && snapshot2.exists && snapshot3.exists) {
        setState(() {
          temp = snapshot1.value.toString();
          heartRate = snapshot2.value.toString();
          oxygenLevel = snapshot3.value.toString();

          String tempStatus = _checkTemperatureStatus();
          String heartRateStatus = _checkHeartRateStatus();
          String oxygenLevelStatus = _checkOxygenLevelStatus();

          if (tempStatus == 'Not Normal' ||
              heartRateStatus == 'Not Normal' ||
              oxygenLevelStatus == 'Not Normal') {
            results = 'You have ';
            if (tempStatus == 'Not Normal') results += 'abnormal temperature, ';
            if (heartRateStatus == 'Not Normal')
              results += 'abnormal heart rate, ';
            if (oxygenLevelStatus == 'Not Normal')
              results += 'abnormal oxygen level';
            resultIcon = Icons.error_outline;
            resultColor = Colors.red;

            // Provide advice based on abnormal parameters
            advice = '';
            if (tempStatus == 'Not Normal') {
              advice +=
                  'You may be experiencing fever. Drink plenty of fluids and rest.\n';
            }
            if (heartRateStatus == 'Not Normal') {
              advice +=
                  'Your heart rate seems elevated. Consider reducing stress and avoiding caffeine.\n';
            }
            if (oxygenLevelStatus == 'Not Normal') {
              advice +=
                  'Low oxygen levels can be concerning. Seek medical attention immediately.';
            }
          } else {
            results = 'You are healthy! Keep up the good work.';
            resultIcon = Icons.check_circle_outline;
            resultColor = Colors.green;
            advice = ''; // Reset advice if everything is normal
          }
          _controller.forward();
        });
      } else {
        print('No data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void saveCheckup() async {
    try {
      final snapshot1 = await temperatureRef.get();
      final snapshot2 = await heartRateRef.get();
      final snapshot3 = await oxygenLevelRef.get();
      await checkupsRef.add({
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'date': DateTime.now(),
        'results': {
          'temperature': temp,
          'heartRate': heartRate,
          'oxygenLevel': oxygenLevel,
        },
        'notes': _checkTemperatureStatus() == 'Normal' &&
                _checkHeartRateStatus() == 'Normal' &&
                _checkOxygenLevelStatus() == 'Normal'
            ? 'You are healthy! Keep up the good work.'
            : 'Consult a doctor immediately.',
        'status': _checkTemperatureStatus() == 'Normal' &&
                _checkHeartRateStatus() == 'Normal' &&
                _checkOxygenLevelStatus() == 'Normal'
            ? 'Normal'
            : 'Abnormal',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Expanded(
                child: Text('Data saved successfully!'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SavedCheckupsPage()),
                  );
                },
                child: Text(
                  'View Saved Checkups',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error saving checkup: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save data. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _checkTemperatureStatus() {
    double temperature = double.parse(temp);
    if (temperature >= 36.1 && temperature <= 37.2) {
      return 'Normal';
    } else {
      return 'Not Normal';
    }
  }

  String _checkHeartRateStatus() {
    double rate = double.parse(heartRate);
    if (rate >= 60 && rate <= 100) {
      return 'Normal';
    } else {
      return 'Not Normal';
    }
  }

  String _checkOxygenLevelStatus() {
    double level = double.parse(oxygenLevel);
    if (level >= 95) {
      return 'Normal';
    } else {
      return 'Not Normal';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Text(
                    'Body Checkup',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Add functionality here
                    },
                    child: const Icon(
                      Icons.camera_alt_outlined,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Image.asset('assets/images/body.png', height: 30),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Check your body health quickly and easily with our AI-powered analysis',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const Text(
                'Place your hand on the sensors ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOut,
                            height: 200,
                            width: 250,
                            padding: const EdgeInsets.all(10),
                            child: VitalSignCard(
                              title: 'Heart Rate',
                              value: heartRate,
                              status: _checkHeartRateStatus(),
                              iconData: LineAwesomeIcons.heart,
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1),
                        Expanded(
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOut,
                            height: 200,
                            width: 250,
                            padding: const EdgeInsets.all(10),
                            child: VitalSignCard(
                              title: 'Temperature',
                              value: temp,
                              status: _checkTemperatureStatus(),
                              iconData: LineAwesomeIcons.thermometer,
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1),
                        Expanded(
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOut,
                            height: 200,
                            width: 250,
                            padding: const EdgeInsets.all(10),
                            child: VitalSignCard(
                              title: 'Oxygen Level',
                              value: oxygenLevel,
                              status: _checkOxygenLevelStatus(),
                              iconData: LineAwesomeIcons.heartbeat,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BoutonStyle(
                    text: 'Start Check Up',
                    onPressed: () {
                      sendRealTimeData();
                    },
                    color1: Color.fromARGB(255, 68, 255, 255),
                    color2: Color.fromARGB(255, 68, 255, 255),
                    color3: Color.fromARGB(255, 68, 255, 255),
                  ),
                  const SizedBox(width: 20),
                  BoutonStyle(
                    text: 'Check Up Results',
                    onPressed: () {
                      seeCheckup();
                    },
                    color1: Colors.blueAccent,
                    color2: Colors.blueAccent,
                    color3: Colors.blueAccent,
                  ),
                  const SizedBox(width: 20),
                  BoutonStyle(
                    text: 'Saved Checkups',
                    onPressed: () {
                      saveCheckup();
                    },
                    color1: Colors.indigo,
                    color2: Colors.indigo,
                    color3: Colors.indigo,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _animation,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Results',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Icon(
                        resultIcon,
                        color: resultColor,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _animation,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        results,
                        style: TextStyle(fontSize: 20, color: resultColor),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        advice,
                        style: TextStyle(fontSize: 15, color: resultColor),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

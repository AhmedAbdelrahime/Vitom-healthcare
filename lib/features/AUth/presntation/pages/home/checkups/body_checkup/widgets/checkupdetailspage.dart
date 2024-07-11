import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/core/Widgets/vitalsingcard.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CheckupDetailsPage extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  const CheckupDetailsPage({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String heartRate = documentSnapshot['results']['heartRate'];
    String temperature = documentSnapshot['results']['temperature'];
    String oxygenLevel = documentSnapshot['results']['oxygenLevel'];

    String tempStatus = _checkTemperatureStatus(temperature);
    String heartRateStatus = _checkHeartRateStatus(heartRate);
    String oxygenLevelStatus = _checkOxygenLevelStatus(oxygenLevel);

    String advice = '';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkup Details'),
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
                        // Heart Rate Card
                        Expanded(
                          child: Container(
                            height: 200,
                            width: 250,
                            padding: const EdgeInsets.all(10),
                            child: VitalSignCard(
                              title: 'Heart Rate',
                              value: heartRate,
                              status: heartRateStatus,
                              iconData: LineAwesomeIcons.heart,
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1),
                        // Temperature Card
                        Expanded(
                          child: Container(
                            height: 200,
                            width: 250,
                            padding: const EdgeInsets.all(10),
                            child: VitalSignCard(
                              title: 'Temperature',
                              value: temperature,
                              status: tempStatus,
                              iconData: LineAwesomeIcons.thermometer,
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1),
                        // Oxygen Level Card
                        Expanded(
                          child: Container(
                            height: 200,
                            width: 250,
                            padding: const EdgeInsets.all(10),
                            child: VitalSignCard(
                              title: 'Oxygen Level',
                              value: oxygenLevel,
                              status: oxygenLevelStatus,
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
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Results',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Icon(
                      tempStatus == 'Normal' &&
                              heartRateStatus == 'Normal' &&
                              oxygenLevelStatus == 'Normal'
                          ? LineAwesomeIcons.check_circle
                          : LineAwesomeIcons.times_circle,
                      color: tempStatus == 'Normal' &&
                              heartRateStatus == 'Normal' &&
                              oxygenLevelStatus == 'Normal'
                          ? Colors.green
                          : Colors.red,
                      size: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your body signs are ${tempStatus == 'Normal' && heartRateStatus == 'Normal' && oxygenLevelStatus == 'Normal' ? 'healthy' : 'not healthy'}!',
                      style: TextStyle(
                        fontSize: 20,
                        color: tempStatus == 'Normal' &&
                                heartRateStatus == 'Normal' &&
                                oxygenLevelStatus == 'Normal'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (tempStatus != 'Normal' ||
                        heartRateStatus != 'Normal' ||
                        oxygenLevelStatus != 'Normal')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Advice:',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            advice,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      )
                    else
                      const Text(
                        'You are healthy! Keep up the good work.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _checkTemperatureStatus(String temperature) {
    double temp = double.parse(temperature);
    if (temp >= 36.1 && temp <= 37.2) {
      return 'Normal';
    } else {
      return 'Not Normal';
    }
  }

  String _checkHeartRateStatus(String heartRate) {
    double rate = double.parse(heartRate);
    if (rate >= 60 && rate <= 100) {
      return 'Normal';
    } else {
      return 'Not Normal';
    }
  }

  String _checkOxygenLevelStatus(String oxygenLevel) {
    double level = double.parse(oxygenLevel);
    if (level >= 95) {
      return 'Normal';
    } else {
      return 'Not Normal';
    }
  }
}

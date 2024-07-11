import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/formheartrate/result.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeartAttackRiskForm extends StatefulWidget {
  @override
  _HeartAttackRiskFormState createState() => _HeartAttackRiskFormState();
}

class _HeartAttackRiskFormState extends State<HeartAttackRiskForm> {
  final _formKey = GlobalKey<FormState>();
  final _database = FirebaseDatabase.instance;

  final TextEditingController activeDaysController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();
  final TextEditingController cholesterolController = TextEditingController();
  final TextEditingController diastolicPressureController =
      TextEditingController();
  final TextEditingController exerciseHoursController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController sedentaryHoursController =
      TextEditingController();
  final TextEditingController sleepHoursController = TextEditingController();
  final TextEditingController stressLevelController = TextEditingController();
  final TextEditingController systolicPressureController =
      TextEditingController();
  final TextEditingController triglyceridesController = TextEditingController();

  String sex = "";
  String alcoholConsumption = "";
  String diabetes = "";
  String diet = "";
  String familyHistory = "";
  String medicationUse = "";
  String obesity = "";
  String previousHeartProblems = "";
  String smoking = "";

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, size: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    );
  }

  Widget _buildQuestion(String question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        question,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildGroupButton(List<String> options, Function(String) onSelected) {
    return GroupButton(
      buttons: options,
      onSelected: (value, index, isSelected) {
        onSelected(value);
      },
      options: GroupButtonOptions(
        selectedColor: Colors.blue,
        unselectedColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        buttonHeight: 40,
        buttonWidth: 100,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Heart Attack Risk Assessment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuestion('1. What is your sex? (Male/Female)'),
                _buildGroupButton(["Male", "Female"], (value) => sex = value),
                _buildQuestion('2. How old are you? '),
                TextFormField(
                  controller: ageController,
                  decoration:
                      _buildInputDecoration('Age', FontAwesomeIcons.user),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.parse(value) < 18 ||
                        int.parse(value) > 100) {
                      return 'Please enter a valid age between 18 and 100';
                    }
                    return null;
                  },
                ),
                _buildQuestion(
                    '3. Do you have a family history of heart disease?'),
                _buildGroupButton(
                    ["Yes", "No"], (value) => familyHistory = value),
                _buildQuestion('4. Have you ever had heart problems?'),
                _buildGroupButton(
                    ["Yes", "No"], (value) => previousHeartProblems = value),
                _buildQuestion('5. Do you smoke? '),
                _buildGroupButton(["Yes", "No"], (value) => smoking = value),
                _buildQuestion('6. Are you currently taking any medications? '),
                _buildGroupButton(
                    ["Yes", "No"], (value) => medicationUse = value),
                _buildQuestion('7. Do you have diabetes? '),
                _buildGroupButton(["Yes", "No"], (value) => diabetes = value),
                _buildQuestion('8. Are you obese? '),
                _buildGroupButton(["Yes", "No"], (value) => obesity = value),
                _buildQuestion('9. Do you consume alcohol? '),
                _buildGroupButton(
                    ["Yes", "No"], (value) => alcoholConsumption = value),
                _buildQuestion('10. How would you rate your diet? '),
                _buildGroupButton(["Healthy", "Average", "Unhealthy"],
                    (value) => diet = value),
                _buildQuestion('11. What is your cholesterol level? '),
                TextFormField(
                  controller: cholesterolController,
                  decoration: _buildInputDecoration(
                      'Cholesterol', FontAwesomeIcons.tachometerAlt),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.parse(value) <= 0) {
                      return 'Please enter a valid cholesterol level greater than 0';
                    }
                    return null;
                  },
                ),
                _buildQuestion('12. What is your Body Mass Index (BMI)? '),
                TextFormField(
                  controller: bmiController,
                  decoration:
                      _buildInputDecoration('BMI', FontAwesomeIcons.weight),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.tryParse(value) == null ||
                        double.parse(value) < 15 ||
                        double.parse(value) > 50) {
                      return 'Please enter a valid BMI between 15 and 50';
                    }
                    return null;
                  },
                ),
                _buildQuestion('13. What is your triglyceride level? '),
                TextFormField(
                  controller: triglyceridesController,
                  decoration: _buildInputDecoration(
                      'Triglycerides', FontAwesomeIcons.tachometerAlt),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.parse(value) <= 0) {
                      return 'Please enter a valid triglycerides level greater than 0';
                    }
                    return null;
                  },
                ),
                _buildQuestion(
                    '14. How many days a week are you physically active? '),
                TextFormField(
                  controller: activeDaysController,
                  decoration: _buildInputDecoration(
                      'Active Days/Week', FontAwesomeIcons.running),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.parse(value) < 0 ||
                        int.parse(value) > 7) {
                      return 'Please enter a valid number of active days per week between 0 and 7';
                    }
                    return null;
                  },
                ),
                _buildQuestion('15. How many hours do you sleep each day? '),
                TextFormField(
                  controller: sleepHoursController,
                  decoration: _buildInputDecoration(
                      'Sleep Hours/Day', FontAwesomeIcons.bed),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.tryParse(value) == null ||
                        double.parse(value) < 4 ||
                        double.parse(value) > 12) {
                      return 'Please enter a valid number of sleep hours per day between 4 and 12';
                    }
                    return null;
                  },
                ),
                _buildQuestion(
                    '16. How many hours do you spend sitting each day?'),
                TextFormField(
                  controller: sedentaryHoursController,
                  decoration: _buildInputDecoration(
                      'Sedentary Hours/Day', FontAwesomeIcons.couch),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.tryParse(value) == null ||
                        double.parse(value) < 0) {
                      return 'Please enter a valid number of sedentary hours per day ';
                    }
                    return null;
                  },
                ),
                _buildQuestion('17. What is your heart rate?'),
                TextFormField(
                  controller: heartRateController,
                  decoration: _buildInputDecoration(
                      'Heart Rate', FontAwesomeIcons.heartbeat),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.parse(value) <= 0) {
                      return 'Please enter a valid heart rate greater than 0';
                    }
                    return null;
                  },
                ),
                _buildQuestion('18. What is your systolic blood pressure? '),
                TextFormField(
                  controller: systolicPressureController,
                  decoration: _buildInputDecoration(
                      'Systolic Pressure', FontAwesomeIcons.heartbeat),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.parse(value) < 80 ||
                        int.parse(value) > 200) {
                      return 'Please enter a valid systolic pressure between 80 and 200 mmHg';
                    }
                    return null;
                  },
                ),
                _buildQuestion('19. What is your diastolic blood pressure? '),
                TextFormField(
                  controller: diastolicPressureController,
                  decoration: _buildInputDecoration(
                      'Diastolic Pressure', FontAwesomeIcons.heartbeat),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.parse(value) < 40 ||
                        int.parse(value) > 120) {
                      return 'Please enter a valid diastolic pressure between 40 and 120 mmHg';
                    }
                    return null;
                  },
                ),
                _buildQuestion('20. What is your income? '),
                TextFormField(
                  controller: incomeController,
                  decoration: _buildInputDecoration(
                      'Income', FontAwesomeIcons.dollarSign),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.tryParse(value) == null ||
                        double.parse(value) < 0) {
                      return 'Please enter a valid income';
                    }
                    return null;
                  },
                ),
                _buildQuestion('21. How stressed are you?'),
                TextFormField(
                  controller: stressLevelController,
                  decoration: _buildInputDecoration(
                      'Stress Level', FontAwesomeIcons.exclamationTriangle),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.parse(value) < 0 ||
                        int.parse(value) > 10) {
                      return 'Please enter a valid stress level between 0 and 10';
                    }
                    return null;
                  },
                ),
                _buildQuestion('22. How many hours do you exercise each week?'),
                TextFormField(
                  controller: exerciseHoursController,
                  decoration: _buildInputDecoration(
                      'Exercise Hours/Week', FontAwesomeIcons.dumbbell),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.tryParse(value) == null ||
                        double.parse(value) < 0) {
                      return 'Please enter a valid number of exercise hours per week';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final Map<String, dynamic> data = {
                        'actvie_d_week': int.parse(activeDaysController.text),
                        'age': int.parse(ageController.text),
                        'bmi': int.parse(bmiController.text),
                        'cholesterol': int.parse(cholesterolController.text),
                        'diastolic_pressure':
                            int.parse(diastolicPressureController.text),
                        'excersise_h_week':
                            double.parse(exerciseHoursController.text),
                        'heart_rate': int.parse(heartRateController.text),
                        'income': double.parse(incomeController.text),
                        'sedentary_h_day':
                            double.parse(sedentaryHoursController.text),
                        'sleep_h_day': double.parse(sleepHoursController.text),
                        'stress_level': int.parse(stressLevelController.text),
                        'systolic_pressure':
                            int.parse(systolicPressureController.text),
                        'triglycerides':
                            int.parse(triglyceridesController.text),
                        'sex': sex,
                        'alcohol_consumption': alcoholConsumption,
                        'diabetes': diabetes,
                        'diet': diet,
                        'family_history': familyHistory,
                        'medication_use': medicationUse,
                        'obesity': obesity,
                        'previous_heart_problems': previousHeartProblems,
                        'smoking': smoking,
                      };
                      try {
                        await _database.reference().child('HR').set(1);

                        await _database
                            .reference()
                            .child('heart_attack')
                            .set(data);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Data saved successfully'),
                          ),
                        );

                        // Wait for 5 seconds
                        await Future.delayed(const Duration(seconds: 10));
                        await _database.reference().child('HR').set(0);

                        // Navigate to the result page
                        Get.to(() => ResultPage(),
                            arguments: data, preventDuplicates: true);
                      } catch (e) {
                        // Handle any errors that occur during saving
                        print('Error saving data: $e');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  icon: Icon(
                    Icons.send,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

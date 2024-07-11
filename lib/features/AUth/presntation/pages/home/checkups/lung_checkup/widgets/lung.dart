import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complex_ui_rive_animation/core/constans.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/body_checkup/widgets/svaed.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/core/Widgets/bouttonstyle.dart';

class LungCheckupBody extends StatefulWidget {
  const LungCheckupBody({super.key});

  @override
  State<LungCheckupBody> createState() => LungCheckupBodyState();
}

class LungCheckupBodyState extends State<LungCheckupBody> {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();

  // final DatabaseReference _atelectasisRef =
  //     FirebaseDatabase.instance.ref().child('Module/Report/Atelectasis/value');
  // final DatabaseReference _cardiomegalyref =
  //     FirebaseDatabase.instance.ref().child('Module/Report/Cardiomegaly/value');

  final DatabaseReference _atelectasisRef =
      FirebaseDatabase.instance.ref().child('Module/Report/Atelectasis/value');

  final DatabaseReference _cardiomegalyRef =
      FirebaseDatabase.instance.ref().child('Module/Report/Cardiomegaly/value');

  final DatabaseReference _consolidationRef = FirebaseDatabase.instance
      .ref()
      .child('Module/Report/Consolidation/value');

  final DatabaseReference _edemaRef =
      FirebaseDatabase.instance.ref().child('Module/Report/Edema/value');

  final DatabaseReference _effusionRef =
      FirebaseDatabase.instance.ref().child('Module/Report/Effusion/value');

  final DatabaseReference _emphysemaRef =
      FirebaseDatabase.instance.ref().child('Module/Report/Emphysema/value');

  final DatabaseReference _fibrosisRef =
      FirebaseDatabase.instance.ref().child('Module/Report/Fibrosis/value');

  final DatabaseReference _herniaRef =
      FirebaseDatabase.instance.ref().child('Module/Report/Hernia/value');

  final DatabaseReference _infiltrationRef =
      FirebaseDatabase.instance.ref().child('Module/Report/Infiltration/value');

  final DatabaseReference _massRef =
      FirebaseDatabase.instance.ref().child('Module/Report/Mass/value');

  final DatabaseReference _noduleRef =
      FirebaseDatabase.instance.ref().child('Module/Report/Nodule/value');

  final DatabaseReference _pleuralThickeningRef = FirebaseDatabase.instance
      .ref()
      .child('Module/Report/Pleural_Thickening/value');

  final DatabaseReference _pneumoniaRef =
      FirebaseDatabase.instance.ref().child('Module/Report/Pneumonia/value');

  final DatabaseReference _pneumothoraxRef =
      FirebaseDatabase.instance.ref().child('Module/Report/Pneumothorax/value');

  final firebase_storage.Reference lungStorageRef =
      firebase_storage.FirebaseStorage.instance.ref().child('image.jpg');
  final firebase_storage.Reference defultStorageRef =
      firebase_storage.FirebaseStorage.instance.ref().child('defult.jpg');

  CollectionReference checkupsRef =
      FirebaseFirestore.instance.collection('lungcheckups');

  String results = ' ';
  String advice = ' ';

  String atelectasis = '';
  String cardiomegaly = '';
  String consolidation = '';
  String edema = '';
  String effusion = '';
  String emphysema = '';
  String fibrosis = '';
  String hernia = '';
  String infiltration = '';
  String mass = '';
  String nodule = '';
  String pleuralThickening = '';
  String pneumonia = '';
  String pneumothorax = '';

  bool isImageTaken = false;
  IconData resultIcon = Icons.check_circle_outline;
  Color resultColor = Colors.green;
  bool isLoading = false;
  bool showDefaultImage = true;

  void loadImage() {
    setState(() {
      isLoading = true;
      showDefaultImage = true;
    });

    Timer(Duration(seconds: 50), () {
      setState(() {
        showDefaultImage = false;
        isLoading = false;
      });
    });
  }

  Future<String?> copyImageAndReturnUrl() async {
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;

      // Get the reference to the original image.jpg
      final firebase_storage.Reference originalImageRef =
          firebase_storage.FirebaseStorage.instance.ref().child('image.jpg');

      // Download the original image to a temporary file
      final Directory systemTempDir = await getTemporaryDirectory();
      final String tempFilePath = '${systemTempDir.path}/image.jpg';
      await originalImageRef.writeToFile(File(tempFilePath));

      // Get the reference to the destination folder with the user's ID
      final firebase_storage.Reference userImageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('user_images/$userId/image.jpg');

      // Upload the image.jpg to the destination folder
      await userImageRef.putFile(File(tempFilePath));

      // Get the download URL of the copied image
      final String downloadUrl = await userImageRef.getDownloadURL();

      return downloadUrl;
    } catch (error) {
      print('Error copying image and getting URL: $error');
      return null;
    }
  }

  void sendRealTimeData() {
    databaseReference.child('control_node').set({'run_capture': true});

    Future.delayed(Duration(seconds: 5), () {
      databaseReference.child('control_node').set({'run_capture': false});
    });
  }

  void seeCheckup() async {
    try {
      // Fetch data from Firebase Realtime Database
      final snapshot1 = await _atelectasisRef.get();
      final snapshot2 = await _cardiomegalyRef.get();
      final snapshot3 = await _consolidationRef.get();
      final snapshot4 = await _edemaRef.get();
      final snapshot5 = await _effusionRef.get();
      final snapshot6 = await _emphysemaRef.get();
      final snapshot7 = await _fibrosisRef.get();
      final snapshot8 = await _herniaRef.get();
      final snapshot9 = await _infiltrationRef.get();
      final snapshot10 = await _massRef.get();
      final snapshot11 = await _noduleRef.get();
      final snapshot12 = await _pleuralThickeningRef.get();
      final snapshot13 = await _pneumoniaRef.get();
      final snapshot14 = await _pneumothoraxRef.get();

      // Check if all snapshots exist
      if (snapshot1.exists &&
          snapshot2.exists &&
          snapshot3.exists &&
          snapshot4.exists &&
          snapshot5.exists &&
          snapshot6.exists &&
          snapshot7.exists &&
          snapshot8.exists &&
          snapshot9.exists &&
          snapshot10.exists &&
          snapshot11.exists &&
          snapshot12.exists &&
          snapshot13.exists &&
          snapshot14.exists) {
        setState(() {
          // Assign values from snapshots to variables
          atelectasis = snapshot1.value.toString();
          cardiomegaly = snapshot2.value.toString();
          consolidation = snapshot3.value.toString();
          edema = snapshot4.value.toString();
          effusion = snapshot5.value.toString();
          emphysema = snapshot6.value.toString();
          fibrosis = snapshot7.value.toString();
          hernia = snapshot8.value.toString();
          infiltration = snapshot9.value.toString();
          mass = snapshot10.value.toString();
          nodule = snapshot11.value.toString();
          pleuralThickening = snapshot12.value.toString();
          pneumonia = snapshot13.value.toString();
          pneumothorax = snapshot14.value.toString();

          // Check if the patient has any condition
          if (atelectasis == '1' ||
              cardiomegaly == '1' ||
              consolidation == '1' ||
              edema == '1' ||
              effusion == '1' ||
              emphysema == '1' ||
              fibrosis == '1' ||
              hernia == '1' ||
              infiltration == '1' ||
              mass == '1' ||
              nodule == '1' ||
              pleuralThickening == '1' ||
              pneumonia == '1' ||
              pneumothorax == '1') {
            results = 'You may have ';
            if (atelectasis == '1') results += 'Atelectasis, ';
            if (cardiomegaly == '1') results += 'Cardiomegaly, ';
            if (consolidation == '1') results += 'Consolidation, ';
            if (edema == '1') results += 'Edema, ';
            if (effusion == '1') results += 'Effusion, ';
            if (emphysema == '1') results += 'Emphysema, ';
            if (fibrosis == '1') results += 'Fibrosis, ';
            if (hernia == '1') results += 'Hernia, ';
            if (infiltration == '1') results += 'Infiltration, ';
            if (mass == '1') results += 'Mass, ';
            if (nodule == '1') results += 'Nodule, ';
            if (pleuralThickening == '1') results += 'Pleural Thickening, ';
            if (pneumonia == '1') results += 'Pneumonia, ';
            if (pneumothorax == '1') results += 'Pneumothorax, ';
            results = results.substring(
                0, results.length - 2); // Remove the last comma and space
            resultIcon = Icons.error_outline;
            resultColor = Colors.red;

            if (atelectasis == '1') {
              advice =
                  "Advice for Atelectasis: Seek medical attention for proper evaluation and treatment. Follow your doctor's recommendations closely.";
            }
            if (cardiomegaly == '1') {
              advice +=
                  "\nAdvice for Cardiomegaly: Follow your doctor's advice on lifestyle changes, such as diet and exercise, and take medications as prescribed. Regularly monitor your heart health.";
            }
            if (consolidation == '1') {
              advice +=
                  "\nAdvice for Consolidation: Seek medical attention for proper evaluation and treatment. Follow your doctor's recommendations closely, which may include rest, antibiotics, or other interventions.";
            }
            if (edema == '1') {
              advice +=
                  "\nAdvice for Edema: Elevate affected limbs, follow a low-sodium diet, and take prescribed medications as directed by your doctor. Seek medical attention if you notice worsening symptoms or new symptoms develop.";
            }
            if (effusion == '1') {
              advice +=
                  "\nAdvice for Effusion: Follow your doctor's recommendations, which may include rest, medications, or drainage procedures to relieve fluid buildup. Monitor for any changes in symptoms and seek medical attention as needed.";
            }
            if (emphysema == '1') {
              advice +=
                  "\nAdvice for Emphysema: Quit smoking if you smoke, avoid exposure to lung irritants, and follow your doctor's advice on medications and pulmonary rehabilitation programs. Monitor your lung function regularly and seek medical attention for any worsening symptoms.";
            }
            if (fibrosis == '1') {
              advice +=
                  "\nAdvice for Fibrosis: Follow your doctor's recommendations for managing symptoms and slowing disease progression, which may include medications, oxygen therapy, and pulmonary rehabilitation. Avoid exposure to lung irritants and get regular check-ups with your healthcare provider.";
            }
            if (hernia == '1') {
              advice =
                  "\nAdvice for Hernia: Follow your doctor's recommendations for managing symptoms, which may include lifestyle changes, hernia belts, or surgery. Avoid heavy lifting and straining, and seek medical attention if you experience sudden severe pain or other concerning symptoms.";
            }
            if (infiltration == '1') {
              advice +=
                  "\nAdvice for Infiltration: Seek medical attention for proper evaluation and treatment of the underlying cause, which may include infections, inflammation, or tumors. Follow your doctor's recommendations closely and monitor for any changes in symptoms.";
            }
            if (mass == '1') {
              advice +=
                  "\nAdvice for Mass: Seek medical attention for further evaluation and treatment of the underlying cause, which may include imaging studies, biopsies, or surgical interventions. Follow your doctor's recommendations closely and monitor for any changes in symptoms.";
            }
            if (nodule == '1') {
              advice +=
                  "\nAdvice for Nodule: Follow up with your doctor for further evaluation and monitoring, especially if you have risk factors for lung cancer. Your doctor may recommend additional imaging studies, biopsies, or surveillance based on the characteristics of the nodule.";
            }
            if (pleuralThickening == '1') {
              advice +=
                  "\nAdvice for Pleural Thickening: Follow up with your doctor for further evaluation and monitoring, as pleural thickening can be associated with various underlying conditions. Your doctor may recommend additional imaging studies or procedures based on the severity and cause of the thickening.";
            }
            if (pneumonia == '1') {
              advice +=
                  "\nAdvice for Pneumonia: Follow your doctor's recommendations for rest, hydration, and prescribed medications, which may include antibiotics or antiviral drugs. Seek medical attention if your symptoms worsen or if you have difficulty breathing.";
            }
            if (pneumothorax == '1') {
              advice +=
                  "\nAdvice for Pneumothorax: Seek immediate medical attention if you experience sudden chest pain and difficulty breathing, as pneumothorax can be a medical emergency. Treatment may include chest tube insertion or surgery to re-expand the collapsed lung.";
            }
          } else {
            results = 'You are healthy';
            resultIcon = Icons.check_circle_outline;
            resultColor = Colors.green;
            advice = ''; // Reset advice if everything is normal
          }
        });
      } else {
        // If any data is missing
        print('Some data is missing');
      }
    } catch (error) {
      // Handle error if any
      print('Error fetching data: $error');
    }
  }

  void saveCheckup() async {
    try {
      // Fetch data from Firebase Realtime Database
      final snapshot1 = await _atelectasisRef.get();
      final snapshot2 = await _cardiomegalyRef.get();
      final snapshot3 = await _consolidationRef.get();
      final snapshot4 = await _edemaRef.get();
      final snapshot5 = await _effusionRef.get();
      final snapshot6 = await _emphysemaRef.get();
      final snapshot7 = await _fibrosisRef.get();
      final snapshot8 = await _herniaRef.get();
      final snapshot9 = await _infiltrationRef.get();
      final snapshot10 = await _massRef.get();
      final snapshot11 = await _noduleRef.get();
      final snapshot12 = await _pleuralThickeningRef.get();
      final snapshot13 = await _pneumoniaRef.get();
      final snapshot14 = await _pneumothoraxRef.get();
      await checkupsRef.add({
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'date': DateTime.now(),
        'results': {
          'atelectasis': snapshot1.value.toString(),
          'cardiomegaly': snapshot2.value.toString(),
          'consolidation': snapshot3.value.toString(),
          'edema': snapshot4.value.toString(),
          'effusion': snapshot5.value.toString(),
          'emphysema': snapshot6.value.toString(),
          'fibrosis': snapshot7.value.toString(),
          'hernia': snapshot8.value.toString(),
          'infiltration': snapshot9.value.toString(),
          'mass': snapshot10.value.toString(),
          'nodule': snapshot11.value.toString(),
          'pleuralThickening': snapshot12.value.toString(),
          'pneumonia': snapshot13.value.toString(),
          'pneumothorax': snapshot14.value.toString(),
        }
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text(
                  'Lung Checkup',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                const SizedBox(width: 20),
                Image.asset('assets/images/lung.png', height: 30),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Check your lung health with our AI-powered analysis',
              style: TextStyle(fontSize: 17, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const Text(
              'Put your lungs X-rays here to get started!',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
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
              child: isLoading
                  ? CircularProgressIndicator()
                  : showDefaultImage
                      ? FutureBuilder(
                          future: defultStorageRef.getDownloadURL(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Image.network(
                                snapshot.data ?? '',
                                fit: BoxFit.fill,
                              );
                            }
                          },
                        )
                      : FutureBuilder(
                          future: lungStorageRef.getDownloadURL(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Image.network(
                                snapshot.data ?? '',
                                fit: BoxFit.fill,
                              );
                            }
                          },
                        ),
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoutonStyle(
                  text: 'captur x-ray ',
                  onPressed: () {
                    sendRealTimeData();
                    loadImage();
                  },
                  color1: Colors.amber.shade700,
                  color2: Colors.amber.shade700,
                  color3: Colors.amber.shade700,
                ),
                const SizedBox(width: 20),
                BoutonStyle(
                  text: 'Check Up Now',
                  onPressed: () {
                    seeCheckup();
                  },
                  color1: Colors.blueAccent.shade700,
                  color2: Colors.blueAccent.shade700,
                  color3: Colors.blueAccent.shade700,
                ),
                const SizedBox(width: 20),
                BoutonStyle(
                  color1: Colors.black,
                  text: 'Saved cheukpes ',
                  onPressed: () {
                    seeCheckup();
                    saveCheckup();
                  },
                  color2: Colors.greenAccent,
                  color3: Colors.greenAccent,
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Results',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(
                  resultIcon,
                  color: resultColor,
                  size: 30,
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              results,
              style: TextStyle(
                  fontSize: 20,
                  color: resultColor,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(
              advice,
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

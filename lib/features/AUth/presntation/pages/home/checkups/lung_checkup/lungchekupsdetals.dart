import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/core/Widgets/vitalsingcard.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class LungCheckupDetailsPage extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  const LungCheckupDetailsPage({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract disease data from documentSnapshot
    String atelectasis = documentSnapshot['results']['atelectasis'].toString();
    String cardiomegaly =
        documentSnapshot['results']['cardiomegaly'].toString();

    String consolidation =
        documentSnapshot['results']['consolidation'].toString();
    String edema = documentSnapshot['results']['edema'].toString();
    String effusion = documentSnapshot['results']['effusion'].toString();
    String emphysema = documentSnapshot['results']['emphysema'].toString();
    String fibrosis = documentSnapshot['results']['fibrosis'].toString();
    String hernia = documentSnapshot['results']['hernia'].toString();
    String infiltration =
        documentSnapshot['results']['infiltration'].toString();
    String mass = documentSnapshot['results']['mass'].toString();
    String nodule = documentSnapshot['results']['nodule'].toString();
    String pleuralThickening =
        documentSnapshot['results']['pleuralThickening'].toString();
    String pneumonia = documentSnapshot['results']['pneumonia'].toString();
    String pneumothorax =
        documentSnapshot['results']['pneumothorax'].toString();

    // Determine results based on disease data
    String results;
    IconData resultIcon;
    Color resultColor;
    String advice = ' ';

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
      results = 'You have ';
      if (atelectasis == '1') results += 'atelectasis, ';
      if (cardiomegaly == '1') results += 'cardiomegaly, ';
      if (consolidation == '1') results += 'consolidation, ';
      if (edema == '1') results += 'edema, ';
      if (effusion == '1') results += 'effusion, ';
      if (emphysema == '1') results += 'emphysema, ';
      if (fibrosis == '1') results += 'fibrosis, ';
      if (hernia == '1') results += 'hernia, ';
      if (infiltration == '1') results += 'infiltration, ';
      if (mass == '1') results += 'mass, ';
      if (nodule == '1') results += 'nodule, ';
      if (pleuralThickening == '1') results += 'pleural thickening, ';
      if (pneumonia == '1') results += 'pneumonia, ';
      if (pneumothorax == '1') results += 'pneumothorax, ';
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
        advice =
            "\nAdvice for Pneumothorax: Seek immediate medical attention if you experience sudden chest pain and difficulty breathing, as pneumothorax can be a medical emergency. Treatment may include chest tube insertion or surgery to re-expand the collapsed lung.";
      }
    } else {
      results = 'You are healthy';
      resultIcon = Icons.check_circle_outline;
      resultColor = Colors.green;
      advice = ''; // Reset advice if everything is normal
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkup lung Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    'Lung Checkup',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Add functionality here
                    },
                    child: Icon(
                      Icons.camera_alt_outlined,
                    ),
                  ),
                  SizedBox(width: 20),
                  // Image.asset('assets/images/body.png', height: 30),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Check your body health quickly and easily with our AI-powered analysis',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Text(
                'this is Saved checkup Page  ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        const SizedBox(width: 20),
                        Image.asset('assets/images/lung.png', height: 30),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    const Text(
                      'Put your lungs X-rays here to get started!',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
                      child: Image.asset(
                        'assets/images/example.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Results',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        resultIcon,
                        color: resultColor,
                        size: 30,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        results,
                        style: TextStyle(
                          fontSize: 16,
                          color: resultColor,
                        ),
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
                ],
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

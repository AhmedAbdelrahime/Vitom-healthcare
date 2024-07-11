import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/models/medical_case.dart';
import 'package:flutter/material.dart';

class MedicalCaseDetailScreen extends StatelessWidget {
  final MedicalCase medicalCase;

  MedicalCaseDetailScreen(this.medicalCase);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicalCase.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                medicalCase.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text(
                medicalCase.history,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Symptoms:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (var symptom in medicalCase.symptoms)
                Text('• $symptom', style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text(
                'Diagnostic Tests:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (var test in medicalCase.diagnosticTests)
                Text('• $test', style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text(
                'Your Diagnosis:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your diagnosis',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Actual Diagnosis'),
                      content: Text(medicalCase.diagnosis),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Check Diagnosis'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

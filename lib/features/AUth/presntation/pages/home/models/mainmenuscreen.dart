import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/models/medical_case_studies_screen.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/quiz/quezescreen.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/simulationsystem/simulations_screen.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.article, color: Colors.blue, size: 40),
            title: Text(
              'Medical Case Studies',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Explore real-world medical cases'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MedicalCaseStudiesScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer, color: Colors.green, size: 40),
            title: Text(
              'Quizzes and Assessments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Test your medical knowledge'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizzesScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.videogame_asset, color: Colors.red, size: 40),
            title: Text(
              'Simulations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Interactive medical simulations'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => SimulationsScreen(simulations: [],)),
              // );
            },
          ),
        ],
      ),
    );
  }
}

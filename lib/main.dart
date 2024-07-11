import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/homepage/home.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/animated_app/screens/on_boardibg/on_boarding_screen.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/chatbot/consts.dart';
import 'package:complex_ui_rive_animation/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  Gemini.init(
    apiKey: GEMINI_API_KEY,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
             
              return RiveAppHome();
             
            } else if (snapshot.hasError) {
              // If there's an error, show error message
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return OnbodingScreen();

              //  return OnbodingScreen();
              //Loginview();
            }
          }
          // Show a loading spinner while waiting for connection state
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

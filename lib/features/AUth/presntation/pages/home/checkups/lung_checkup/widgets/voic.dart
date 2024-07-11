// import 'package:speech_recognition/speech_recognition.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// void voiceCommand() {
//   SpeechRecognition recognizer = SpeechRecognition();
//   FlutterTts engine = FlutterTts();

//   recognizer.listen(
//     onResult: (SpeechRecognitionResult result) {
//       String command = result.recognizedWords.toLowerCase();
//       print("You said: $command");

//       if (command.contains("hi eddie")) {
//         String response = "Hi I am eddie, your robot assistant. What is your name?";
//         print("eddie: $response");
//         engine.speak(response);

//         String userInput = stdin.readLineSync()!;
//         String userResponse = "Hi $userInput. If you want to check your vitals, please continue with the app in front of you.";
//         print("eddie: $userResponse");
//         engine.speak(userResponse);

//         String userId = stdin.readLineSync()!;
//         String userResponse2 = "Okay $userInput. What are you suffering from?";
//         print("eddie: $userResponse2");
//         engine.speak(userResponse2);
//       } else {
//         String response2 = "I'm sorry, I didn't understand the command.";
//         print("eddie: $response2");
//         engine.speak(response2);

//       }
//     },
//     onError: (SpeechRecognitionError error) {
//       print("eddie: Sorry, I couldn't understand your voice.");
//     },
//   );

//   recognizer.activate().then((_) {
//     recognizer.listen(locale: "en_US");
//   });
// }

// voiceCommand();


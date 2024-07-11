import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
          backgroundColor: Colors.blue, // Google blue color
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/scu.jpg'),
                SizedBox(height: 16.0),
                Text(
                  'Suez Canal University',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Image.asset('assets/eccat.jpg'),
                SizedBox(height: 16.0),

                Text(
                  'Egyptian Chinese College for Applied Technology',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600], // Google grey color
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Supervisors',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Ahmed Salem\nAhmed Magdy\nZakaria Hassan\nEmad Badry\nNariman Abdo',
                  style: TextStyle(
                    color: Colors.grey[600], // Google grey color
                  ),
                ),
                SizedBox(height: 16.0),
                Image.asset('assets/logorobot.webp'),
                SizedBox(height: 16.0),
                Text(
                  'Everything you need to know about VitoM robot.',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'The convergence of Artificial Intelligence, robotics, electronics, and mobile app development within three departments has given rise to a groundbreaking solution for healthcare. This innovative system specializes in diagnosis, prediction, and detection through advanced analysis of medical images and records, specifically catering to patients with Cardiovascular Diseases (CVD) or Pulmonary problems. Furthermore, it incorporates an educational platform designed to enhance the productivity and knowledge of medical students and healthcare professionals. By leveraging cutting-edge technologies, this comprehensive solution aims to revolutionize the healthcare industry by providing accurate diagnoses, improving patient outcomes, and empowering healthcare professionals with the latest insights and expertise.',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600], // Google grey color
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'What VitoM Do',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Here is a detailed functions for our Robot',
                  style: TextStyle(
                    color: Colors.grey[600], // Google grey color
                  ),
                ),
                SizedBox(height: 16.0),
                Image.asset('assets/heart_rate.webp'),
                SizedBox(height: 16.0),
                Text(
                  'Heart disease prediction',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Our cutting-edge algorithms assess your unique risk factors and predict potential heart problems before they develop.',
                  style: TextStyle(
                    color: Colors.grey[600], // Google grey color
                  ),
                ),
                SizedBox(height: 16.0),
                Image.asset('assets/vitom_app.webp'),
                SizedBox(height: 16.0),
                Text(
                  'VitoM application',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Manage your health on the go with our personalized mobile app. Track vitals, schedule appointments, and access educational resources - all in one convenient place.',
                  style: TextStyle(
                    color: Colors.grey[600], // Google grey color
                  ),
                ),
                SizedBox(height: 16.0),
                Image.asset('assets/lung_diseases_detection.webp'),
                SizedBox(height: 16.0),
                Text(
                  'Lung diseases detection',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Leverage the power of AI-driven analysis to identify potential lung issues early on.',
                  style: TextStyle(
                    color: Colors.grey[600], // Google grey color
                  ),
                ),
                SizedBox(height: 16.0),
                Image.asset('assets/medical_chatbot.webp'),
                SizedBox(height: 16.0),
                Text(
                  'Medical Chatpot',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Get access to a friendly and informative AI assistant. Ask questions, receive symptom guidance, and gain valuable insights about your health.',
                  style: TextStyle(
                    color: Colors.grey[600], // Google grey color
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Features',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Every Great Technological Advancement Brings Its Own Challenges!, this is what we Overcome 🙌',
                  style: TextStyle(
                    color: Colors.grey[600], // Google grey color
                  ),
                ),
                SizedBox(height: 16.0),
                Image.asset('assets/robot_assetance.webp'),
                SizedBox(height: 16.0),
                Text(
                  'Mobile Robotic Assistance',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Our advanced robotics technology brings healthcare services directly to your doorstep. Seamlessly integrating with our platform, these mobile robots navigate with precision, delivering vital medical assistance wherever you are.',
                  style: TextStyle(
                    color: Colors.grey[600], // Google grey color
                  ),
                ),
                SizedBox(height: 16.0),
                Image.asset('assets/trust.webp'),
                SizedBox(height: 16.0),
                Text(
                  'Diagnoses You Can Trust',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Leveraging cutting-edge AI and robotics, VitoM delivers unparalleled accuracy in diagnoses, empowering healthcare professionals to make the most informed decisions.',
                  style: TextStyle(
                    color: Colors.grey[600], // Google grey color
                  ),
                ),
                SizedBox(height: 16.0),
                Image.asset('assets/sec_data.webp'),
                SizedBox(height: 16.0),
                Text(
                  'Secure Data',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'VitoM prioritizes patient privacy. Our robust security measures ensure your health information remains completely safe and protected.',
                  style: TextStyle(
                    color: Colors.grey[600], // Google grey color
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  ' this app created by Application  team',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[600], // Google grey color
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),

                SizedBox(height: 16.0),

                SizedBox(height: 16.0),
                // Add more team members similarly
                SizedBox(height: 16.0),

                SizedBox(height: 8.0),

                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

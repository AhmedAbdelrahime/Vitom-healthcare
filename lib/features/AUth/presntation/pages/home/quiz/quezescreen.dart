import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/quiz/quizemodel.dart';
import 'package:flutter/material.dart';

class QuizzesScreen extends StatefulWidget {
  @override
  _QuizzesScreenState createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool showResult = false;

  final List<Question> questions = [
    Question(
      questionText: 'What is the normal range for adult body temperature?',
      options: ['35.5-37.5°C', '36.5-37.5°C', '37.5-38.5°C', '35.0-36.0°C'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'Which organ is primarily affected by hepatitis?',
      options: ['Heart', 'Liver', 'Kidney', 'Lung'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'What is the most common type of cancer in women?',
      options: [
        'Lung Cancer',
        'Breast Cancer',
        'Ovarian Cancer',
        'Skin Cancer'
      ],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'What is the primary function of red blood cells?',
      options: [
        'Transport oxygen',
        'Fight infections',
        'Clot blood',
        'Produce hormones'
      ],
      correctOptionIndex: 0,
    ),
    Question(
      questionText: 'Which vitamin is essential for blood clotting?',
      options: ['Vitamin A', 'Vitamin B12', 'Vitamin K', 'Vitamin D'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'What is the leading cause of death worldwide?',
      options: [
        'Cancer',
        'Heart disease',
        'Diabetes',
        'Respiratory infections'
      ],
      correctOptionIndex: 1,
    ),
    Question(
      questionText:
          'Which part of the brain controls balance and coordination?',
      options: ['Cerebrum', 'Cerebellum', 'Brainstem', 'Hypothalamus'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'What is the medical term for high blood pressure?',
      options: ['Hypotension', 'Hypertension', 'Hyperglycemia', 'Hypoglycemia'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'Which of the following is a symptom of diabetes?',
      options: ['Blurred vision', 'Hearing loss', 'Hair loss', 'Nausea'],
      correctOptionIndex: 0,
    ),
    Question(
      questionText: 'What is the main function of the kidneys?',
      options: [
        'Regulate metabolism',
        'Filter blood',
        'Store nutrients',
        'Produce enzymes'
      ],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'Which disease is caused by a deficiency of Vitamin C?',
      options: ['Rickets', 'Scurvy', 'Pellagra', 'Beriberi'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'What is the average gestation period for humans?',
      options: ['30 weeks', '32 weeks', '36 weeks', '40 weeks'],
      correctOptionIndex: 3,
    ),
    Question(
      questionText:
          'Which condition is characterized by inflammation of the joints?',
      options: ['Osteoporosis', 'Arthritis', 'Myopathy', 'Neuropathy'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'What is the primary component of the human brain?',
      options: ['Fat', 'Protein', 'Water', 'Carbohydrates'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'Which hormone regulates blood sugar levels?',
      options: ['Adrenaline', 'Cortisol', 'Insulin', 'Glucagon'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText:
          'Which part of the eye is responsible for vision in low light?',
      options: ['Retina', 'Iris', 'Cornea', 'Lens'],
      correctOptionIndex: 0,
    ),
    Question(
      questionText: 'Which blood type is known as the universal donor?',
      options: ['A', 'B', 'AB', 'O'],
      correctOptionIndex: 3,
    ),
    Question(
      questionText: 'What is the medical term for the voice box?',
      options: ['Pharynx', 'Larynx', 'Esophagus', 'Trachea'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'Which organ produces insulin?',
      options: ['Liver', 'Pancreas', 'Kidney', 'Stomach'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'What is the largest organ of the human body?',
      options: ['Liver', 'Skin', 'Lung', 'Heart'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'Which condition is known as "silent killer"?',
      options: ['Diabetes', 'Hypertension', 'Cancer', 'Asthma'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'What is the term for low blood sugar levels?',
      options: ['Hyperglycemia', 'Hypoglycemia', 'Hypertension', 'Hypotension'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText:
          'Which vitamin is produced when the skin is exposed to sunlight?',
      options: ['Vitamin A', 'Vitamin B', 'Vitamin C', 'Vitamin D'],
      correctOptionIndex: 3,
    ),
    Question(
      questionText: 'Which disease is also known as "lockjaw"?',
      options: ['Rabies', 'Tetanus', 'Polio', 'Meningitis'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'What is the normal range for adult respiratory rate?',
      options: [
        '10-20 breaths per minute',
        '12-16 breaths per minute',
        '16-24 breaths per minute',
        '20-30 breaths per minute'
      ],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'Which substance in tobacco smoke causes addiction?',
      options: ['Tar', 'Nicotine', 'Carbon monoxide', 'Ammonia'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'What is the first part of the digestive system?',
      options: ['Stomach', 'Esophagus', 'Mouth', 'Small intestine'],
      correctOptionIndex: 3,
    ),
    Question(
      questionText: 'Which blood vessels carry oxygenated blood?',
      options: ['Arteries', 'Veins', 'Capillaries', 'Venules'],
      correctOptionIndex: 0,
    ),
    Question(
      questionText: 'What is the main cause of peptic ulcers?',
      options: ['Spicy food', 'Helicobacter pylori', 'Stress', 'Alcohol'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText:
          'Which part of the cell is responsible for generating energy?',
      options: ['Nucleus', 'Ribosome', 'Mitochondria', 'Golgi apparatus'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'What is the term for inflammation of the liver?',
      options: ['Hepatitis', 'Nephritis', 'Gastritis', 'Dermatitis'],
      correctOptionIndex: 0,
    ),
    Question(
      questionText:
          'Which mineral is essential for the formation of hemoglobin?',
      options: ['Calcium', 'Magnesium', 'Iron', 'Zinc'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'What is the primary function of white blood cells?',
      options: ['Carry oxygen', 'Fight infection', 'Clot blood', 'Store fat'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'Which hormone is responsible for regulating metabolism?',
      options: ['Thyroxine', 'Adrenaline', 'Insulin', 'Testosterone'],
      correctOptionIndex: 0,
    ),
    Question(
      questionText: 'Which structure connects muscles to bones?',
      options: ['Ligament', 'Tendon', 'Cartilage', 'Joint'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'What is the common name for the clavicle?',
      options: ['Collarbone', 'Kneecap', 'Shinbone', 'Wrist'],
      correctOptionIndex: 0,
    ),
    Question(
      questionText: 'Which organ is affected by nephritis?',
      options: ['Heart', 'Liver', 'Kidney', 'Lung'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'What is the term for difficulty in breathing?',
      options: ['Apnea', 'Dyspnea', 'Bradypnea', 'Tachypnea'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'Which part of the immune system produces antibodies?',
      options: ['T-cells', 'B-cells', 'Macrophages', 'Neutrophils'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'What is the largest bone in the human body?',
      options: ['Femur', 'Tibia', 'Humerus', 'Fibula'],
      correctOptionIndex: 0,
    ),
  ];
  void answerQuestion(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex].correctOptionIndex) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      setState(() {
        showResult = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzes and Assessments'),
        centerTitle: true,
      ),
      body: showResult
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Quiz Completed!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Your Score: $score / ${questions.length}',
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentQuestionIndex = 0;
                        score = 0;
                        showResult = false;
                      });
                    },
                    child: Text('Restart Quiz'),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    questions[currentQuestionIndex].questionText,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  // Merge buttons into a single list
                  ...List.generate(
                    questions[currentQuestionIndex].options.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          onPressed: () => answerQuestion(index),
                          child: Text(
                            questions[currentQuestionIndex].options[index],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

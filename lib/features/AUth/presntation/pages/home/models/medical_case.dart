class MedicalCase {
  final String title;
  final String history;
  final List<String> symptoms;
  final List<String> diagnosticTests;
  final String diagnosis;
  final String imageUrl;
  final String description;

  MedicalCase({
    required this.title,
    required this.history,
    required this.symptoms,
    required this.diagnosticTests,
    required this.diagnosis,
    required this.imageUrl,
    required this.description,
  });
}

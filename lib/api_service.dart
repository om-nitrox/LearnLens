import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String BASE_URL = 'http://10.0.2.2:5000'; // For local testing

  // Generate Quiz Questions
  static Future<List<String>> generateQuiz(String topic, int numQuestions) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/generate-quiz'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'topic': topic, 'num_questions': numQuestions}),
    );
    return json.decode(response.body)['questions'];
  }

  // Generate Flashcards
  static Future<List<String>> generateFlashcards(String topic) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/generate-flashcards'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'topic': topic}),
    );
    return json.decode(response.body)['flashcards'];
  }

  // Solve Doubt
  static Future<String> solveDoubt(String doubt) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/solve-doubt'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'doubt': doubt}),
    );
    return json.decode(response.body)['solution'];
  }

  // Save Quiz Results
  static Future<void> saveQuizResults(List<Map<String, String>> results) async {
    await http.post(
      Uri.parse('$BASE_URL/save-quiz-result'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'results': results}),
    );
  }

  // ✅ NEW: Get Saved Quiz Results
  static Future<List<Map<String, dynamic>>> getSavedResults() async {
    final response = await http.get(
      Uri.parse('$BASE_URL/get-saved-results'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body)['results'];
      return jsonData.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      throw Exception('Failed to load quiz results');
    }
  }

  // Extract Text from Image
  static Future<String> extractTextFromImage(String filePath) async {
    var request = http.MultipartRequest('POST', Uri.parse('$BASE_URL/extract-text'));
    request.files.add(await http.MultipartFile.fromPath('image', filePath));
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    return json.decode(responseBody)['extracted_text'];
  }
}

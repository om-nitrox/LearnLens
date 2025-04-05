import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class QuizScreen extends StatefulWidget {
  final String text;
  QuizScreen({required this.text});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> _quizQuestions = [];
  int _score = 0;
  int _currentQuestionIndex = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _generateQuiz();
  }

  Future<void> _generateQuiz() async {
    setState(() {
      _isLoading = true;
    });

    const String apiKey = "AIzaSyB9-NS-zzzN02_L2Ctxlpju93tjGRX1VT0";
    final model = GenerativeModel(model: "gemini-1.5-pro", apiKey: apiKey);

    final prompt = """
    Generate a multiple-choice quiz based on the following text:

    "${widget.text}"

    Format the response as a valid JSON list where:
    - Each item contains "question" (string), "options" (list of 4 choices), and "answer" (correct option).
    Example:
    [
      {"question": "What is AI?", "options": ["Machine Learning", "Artificial Intelligence", "Deep Learning", "Neural Network"], "answer": "Artificial Intelligence"}
    ]
    """;

    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      if (response.text != null) {
        final rawText = response.text!.trim();
        final regex = RegExp(r'\[.*\]', dotAll: true);
        final match = regex.firstMatch(rawText);
        final jsonString = match?.group(0) ?? '[]';

        final data = jsonDecode(jsonString);

        if (data is List) {
          setState(() {
            _quizQuestions = data.map<Map<String, dynamic>>((question) {
              return {
                "question": question["question"] as String,
                "options": List<String>.from(question["options"]),
                "answer": question["answer"] as String,
                "selected": null,
              };
            }).toList();
            _isLoading = false;
          });
        } else {
          throw Exception("Invalid JSON format received.");
        }
      }
    } catch (e) {
      print("❌ Error generating quiz: $e");

      setState(() {
        _isLoading = false;
        _quizQuestions = [];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to generate quiz. Please try again.")),
      );
    }
  }

  void _answerQuestion(String selectedAnswer) {
    setState(() {
      _quizQuestions[_currentQuestionIndex]['selected'] = selectedAnswer;
      if (_quizQuestions[_currentQuestionIndex]['answer'] == selectedAnswer) {
        _score++;
      }

      Future.delayed(Duration(milliseconds: 300), () {
        if (_currentQuestionIndex < _quizQuestions.length - 1) {
          setState(() {
            _currentQuestionIndex++;
          });
        } else {
          _showResults();
        }
      });
    });
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quiz Completed!"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your score: $_score/${_quizQuestions.length}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ...List.generate(_quizQuestions.length, (index) {
                final q = _quizQuestions[index];
                final selected = q['selected'];
                final correct = q['answer'];
                final isCorrect = selected == correct;

                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
                    border: Border.all(
                      color: isCorrect ? Colors.green : Colors.red,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Q${index + 1}: ${q['question']}", style: TextStyle(fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                      Text("Your Answer: $selected", style: TextStyle(color: isCorrect ? Colors.green : Colors.red)),
                      Text("Correct Answer: $correct", style: TextStyle(color: Colors.blueGrey)),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text("Done"),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(String option) {
    final selected = _quizQuestions[_currentQuestionIndex]['selected'];
    final isSelected = selected == option;
    final isCorrect = _quizQuestions[_currentQuestionIndex]['answer'] == option;

    Color bgColor = Colors.white;
    Color textColor = Colors.black;

    if (selected != null) {
      if (isSelected && isCorrect) {
        bgColor = Colors.green;
        textColor = Colors.white;
      } else if (isSelected && !isCorrect) {
        bgColor = Colors.red;
        textColor = Colors.white;
      } else if (isCorrect) {
        bgColor = Colors.green.shade100;
      }
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 3,
        ),
        onPressed: selected == null ? () => _answerQuestion(option) : null,
        child: Text(
          option,
          style: TextStyle(fontSize: 16, color: textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _quizQuestions.isEmpty
              ? Center(child: Text("No questions generated."))
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Question ${_currentQuestionIndex + 1} of ${_quizQuestions.length}",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: Colors.white,
                        shadowColor: Colors.blue.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            _quizQuestions[_currentQuestionIndex]['question'],
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ...(_quizQuestions[_currentQuestionIndex]['options'] as List<String>).map(_buildOptionButton),
                    ],
                  ),
                ),
    );
  }
}

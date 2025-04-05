import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';

class FlashcardScreen extends StatefulWidget {
  final String text;
  FlashcardScreen({required this.text});

  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  List<Map<String, String>> _flashcards = [];
  int _currentIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _generateFlashcards();
  }

  Future<void> _generateFlashcards() async {
    setState(() => _isLoading = true);

    const String apiKey = "AIzaSyB9-NS-zzzN02_L2Ctxlpju93tjGRX1VT0";
    final model = GenerativeModel(model: "gemini-1.5-pro", apiKey: apiKey);

    final prompt = """
    Generate exactly 10 flashcards based on the following text:
    
    "${widget.text}"
    
    Each flashcard should be in JSON format with:
    - "term": the main keyword or concept
    - "definition": its explanation or meaning

    Return a JSON array like this:
    [
      {"term": "Concept1", "definition": "Meaning1"},
      ...
      {"term": "Concept10", "definition": "Meaning10"}
    ]
    """;

    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      if (response.text != null) {
        String rawText = response.text!.trim();

        if (rawText.startsWith("```json")) {
          rawText = rawText.replaceAll("```json", "").replaceAll("```", "").trim();
        }

        final regex = RegExp(r'\[\s*{.*?}\s*]', dotAll: true);
        final match = regex.firstMatch(rawText);

        if (match != null) {
          final jsonString = match.group(0)!;
          final data = jsonDecode(jsonString);

          if (data is List) {
            final trimmed = data.take(10).map<Map<String, String>>((item) {
              return {
                "term": item["term"] ?? "N/A",
                "definition": item["definition"] ?? "N/A",
              };
            }).toList();

            setState(() {
              _flashcards = trimmed;
              _isLoading = false;
            });
            return;
          }
        }
      }

      throw Exception("Failed to parse flashcards");
    } catch (e) {
      print("❌ Error generating flashcards: $e");
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to generate flashcards. Try again.")),
      );
    }
  }

  void _nextCard() {
    if (_currentIndex < _flashcards.length - 1) {
      setState(() => _currentIndex++);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "📚 Flashcards",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.black))
          : _flashcards.isEmpty
              ? const Center(
                  child: Text(
                    "No flashcards generated.",
                    style: TextStyle(color: Colors.black54),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Progress Text
                    Text(
                      "Flashcard ${_currentIndex + 1} of ${_flashcards.length}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Flashcard Container
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 6),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _flashcards[_currentIndex]['term']!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _flashcards[_currentIndex]['definition']!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Next Button
                    ElevatedButton(
                      onPressed: _nextCard,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade100,
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        _currentIndex < _flashcards.length - 1 ? "Next ➡️" : "Finish ✅",
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}

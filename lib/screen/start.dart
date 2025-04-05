import 'package:flutter/material.dart';
import 'package:studdy_buddy/flashcard_api/FlashcardScreen.dart';
import 'package:studdy_buddy/quiz_llm/quiz_screen.dart';
import 'package:studdy_buddy/summarized/SummaryScreen.dart';

class Start extends StatelessWidget {
  const Start({super.key, required this.extractedText});
  final String extractedText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "📘 Study Buddy",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Let’s Begin!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 80),

              _buildOptionButton(
                context,
                label: "Flashcards",
                icon: Icons.style,
                color: Colors.blue.shade100,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FlashcardScreen(text: extractedText),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              _buildOptionButton(
                context,
                label: "Quiz",
                icon: Icons.quiz_rounded,
                color: Colors.purple.shade100,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(text: extractedText),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              _buildOptionButton(
                context,
                label: "Summary",
                icon: Icons.summarize_outlined,
                color: Colors.green.shade100,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SummaryScreen(text: extractedText),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context,
      {required String label,
      required IconData icon,
      required VoidCallback onTap,
      required Color color}) {
    return SizedBox(
      width: 240,
      height: 55,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 22, color: Colors.black87),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}

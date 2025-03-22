import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studdy_buddy/quiz/button.dart';
import 'package:studdy_buddy/quiz/questions.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen(this.onSelectedAns, {super.key});
  final void Function(String answer) onSelectedAns;
  @override
  State<QuizScreen> createState() {
    return _QuizscreenState();
  }
}

class _QuizscreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;

  void answerQuestion(String selectedAns) {
    widget.onSelectedAns(selectedAns);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = quest[currentQuestionIndex];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 40),
              child: Text(currentQuestion.question,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: const Color.fromARGB(255, 255, 255, 255))),
            ),
            ...currentQuestion.suffledAnswer().map((ans) {
              return Answer(ans, () {
                answerQuestion(ans);
              });
            }),
          ],
        ),
      ),
    );
  }
} 
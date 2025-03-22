import 'package:flutter/material.dart';
import 'package:studdy_buddy/quiz/questions.dart';
import 'package:studdy_buddy/quiz/summary_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studdy_buddy/screen/start.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(this.reStart, this.selectedAns, {super.key});
  final List<String> selectedAns;
  final void Function() reStart;
  List<Map<String, Object>> getSummary() {
    List<Map<String, Object>> summary = [];
    for (var i = 0; i < selectedAns.length; i++) {
      summary.add({
        'Question_index': i + 1,
        'Questions': quest[i].question,
        'correct_ans': quest[i].ans[0],
        'selected_ans': selectedAns[i]
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final totalquestion = quest.length;
    final summary = getSummary();
    final correctAnswer = summary.where((add) {
      return add['correct_ans'] == add['selected_ans'];
    }).length;
    return SizedBox(
        width: double.infinity,
        child: Container(
            margin: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "you have solved $correctAnswer correct out of $totalquestion questions.",
                  style: GoogleFonts.lato(
                      fontSize: 24,
                      color: const Color.fromARGB(255, 203, 144, 248),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SummaryScreen(getSummary()),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    onPressed: reStart,
                    label: const Text(
                      "Restart Test",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    icon: const Icon(
                      Icons.replay_outlined,
                      grade: 30,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 20,
                    )),ElevatedButton.icon(
                    onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Start(),));},
                    label: const Text(
                      "Start menu",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    icon: const Icon(
                      Icons.replay_outlined,
                      grade: 30,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 20,
                    ))
              ],
            )));
  }
} 
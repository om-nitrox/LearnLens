 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen(this.summaryData, {super.key});
  final List<Map<String, Object>> summaryData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
            children: summaryData.map(
          (data) {
            bool isCorrect = data['correct_ans'] == data['selected_ans'];
            return Row(
              children: [
                Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: isCorrect ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      data['Question_index'].toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                const Padding(padding: EdgeInsets.only(right: 14)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['Questions'].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        data['correct_ans'].toString(),
                        style: GoogleFonts.openSans(
                            color: const Color.fromARGB(205, 0, 0, 0),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(data['selected_ans'].toString(),
                          style: GoogleFonts.openSans(
                              color: const Color.fromARGB(255, 0, 88, 155),
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ).toList()),
      ),
    );
  }
} 
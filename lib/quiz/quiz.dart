 import 'package:flutter/material.dart';
import 'package:studdy_buddy/quiz/StartScreen.dart';
import 'package:studdy_buddy/quiz/questions.dart';
import 'package:studdy_buddy/quiz/quiz_screen.dart';
import 'package:studdy_buddy/quiz/result_screen.dart';
class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAns = [];
  var activescreen = "start screen";

  void reStart() {
    setState(() {
      selectedAns = [];
      activescreen = "start screen";
    });
  }

  void switchscreen() {
    setState(() {
      activescreen = "question screen";
    });
  }

  void onSelectedAns(String answer) {
    selectedAns.add(answer);
    if (selectedAns.length == quest.length) {
      setState(() {
        activescreen = "result screen";
      });
    }
  }

  @override
  Widget build(context) {
    Widget screenWidget;

    if (activescreen == "start screen") {
      screenWidget = Startscreen(switchscreen);
    } else if (activescreen == "result screen") {
      screenWidget = ResultScreen(reStart, selectedAns);
    } else {
      screenWidget = QuizScreen(onSelectedAns);
    }
    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(color: Color.fromARGB(255, 109, 156, 225)),
            child: screenWidget),
      ),
    );
  }
}  
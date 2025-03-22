import 'package:flutter/material.dart';
import 'package:studdy_buddy/flash_card/flashQuestion.dart';
import 'package:studdy_buddy/flash_card/flash_card_design.dart';
import 'package:studdy_buddy/screen/start.dart';

class FlashCardPage extends StatefulWidget {
  @override
  State<FlashCardPage> createState() {
    return _FlashCardPage();
  }
}

class _FlashCardPage extends State<FlashCardPage> {
  int currentFlashQuestIndex = 0;

  void increIndex() {
    setState(() {
      currentFlashQuestIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FlashCard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlashCard(
              question: flashQuestions[currentFlashQuestIndex].question,
              answer: flashQuestions[currentFlashQuestIndex].ans,
            ),
            SizedBox(height: 30),
            if (currentFlashQuestIndex < flashQuestions.length - 1)
              ElevatedButton(onPressed: increIndex, child: Text("Next"))
            else
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentFlashQuestIndex = 0;
                      });
                    },
                    child: Text("Start Over"),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Start()),
                      );
                    },
                    child: Text("Home page"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:studdy_buddy/flash_card/flash_card_screen.dart';
import 'package:studdy_buddy/quiz/StartScreen.dart';
import 'package:studdy_buddy/quiz/quiz.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("study buddy")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LET'S BEGIN !!", style: TextStyle(fontSize: 30)),
            SizedBox(height: 130),
            SizedBox(
              height: 50,
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 96, 123, 255),
                ),
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => FlashCardPage(),));},
                child: Text("REVISION",style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50, 
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 96, 123, 255),
                ),
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Quiz(),));},
                child: Text("QUIZ",style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
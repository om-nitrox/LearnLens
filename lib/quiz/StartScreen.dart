 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Startscreen extends StatelessWidget {
  const Startscreen(this.startquiz, {super.key});
  final Function() startquiz;
  @override
  Widget build(context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("assets/images/quiz_logo.png",
            width: 300, color: const Color.fromARGB(213, 255, 255, 255)),
        const Padding(padding: EdgeInsets.only(bottom: 30)),
        Text(
          "Learn Flutter The Fun Way!!",
          style: GoogleFonts.lato(
              fontSize: 30,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        ElevatedButton.icon(
          onPressed: startquiz,
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(300, 50),
              backgroundColor: const Color.fromARGB(255, 129, 61, 180)),
          label: const Text(
            "Start Quiz",
            style: TextStyle(
                fontSize: 24, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          icon: const Icon(
            Icons.arrow_forward_ios_sharp,
            grade: 30,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 20,
          ),
        )
      ],
    ));
  }
} 
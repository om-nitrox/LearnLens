import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  const Answer(this.ans, this.ontap, {super.key});
  final String ans;
  final void Function() ontap;
  @override
  Widget build(context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              backgroundColor: const Color.fromARGB(255, 57, 62, 215)),
          onPressed: ontap,
          child: Text(
            ans,
            style: const TextStyle(
                color: Color.fromARGB(255, 230, 227, 227), fontSize: 20),
            textAlign: TextAlign.center,
          )),
    );
  }
}

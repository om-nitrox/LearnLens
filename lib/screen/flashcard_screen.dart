import 'package:flutter/material.dart';
import '../api_service.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  List<String> flashcards = [];

  void generateFlashcards() async {
    flashcards = await ApiService.generateFlashcards("Biology");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    generateFlashcards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flashcards')),
      body: ListView.builder(
        itemCount: flashcards.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(flashcards[index]),
            ),
          );
        },
      ),
    );
  }
}

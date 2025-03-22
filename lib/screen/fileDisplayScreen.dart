  import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studdy_buddy/screen/start.dart';

class FileDisplayScreen extends StatelessWidget {
  final String folderPath;

  const FileDisplayScreen({super.key, required this.folderPath});

  @override
  Widget build(BuildContext context) {
    List<FileSystemEntity> files = Directory(folderPath).listSync();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Files'),
        backgroundColor: Colors.blue,
      ),
      body: files.isEmpty
          ? Column(
            children: [
              const Center(
                  child: Text('No files found'),
                ),ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 96, 123, 255),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Start()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 20),
                  Text("NEXT", style: TextStyle(color: Colors.white)),
                  Icon(Icons.arrow_circle_right_rounded, color: Colors.white),
                  SizedBox(width: 20),
                ],
              ),
            ),
            ],
          )
          : Column(
            children: [
              Expanded(
                child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Display 2 images per row
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1,
                    ),
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      final file = files[index];
                      if (file is File && file.path.endsWith('.png')) {
                        return GestureDetector(
                          onTap: () {
                            // Optional: Add action on tap
                          },
                          child: Image.file(
                            File(file.path),
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return const SizedBox(); // Skip non-image files
                      }
                    },
                  ),
              ),ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 96, 123, 255),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Start()),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 20),
                  Text("NEXT", style: TextStyle(color: Colors.white)),
                  Icon(Icons.arrow_circle_right_rounded, color: Colors.white),
                  SizedBox(width: 20),
                ],
              ),
            ),
            SizedBox(height: 50,)
            ],
          ),
    );
  }
}  
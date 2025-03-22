import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'fileDisplayScreen.dart';

class ScanScreen extends StatefulWidget {
  @override
  State<ScanScreen> createState() => _ScanScreen();
}

class _ScanScreen extends State<ScanScreen> {
  String folderPath = "";
  XFile? _image;
  final TextEditingController _folderNameController = TextEditingController();

  // Function to pick an image
  Future<void> getImage(bool isCamera) async {
    XFile? image;
    if (isCamera) {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    }

    if (image != null) {
      setState(() {
        _image = image;
      });

      // Show dialog to ask for folder name after image is selected
      _showFolderNameDialog(image);
    }
  }

  // Function to create folder and save image
  Future<void> _createFolderAndSaveImage(XFile image) async {
    if (_folderNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a folder name')),
      );
      return;
    }

    try {
      // Get the app's document directory
      final directory = await getApplicationDocumentsDirectory();
      folderPath = '${directory.path}/${_folderNameController.text}';

      // Create the folder if it doesn't exist
      final folder = Directory(folderPath);
      if (!(await folder.exists())) {
        await folder.create(recursive: true);
        debugPrint("Folder created at: $folderPath");
      }

      // Save the image in the folder
      String filePath =
          '$folderPath/${DateTime.now().millisecondsSinceEpoch}.png';
      await File(image.path).copy(filePath);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Image saved to $filePath')));
    } catch (e) {
      debugPrint('Error creating folder or saving image: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to save image')));
    }
  }

  // Function to show dialog to get folder name
  void _showFolderNameDialog(XFile image) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Enter Folder Name'),
            content: TextField(
              controller: _folderNameController,
              decoration: const InputDecoration(hintText: 'Folder name'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _createFolderAndSaveImage(
                    image,
                  ); // Create folder & save image
                },
                child: const Text('Save'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cancel action
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Buddy"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button to capture from camera
            IconButton(
              onPressed: () => getImage(true),
              icon: const Icon(Icons.camera_alt_rounded, size: 100),
            ),
            const SizedBox(height: 20),
            // Button to select from gallery
            IconButton(
              onPressed: () => getImage(false),
              icon: const Icon(Icons.image, size: 100),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 96, 123, 255),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => FileDisplayScreen(folderPath: folderPath),
                  ),
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
          ],
        ),
      ),
    );
  }
}

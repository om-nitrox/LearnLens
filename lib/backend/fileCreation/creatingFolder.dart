 import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Creatingfolder {
  final TextEditingController folderNameController = TextEditingController();

  Future<void> createFolder(BuildContext context) async {
    if (folderNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a folder name')),
      );
      return;
    }

    try {
      // Get the app's document directory
      final directory = await getApplicationDocumentsDirectory();
      String folderPath = '${directory.path}/${folderNameController.text}';

      // Create the folder if it doesn't exist
      final folder = Directory(folderPath);
      if (!(await folder.exists())) {
        await folder.create();
        debugPrint("Folder created at: $folderPath");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Folder created: ${folderNameController.text}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Folder already exists!')),
        );
      }
    } catch (e) {
      debugPrint('Error creating folder: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create folder')),
      );
    }
  }
} 
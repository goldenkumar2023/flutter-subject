import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final picker = ImagePicker();
  File? _image;

  Future<void> updateFile() async {
    if (_image == null) return;

    try {
      await FirebaseStorage.instance
          .ref('uploads/your_file_name.jpg') // Replace with your file path
          .putFile(_image!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File Updated')),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update File'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null ? Text('No image selected.') : Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: updateFile,
              child: Text('Update Image'),
            ),
          ],
        ),
      ),
    );
  }
}

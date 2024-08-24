import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({super.key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  File? image;
  final picker = ImagePicker();
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No Image Selected');
      }
    });
  }

  Future<void> uploadFile() async {
    if (image == null) return;

    final fileName = image!.path.split('/').last;
    final destination = 'file/$fileName';

    try {
      final ref = storage.ref(destination);
      await ref.putFile(image!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File Uploaded')),
      );
    } catch (e) {
      print('Error occurred while uploading the file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload File'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null ? Image.file(image!) : Text('No image selected.'),
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: uploadFile,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}

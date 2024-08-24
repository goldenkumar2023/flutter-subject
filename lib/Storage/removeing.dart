import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class RemoveScreen extends StatefulWidget {
  @override
  _RemoveScreenState createState() => _RemoveScreenState();
}

class _RemoveScreenState extends State<RemoveScreen> {
  Future<void> removeFile() async {
    try {
      await FirebaseStorage.instance
          .ref('uploads/your_file_name.jpg') // Replace with your file path
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File Removed')),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remove File'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: removeFile,
          child: Text('Remove File'),
        ),
      ),
    );
  }
}

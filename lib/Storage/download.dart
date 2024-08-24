import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DownloadUrlScreen extends StatefulWidget {
  @override
  _DownloadUrlScreenState createState() => _DownloadUrlScreenState();
}

class _DownloadUrlScreenState extends State<DownloadUrlScreen> {
  String? _downloadUrl;

  Future<void> getDownloadUrl() async {
    try {
      String downloadUrl = await FirebaseStorage.instance
          .ref('uploads/your_file_name.jpg') // Replace with your file path
          .getDownloadURL();

      setState(() {
        _downloadUrl = downloadUrl;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download URL'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _downloadUrl == null
                ? Text('No URL retrieved.')
                : Text('Download URL: $_downloadUrl'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getDownloadUrl,
              child: Text('Get Download URL'),
            ),
          ],
        ),
      ),
    );
  }
}

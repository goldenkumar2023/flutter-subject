import 'package:flutter/material.dart';
import 'package:fluttersubject/Storage/removeing.dart';
import 'package:fluttersubject/Storage/updating.dart';
import 'package:fluttersubject/Storage/uplading.dart';

import 'download.dart';

class OpenallFilehere extends StatefulWidget {
  const OpenallFilehere({super.key});

  @override
  State<OpenallFilehere> createState() => _OpenallFilehereState();
}

class _OpenallFilehereState extends State<OpenallFilehere> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OpenAllFileHere',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
      body: (Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DownloadUrlScreen()));
              },
              child: Text('Downlode'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UploadFile()));
                },
                child: Text('Upload')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UpdateScreen()));
                },
                child: Text('Uploade')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RemoveScreen(),
                      ));
                },
                child: Text('Remove'))
          ],
        ),
      )),
    );
  }
}

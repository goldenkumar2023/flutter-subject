import 'package:flutter/material.dart';

import 'ParentScreen.dart';
import 'childrenscreen.dart';

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Replace with actual parentId
                String parentId = 'some-parent-id';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ParentScreen(parentId: parentId)),
                );
              },
              child: Text('View Parent Children'),
            ),
            ElevatedButton(
              onPressed: () {
                // Replace with actual childId
                String childId = 'some-child-id';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChildScreen(childId: childId)),
                );
              },
              child: Text('View Child Parent'),
            ),
          ],
        ),
      ),
    );
  }
}

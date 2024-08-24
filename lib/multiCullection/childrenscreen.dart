import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChildScreen extends StatelessWidget {
  final String childId;

  ChildScreen({required this.childId});

  Future<DocumentSnapshot?> getParent() async {
    try {
      var childDoc = await FirebaseFirestore.instance
          .collection('children')
          .doc(childId)
          .get();

      if (!childDoc.exists) {
        print('Child document does not exist');
        return null;
      }

      var parentId = childDoc['parentId'];

      var parentDoc = await FirebaseFirestore.instance
          .collection('parents')
          .doc(parentId)
          .get();

      return parentDoc;
    } catch (e) {
      print('Error getting parent document: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('get Parent Data for children'),
      ),
      body: FutureBuilder<DocumentSnapshot?>(
        future: getParent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
            return Center(child: Text('Parent not found.'));
          }

          var parent = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(parent['profilePictureUrl']),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        parent['name'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Age: ${parent['age']}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(),
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.redAccent),
                        SizedBox(width: 10),
                        Text(
                          parent['email'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.green),
                        SizedBox(width: 10),
                        Text(
                          parent['phone'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.home, color: Colors.orange),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            parent['address'],
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

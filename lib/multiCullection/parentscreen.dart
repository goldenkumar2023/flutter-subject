import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ParentScreen extends StatelessWidget {
  final String parentId;

  ParentScreen({required this.parentId});

  Future<List<DocumentSnapshot>> getChildren() async {
    var parentDoc = await FirebaseFirestore.instance
        .collection('Parents')
        .doc(parentId)
        .get();
    List<dynamic> childIds = parentDoc['childIds'];
    var childrenQuery = await FirebaseFirestore.instance
        .collection('children')
        .where(FieldPath.documentId, whereIn: childIds)
        .get();
    return childrenQuery.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Children Data for Parent'),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: getChildren(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No children found.'));
          }

          var children = snapshot.data!;
          return ListView.builder(
            itemCount: children.length,
            itemBuilder: (context, index) {
              var child = children[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(child['profilePictureUrl'] ?? 'https://via.placeholder.com/150'),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                child['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Text(
                                'Age: ${child['age']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.redAccent),
                          SizedBox(width: 10),
                          Text(
                            child['email'],
                            style: TextStyle(
                              fontSize: 16,
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
                            child['phone'],
                            style: TextStyle(
                              fontSize: 16,
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
                              child['address'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

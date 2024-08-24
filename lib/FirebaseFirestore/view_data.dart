import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttersubject/FirebaseFirestore/student_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _updateName = TextEditingController();
  TextEditingController _updateEmail = TextEditingController();
  TextEditingController _updatePhone = TextEditingController();

  void _handleUpdateProduct(String documentId) {
    String updateName = _updateName.text;
    String updateEmail = _updateEmail.text;
    String updatePhone = _updatePhone.text;

    if (updateName.isEmpty || updateEmail.isEmpty || updatePhone.isEmpty) {
      Fluttertoast.showToast(msg: "All fields are required!");
      return;
    }

    FirebaseFirestore.instance.collection("students").doc(documentId).update({
      "name": updateName,
      "email": updateEmail,
      "number": updatePhone,
    }).then((value) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Updated successfully"),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to update data: $error"),
        ),
      );
    });
  }

  var fetchData = FirebaseFirestore.instance.collection('students');

  void openBottomSheet(String id) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 330,
                child: TextField(
                  controller: _updateName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 330,
                child: TextField(
                  controller: _updateEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 330,
                child: TextField(
                  controller: _updatePhone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Number',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    onPressed: () {
                      _handleUpdateProduct(id);
                      Navigator.pop(
                          context); // Close bottom sheet after updating
                    },
                    child: Text('Submit')),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text('Home Page'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 1000,
            child: FutureBuilder<QuerySnapshot>(
              future: fetchData.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No data found'));
                }

                var data = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var document = data[index];
                    var modelData = StudentModel.fromJson(
                        document.data() as Map<String, dynamic>);
                    return SizedBox(
                      height: 70,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, right: 8, top: 10),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                              title: Text(modelData.name.toString()),
                              subtitle: Text(modelData.number.toString()),
                              trailing: Container(
                                height: 30,
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          openBottomSheet(document.id);
                                        },
                                        icon: Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          deleteData(document.id);
                                        },
                                        icon: Icon(Icons.delete)),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> deleteData(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection("students")
          .doc(documentId)
          .delete();
      setState(() {});
      Fluttertoast.showToast(msg: "Document deleted successfully!");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error deleting document: $e");
    }
  }
}

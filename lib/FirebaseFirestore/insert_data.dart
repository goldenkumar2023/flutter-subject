import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttersubject/FirebaseFirestore/view_data.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();

  void insertData() {
    String name = _name.text.trim();
    String email = _email.text.trim();
    String phone = _phone.text.trim();
    String password = _password.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill all fields');
      return;
    }

    FirebaseFirestore.instance.collection("students").add({
      "name": name,
      "email": email,
      "number": phone,
      "students_id": ""
    }).then((value) {
      var id = value.id;
      FirebaseFirestore.instance
          .collection("students")
          .doc(id)
          .update({"students_id": id});
      Fluttertoast.showToast(msg: 'Data submitted successfully');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: 'Data submission failed');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text('Insert Data'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 330,
              child: TextField(
                controller: _name,
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
                controller: _email,
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
                controller: _phone,
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
              width: 330,
              child: TextField(
                controller: _password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
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
                    insertData();
                  },
                  child: Text('Submit')),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'viewData_screen.dart'; // Ensure this is the correct path to your DisplayDataScreen

class GetDatascreen extends StatefulWidget {
  @override
  _GetDatascreenState createState() => _GetDatascreenState();
}

class _GetDatascreenState extends State<GetDatascreen> {
  final _formKey = GlobalKey<FormState>();
  String? _inputValue;

  Future<List<Map<String, dynamic>>> getData(String value) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('submitted')
          .orderBy('name')
          .startAt([value]).endAt([value + '\uf8ff']).get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error querying Firestore: $e');
      return [];
    }
  }

  // Uncomment the following method to use the where clause
  // Future<List<Map<String, dynamic>>> getData(String value) async {
  //   try {
  //     final querySnapshot = await FirebaseFirestore.instance
  //         .collection('submitted')
  //         .where('status', isEqualTo: 'approved') // Add your where clause here
  //         .orderBy('name') // Order by the 'name' field
  //         .startAt([value])
  //         .endAt([value + '\uf8ff'])
  //         .get();
  //     return querySnapshot.docs
  //         .map((doc) => doc.data() as Map<String, dynamic>)
  //         .toList();
  //   } catch (e) {
  //     print('Error querying Firestore: $e');
  //     return [];
  //   }
  // }

  void _navigateToDisplayDataScreen(
      BuildContext context, List<Map<String, dynamic>> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayDataScreen(data: data),
      ),
    );
  }

  void _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      List<Map<String, dynamic>> data = [];

      if (_inputValue != null) {
        data = await getData(_inputValue!);
      }

      if (data.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data retrieved successfully!')),
        );
        _navigateToDisplayDataScreen(context, data);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No data found!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Starting Letters',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onSaved: (value) {
                  _inputValue = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some letters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleSubmit,
                child: Text('Get Data'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

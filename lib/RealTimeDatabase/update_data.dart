import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttersubject/RealTimeDatabase/usermodels.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateData extends StatefulWidget {
  final UserModels dataModels;

  const UpdateData({required this.dataModels, super.key});

  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref("gk").child("Users");
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController pinController;

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.dataModels.customers?.name);
    phoneController = TextEditingController(
        text: widget.dataModels.customers?.phone?.toString());
    addressController = TextEditingController(
        text: widget.dataModels.customers?.location?.address);
    pinController = TextEditingController(
        text: widget.dataModels.customers?.location?.pin?.toString());
  }

  Future<void> updateData() async {
    try {
      await databaseRef.child(widget.dataModels.customers?.name ?? '').set({
        "Customers": {
          "name": nameController.text,
          "Phone": int.parse(phoneController.text),
          "location": {
            "address": addressController.text,
            "pin": int.parse(pinController.text),
            "landMark": widget.dataModels.customers?.location?.landMark ?? ''
          }
        },
        "Sellers": widget.dataModels.sellers?.toJson() ?? {}
      });
      Fluttertoast.showToast(
          msg: "Data updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context, true);
    } catch (error) {
      print("Error updating data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Customer Details'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.teal.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              shadowColor: Colors.black45,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.teal, size: 30),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: "Name",
                              labelStyle:
                                  TextStyle(color: Colors.teal.shade700),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                        color: Colors.teal.shade700, height: 20, thickness: 1),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.teal),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              labelText: "Phone",
                              labelStyle:
                                  TextStyle(color: Colors.teal.shade700),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.teal),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                              labelText: "Address",
                              labelStyle:
                                  TextStyle(color: Colors.teal.shade700),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.pin_drop, color: Colors.teal),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: pinController,
                            decoration: InputDecoration(
                              labelText: "Pin",
                              labelStyle:
                                  TextStyle(color: Colors.teal.shade700),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: updateData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          textStyle: TextStyle(fontSize: 20),
                        ),
                        child: Text("Update Data"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

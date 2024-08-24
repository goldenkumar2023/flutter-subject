import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttersubject/RealTimeDatabase/usermodels.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'update_data.dart';

class Getdata extends StatefulWidget {
  const Getdata({super.key});

  @override
  State<Getdata> createState() => _GetdataState();
}

class _GetdataState extends State<Getdata> {
  final DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref("gk").child("Users");
  UserModels dataModels = UserModels();

  @override
  void initState() {
    super.initState();
    getMyData();
  }

  Future<void> getMyData() async {
    try {
      DatabaseEvent event = await databaseRef.once();
      Map<dynamic, dynamic> data =
          event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        dataModels = UserModels.fromJson(data);
      });
      Fluttertoast.showToast(
          msg: "Data Get  successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var name = dataModels.customers?.name ?? "Name not available";
    var phone =
        dataModels.customers?.phone?.toString() ?? "Phone not available";
    var address =
        dataModels.customers?.location?.address ?? "Address not available";
    var pin =
        dataModels.customers?.location?.pin?.toString() ?? "Pin not available";

    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Details'),
        backgroundColor: Colors.teal,
        elevation: 0,
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
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade800,
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
                        Text(
                          phone,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.teal.shade700,
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
                          child: Text(
                            address,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.teal.shade700,
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
                        Text(
                          pin,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.teal.shade700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateData(
                                dataModels: dataModels,
                              ),
                            ),
                          );
                        },
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

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttersubject/RealTimeDatabase/usermodels.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Getdata extends StatefulWidget {
  const Getdata({Key? key}) : super(key: key);

  @override
  _GetdataState createState() => _GetdataState();
}

class _GetdataState extends State<Getdata> {
  final DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref("gk").child("Users");
  List<UserModels> usersList = [];

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
      List<UserModels> tempList = [];
      data.forEach((key, value) {
        UserModels user = UserModels.fromJson(Map<String, dynamic>.from(value));
        tempList.add(user);
      });
      setState(() {
        usersList = tempList;
        Fluttertoast.showToast(
          msg: "Data fetched successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  Future<void> deleteData(String userId) async {
    try {
      await databaseRef.child(userId).remove();
      Fluttertoast.showToast(
        msg: "Data deleted successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      getMyData(); // Refresh the data after deletion
    } catch (error) {
      print("Error deleting data: $error");
    }
  }

  Future<void> _confirmDelete(BuildContext context, String userName) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Are you sure you want to delete $userName's data?"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                deleteData(userName);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
        child: ListView.builder(
          itemCount: usersList.length,
          itemBuilder: (context, index) {
            UserModels user = usersList[index];
            var name = user.customers?.name ?? "Name not available";
            var phone =
                user.customers?.phone?.toString() ?? "Phone not available";
            var address =
                user.customers?.location?.address ?? "Address not available";
            var pin = user.customers?.location?.pin?.toString() ??
                "Pin not available";

            return Padding(
              padding: const EdgeInsets.all(8.0),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade800,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _confirmDelete(context, name);
                            },
                          ),
                        ],
                      ),
                      Divider(
                          color: Colors.teal.shade700,
                          height: 20,
                          thickness: 1),
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
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

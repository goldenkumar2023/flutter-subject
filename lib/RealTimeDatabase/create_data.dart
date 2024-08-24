import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttersubject/RealTimeDatabase/usermodels.dart';

import 'delete_data.dart';

class Realtimedatabase extends StatefulWidget {
  const Realtimedatabase({super.key});

  @override
  State<Realtimedatabase> createState() => _RealtimedatabaseState();
}

class _RealtimedatabaseState extends State<Realtimedatabase> {
  final usernameController = TextEditingController();
  final userAgeController = TextEditingController();
  final userSalaryController = TextEditingController();

  final DatabaseReference userData = FirebaseDatabase.instance.ref('gk');
  UserModels modelData = UserModels();

  @override
  void initState() {
    super.initState();
    //getMyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Data'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text(
                'Insert Data in Firebase Realtime Database',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: usernameController,
                labelText: 'Name',
                hintText: 'Enter Your Name',
                icon: Icons.person,
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: userAgeController,
                labelText: 'Age',
                hintText: 'Enter Your Age',
                icon: Icons.cake,
                inputType: TextInputType.number,
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: userSalaryController,
                labelText: 'Salary',
                hintText: 'Enter Your Salary',
                icon: Icons.attach_money,
                inputType: TextInputType.number,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _insertData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text(
                  'Insert Data',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon),
      ),
    );
  }

  void _insertData() {
    String name = usernameController.text;
    int age = int.parse(userAgeController.text);
    int salary = int.parse(userSalaryController.text);

    var customers = Customers(
      name: name,
      phone: age,
      location: CustomersLocation(
        address: 'saranbihar',
        pin: 841418,
        landMark: 'Amnour',
      ),
    );

    var sellers = Sellers(
      shopName: 'Golden vastralay',
      owner: Owner(
        name: name,
        phone: age,
        email: 'goldenkumar@gmail.com',
      ),
      location: SellersLocation(
        address: 'AmnourSaranBihar',
        phone: 2365478963,
        landMark: 'Red kila',
      ),
    );

    var userModel = UserModels(customers: customers, sellers: sellers);

    userData.child("Users").push().set(userModel.toJson()).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data inserted successfully')),
      );

      _clearTextFields();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Getdata()));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to insert data: $error')),
      );
    });
  }

  void _clearTextFields() {
    usernameController.clear();
    userAgeController.clear();
    userSalaryController.clear();
  }

// Future<void> getMyData() async {
//   await userData.get().then((snapshot) {
//     var data = snapshot.value as Map<dynamic, dynamic>;
//     modelData = UserModels.fromJson(data);
//     var name = modelData.customers?.name;
//   });
//   setState(() {});
// }
}

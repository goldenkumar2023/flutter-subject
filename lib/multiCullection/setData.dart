import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'homescreen.dart';

class SetData extends StatefulWidget {
  const SetData({super.key});

  @override
  State<SetData> createState() => _SetDataState();
}

class _SetDataState extends State<SetData> {
  final TextEditingController parentIdController = TextEditingController();
  final TextEditingController parentNameController = TextEditingController();
  final TextEditingController parentEmailController = TextEditingController();
  final TextEditingController parentAgeController = TextEditingController();
  final TextEditingController parentGenderController = TextEditingController();

  final TextEditingController childIdController = TextEditingController();
  final TextEditingController childNameController = TextEditingController();
  final TextEditingController childEmailController = TextEditingController();
  final TextEditingController childAgeController = TextEditingController();
  final TextEditingController childGenderController = TextEditingController();
  final TextEditingController childParentIdController = TextEditingController();

  var uuid = Uuid();

  Future<void> addParent(
      String id, String name, String email, int age, String gender) async {
    String id = uuid.v4(); // Generate a random ID
    try {
      await FirebaseFirestore.instance.collection('parents').doc(id).set({
        "name": name,
        "email": email,
        "age": age,
        "gender": gender,
        "childIds": [], // Initialize an empty list of child IDs
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Parent data added successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homescreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add parent: $e'),
        duration: const Duration(seconds: 2),
      ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homescreen()));
    }
  }

  Future<void> addChild(String id, String name, String email, int age,
      String gender, String parentId) async {
    String id = uuid.v4(); // Generate a random ID
    try {
      await FirebaseFirestore.instance.collection('children').doc(id).set({
        "name": name,
        "email": email,
        "age": age,
        "gender": gender,
        "parentId": parentId,
      });

      await FirebaseFirestore.instance
          .collection('parents')
          .doc(parentId)
          .update({
        "childIds": FieldValue.arrayUnion([id])
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Child data added successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homescreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add child: $e'),
        duration: const Duration(seconds: 2),
      ));
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Homescreen(),
          ));
    }
  }

  Widget buildTextField(TextEditingController controller, String label,
      TextInputType inputType, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
      ),
    );
  }

  Widget buildAddButton(String title, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Data',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionTitle('Parent Information'),
              buildTextField(parentIdController, 'Parent ID',
                  TextInputType.text, Icons.badge),
              buildTextField(parentNameController, 'Parent Name',
                  TextInputType.text, Icons.person),
              buildTextField(parentEmailController, 'Parent Email',
                  TextInputType.emailAddress, Icons.email),
              buildTextField(parentAgeController, 'Parent Age',
                  TextInputType.number, Icons.calendar_today),
              buildTextField(parentGenderController, 'Parent Gender',
                  TextInputType.text, Icons.transgender),
              buildAddButton('Add Parent', () async {
                await addParent(
                  parentIdController.text,
                  parentNameController.text,
                  parentEmailController.text,
                  int.parse(parentAgeController.text),
                  parentGenderController.text,
                );
                parentIdController.clear();
                parentNameController.clear();
                parentEmailController.clear();
                parentAgeController.clear();
                parentGenderController.clear();
              }),
              const SizedBox(height: 20),
              const Divider(height: 40, color: Colors.grey),
              buildSectionTitle('Child Information'),
              buildTextField(childIdController, 'Child ID', TextInputType.text,
                  Icons.badge),
              buildTextField(childNameController, 'Child Name',
                  TextInputType.text, Icons.person),
              buildTextField(childEmailController, 'Child Email',
                  TextInputType.emailAddress, Icons.email),
              buildTextField(childAgeController, 'Child Age',
                  TextInputType.number, Icons.calendar_today),
              buildTextField(childGenderController, 'Child Gender',
                  TextInputType.text, Icons.transgender),
              buildTextField(childParentIdController, 'Parent ID for Child',
                  TextInputType.text, Icons.link),
              buildAddButton('Add Child', () async {
                await addChild(
                  childIdController.text,
                  childNameController.text,
                  childEmailController.text,
                  int.parse(childAgeController.text),
                  childGenderController.text,
                  childParentIdController.text,
                );
                childIdController.clear();
                childNameController.clear();
                childEmailController.clear();
                childAgeController.clear();
                childGenderController.clear();
                childParentIdController.clear();
              }),
            ],
          ),
        ),
      ),
    );
  }
}

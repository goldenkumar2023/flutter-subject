import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'getdata_screen.dart';

class FormDataScreen extends StatefulWidget {
  const FormDataScreen({Key? key}) : super(key: key);

  @override
  FormDataScreenState createState() => FormDataScreenState();
}

class FormDataScreenState extends State<FormDataScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String? genderValue;

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('submitted');

  void _saveFormData() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = {
        'name': nameController.text,
        'email': emailController.text,
        'age': ageController.text,
        'gender': genderValue,
      };
      try {
        await _usersCollection.add(formData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data saved successfully!')),
        );

        // Navigate to display screen after showing Snackbar
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GetDatascreen(),
          ),
        );

        // Clear form fields after successful submission
        nameController.clear();
        emailController.clear();
        ageController.clear();
        setState(() {
          genderValue = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save data!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Validation failed!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                controller: nameController,
                name: 'name',
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(2),
                ]),
              ),
              SizedBox(height: 20),
              FormBuilderTextField(
                controller: emailController,
                name: 'email',
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              SizedBox(height: 20),
              FormBuilderTextField(
                controller: ageController,
                name: 'age',
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              SizedBox(height: 20),
              FormBuilderDropdown(
                name: 'gender',
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                validator: FormBuilderValidators.required(),
                onChanged: (value) {
                  setState(() {
                    genderValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveFormData,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

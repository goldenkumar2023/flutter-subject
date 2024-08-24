import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'enter_otp.dart';

class EnterNumber extends StatefulWidget {
  const EnterNumber({super.key});

  @override
  State<EnterNumber> createState() => _EnterNumberState();
}

class _EnterNumberState extends State<EnterNumber> {
  TextEditingController phoneNumberController = TextEditingController();
  var auth = FirebaseAuth.instance;
  String verificationId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(hintText: "Enter number"),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                auth.verifyPhoneNumber(
                  phoneNumber: "+91${phoneNumberController.text}",
                  verificationCompleted: (phoneAuthCredential) {},
                  verificationFailed: (error) {
                    if (kDebugMode) {
                      print(error);
                    }
                  },
                  codeSent: (verificationId, forceResendingToken) {
                    // Update the state variable with the received verificationId
                    setState(() {
                      this.verificationId = verificationId;
                    });
                  },
                  codeAutoRetrievalTimeout: (verificationId) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VerifyOtp(verificationId: verificationId),
                      ),
                    );
                  },
                );
              },
              child: Text("Send"),
            ),
          ],
        ),
      ),
    );
  }
}

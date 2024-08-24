import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_scerrn.dart';

class VerifyOtp extends StatefulWidget {
  final String verificationId;

  VerifyOtp({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  TextEditingController otpController = TextEditingController();
  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: otpController,
              decoration: InputDecoration(hintText: "Enter OTP"),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: otpController.text,
                );
                auth.signInWithCredential(credential).then((user) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => homeScreen()),
                  );
                }).catchError((error) {
                  // Handle sign-in errors here
                  print("Error: $error");
                });
              },
              child: Text("Verify OTP"),
            )
          ],
        ),
      ),
    );
  }
}

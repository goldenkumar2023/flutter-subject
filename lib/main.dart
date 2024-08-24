import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'RealTimeDatabase/create_data.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Revision',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Realtimedatabase(),
    );
  }
}

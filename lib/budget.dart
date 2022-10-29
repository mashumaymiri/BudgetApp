// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('January'),),
        ),
        body: Column(children: [
          Title(
              color: Colors.black,
              child: const Center(
                child: Text(
                    '\$1300',
                  style: TextStyle(fontSize: 75),
                ),
              ),
          ),
          const Center(
            child: Text(
              'Total Budget',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 2,
            endIndent: 0,
            color: Colors.black,
          ),
          const Card(
            color: Colors.blueAccent,
            child: SizedBox(
              width: 300,
              height: 100,
              child: Center(child: Text('Food: \$500')),
            ),
          ),
          const Card(
            color: Colors.blueAccent,
            child: SizedBox(
              width: 300,
              height: 100,
              child: Center(child: Text('Car Gas: \$200')),
            ),
          ),
          const Card(
            color: Colors.blueAccent,
            child: SizedBox(
              width: 300,
              height: 100,
              child: Center(child: Text('Work Expenses: \$1000')),
            ),
          ),
        ]),
      ),
    );
    // return Scaffold(
    //   body: LoginWidget(),
    // );
  }

}

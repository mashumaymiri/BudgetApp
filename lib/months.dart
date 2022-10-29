// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class monthPage extends StatelessWidget {
  const monthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Flutter'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MonthCard(),
          MonthCard(),
          MonthCard(),
        ],
      ),
    );
  }

}

class MonthCard extends StatefulWidget {

  const MonthCard({Key? key}) : super(key: key);

  @override
  State<MonthCard> createState() => _MonthCardState();
}

class _MonthCardState extends State<MonthCard> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          color: Colors.blue,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              debugPrint('Tapped');
              Navigator.pushNamed(context, '/budget');
          },
            child: SizedBox(
              width: 300,
              height: 100,
              child: Center(
                  child: Text('Jan')
              ),
            ),
          ),
        ),
      ),
    );
  }
}

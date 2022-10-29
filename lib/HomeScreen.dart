import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'Clasess/AuthenticationService.dart';

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
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AuthenticationService>().signOut(context);
        },
        child: Icon(Icons.logout_rounded),
        backgroundColor: Colors.green,
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
            child: const SizedBox(
              width: 300,
              height: 100,
              child: Center(child: Text('Jan')),
            ),
          ),
        ),
      ),
    );
  }
}


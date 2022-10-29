import 'package:budget_app/Clasess/Expenses.dart';
import 'package:budget_app/Clasess/Month.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'Clasess/AuthenticationService.dart';

class monthPage extends StatefulWidget {
  @override
  State<monthPage> createState() => _monthPage();
}

List<Widget> MonthsChildren = [];

class _monthPage extends State<monthPage> {
  //const monthPage({super.key});

  //FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //
  // var fasd = firebaseFirestore.collection('Months').snapshots();

  // return ListView(
  // children: snapshot.data.docs.map((document) {
  // return Container(
  // child: Center(child: Text(document['text'])),
  // );
  // }).toList(),
  // );
  // },
  void initState() {
    super.initState();
    MonthsChildren = [];
    for (int i = 1; i <= 12; i++) {
      var month = Month();
      month.name = "month $i";
      month.order = i;
      month.budget = 5000;
      month.year = "2022";
      month.expenses = [Expense(), Expense(), Expense()];
      MonthsChildren.add(MonthCard(month: month));
    }
    //print(MonthsChildren);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Flutter'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: MonthsChildren,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AuthenticationService>().signOut(context);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.logout_rounded),
      ),
    );
  }
}

class MonthCard extends StatefulWidget {
  Month month;
  MonthCard({super.key, required this.month});
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
              print(widget.month.budget);

              Navigator.pushNamed(context, '/budget', arguments: widget.month);
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

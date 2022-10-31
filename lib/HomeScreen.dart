import 'dart:math';

import 'package:budget_app/Clasess/Month.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'Clasess/AuthenticationService.dart';
import 'Clasess/Expenses.dart';

class monthPage extends StatefulWidget {
  @override
  State<monthPage> createState() => _monthPage();
}

List<Widget> MonthsChildren = [];

Map<int, String> monthMap = {
  1: "January",
  2: 'February',
  3: 'March',
  4: 'April',
  5: 'May',
  6: 'June',
  7: 'July',
  8: 'August',
  9: 'September',
  10: 'October',
  11: 'November',
  12: 'December'
};

Map<int, List<Expense>> mapmonthlist = {};

class _monthPage extends State<monthPage> {
  final _auth = FirebaseAuth.instance;

  void fetchData() async {
    // print("Fetching Data!");
    Map<int, Month> mapmonthsf = {};
    MonthsChildren = [];

    for (int i = 1; i <= 12; i++) {
      mapmonthlist[i] = [];
    }
    var dataM = await FirebaseFirestore.instance.collection("Months").get();
    for (int i = 0; i < dataM.docs.length; i++) {
      if (_auth.currentUser?.uid == dataM.docs[i].data()['uid']) {
        //print(dataM.docs[i].data()['budget']);
        Month model = Month(
            name: dataM.docs[i].data()['name'],
            order: dataM.docs[i].data()['order'],
            budget: dataM.docs[i].data()['budget'],
            year: dataM.docs[i].data()['year'],
            expenses: [],//dataM.docs[i].data()['expenses'] as List<Expense>?,
            docid: dataM.docs[i].data()['docid'],
            uid: dataM.docs[i].data()['uid']);
        mapmonthsf[dataM.docs[i].data()['order']] = model;
      }
    }
    for (int i = 1; i <= 12; i++) {
      if (mapmonthsf[i] == null) {
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        final docUser = FirebaseFirestore.instance
            .collection("Months")
            .doc();
        Month expenseModel = Month(
            name: monthMap[i],
            order: i,
            budget: 5000,
            year: "2022",
            expenses: [],
            uid: _auth.currentUser?.uid,
            docid: docUser.id
        );
        mapmonthsf[i] = expenseModel;
        await firebaseFirestore
            .collection("Months")
            .doc(expenseModel.docid)
            .set(expenseModel.toMap());
        // Fluttertoast.showToast(msg: "Expense Saved Successfully :) ");
      }
    }

    var data = await FirebaseFirestore.instance.collection("Expense").get();
    for (int i = 0; i < data.docs.length; i++) {
      if (_auth.currentUser?.uid == data.docs[i].data()['uid']) {
        Expense model = Expense(
            name: data.docs[i].data()['name'],
            cost: data.docs[i].data()['cost'],
            month: data.docs[i].data()['month'],
            docid: data.docs[i].data()['docid'],
            uid: data.docs[i].data()['uid']);
        mapmonthlist[model.month]?.add(model);
      }
    }
    setState(() {
      for (int i = 1; i <= 12; i++) {
        Month month = Month(
            name: monthMap[i],
            order: i,
            budget: mapmonthsf[i]?.budget,
            year: mapmonthsf[i]?.year,
            expenses: mapmonthlist[i],
            uid: _auth.currentUser?.uid,
            docid: mapmonthsf[i]?.docid
        );

        // month.expenses = mapmonthlist[i];
        MonthsChildren.add(MonthCard(month: month, fetch: fetchData));
      }
    });
  }

  void initState() {
    super.initState();
    MonthsChildren = [];
    fetchData();
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
  var fetch;

  MonthCard({super.key, required this.month, required this.fetch});

  @override
  State<MonthCard> createState() => _MonthCardState();
}

class _MonthCardState extends State<MonthCard> {
  @override
  Widget build(BuildContext context) {
    final name = widget.month.name;

    return Container(
      child: Center(
        child: Card(
          color: Colors.blue,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              // await widget.fetch();
              // widget.month.expenses = mapmonthlist[widget.month.order];
              Navigator.pushNamed(context, '/budget', arguments: widget.month)
                  .then((value) => widget.fetch());
            },
            child: SizedBox(
              width: 300,
              height: 100,
              child: Center(child: Text(name!)),
            ),
          ),
        ),
      ),
    );
  }
}

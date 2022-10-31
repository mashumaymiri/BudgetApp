import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Clasess/Expenses.dart';
import 'Clasess/Month.dart';
import 'HomeScreen.dart';

List<Widget> expensesCards = [];
GlobalKey<BudgetPageState>? Gk;

class BudgetPage extends StatefulWidget {
  Month? month;

  BudgetPage({super.key, this.month});

  @override
  BudgetPageState createState() => BudgetPageState();
}

class BudgetPageState extends State<BudgetPage> {
  bool initialized = false;
  GlobalKey<BudgetPageState>? gk;
  GlobalKey<BudgetPageState> globalKey = new GlobalKey<BudgetPageState>();
  final _auth = FirebaseAuth.instance;

  // editing controller
  final TextEditingController nameCont = TextEditingController();
  final TextEditingController costCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    // print(widget.month?.budget);
    // print(widget.month);
  }

  void reset(eC, index) {
    // print("test1");
    setState(() {
      // print("test2");
      // expensesCards.add(eC);
      expensesCards[index] = eC;
    });
  }

  void delete(index) {
    setState(() {
      expensesCards.removeAt(index);
    });
  }

  final TextEditingController budgetcont = TextEditingController();
  int budget = 5000;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Month;
    var expenses = args.expenses!;
    final monthnumber = args.order;
    final MONTHNAME = args.name;

    // List<Widget> expensesCards = [];
    if (!initialized) {
      initialized = true;
      budget = args.budget!;

      // print(_auth.currentUser?.uid);
      expensesCards = [];

      setState(() {
        for (int i = 0; i < expenses.length; i++) {
          var expense = expenses.elementAt(i);
          expensesCards.add(ExpanseCard(
            name: expense.name,
            cost: expense.cost,
            month: expense.month,
            docid: expense.docid,
            uid: expense.uid,
            index: i,
            reset: reset,
            delete: delete,
          ));
        }
      });
    }

    double sumExpense = 0;
    for (int i = 0; i < expensesCards.length; i++) {
      sumExpense += (expensesCards[i] as ExpanseCard).cost!;
    }
    double diffrenceEB = budget - sumExpense;
    String dificon = "";
    MaterialColor difcolor = Colors.green;
    if (diffrenceEB > 0) {
      dificon = "+";
    } else {
      dificon = "-";
      difcolor = Colors.red;
      diffrenceEB = diffrenceEB * -1;
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(MONTHNAME!),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // start modal func
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              context: context,
              builder: (builder) => Container(
                  height: 340,
                  child: Column(children: [
                    Column(children: [
                      SizedBox(
                        height: 45,
                        child: Container(
                          decoration: const BoxDecoration(
                            // color: tColor().cardtop,
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 0),
                                decoration: BoxDecoration(),
                                child: const Text(
                                  "\nAdd expense",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 40),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Expense',
                          ),
                          textInputAction: TextInputAction.next,
                          controller: nameCont,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Cost',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.done,
                          controller: costCont,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (nameCont.text.isEmpty ||
                                costCont.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please Fill all the info!");
                              return;
                            }

                            final name = nameCont.text;
                            final double cost = double.parse(costCont.text);

                            FirebaseFirestore firebaseFirestore =
                                FirebaseFirestore.instance;
                            final docUser = FirebaseFirestore.instance
                                .collection("Expense")
                                .doc();

                            Expense expenseModel = Expense(
                                name: name,
                                cost: cost,
                                month: monthnumber,
                                // id:  "$name _ $cost"
                                uid: _auth.currentUser?.uid,
                                docid: docUser.id);

                            //writing all the values
                            // userModel.email = user!.email;
                            // userModel.uid = user.uid;
                            // userModel.firstName = firstNameCont.text;
                            // userModel.secondName =
                            //     secondNameCont.text;

                            await firebaseFirestore
                                .collection("Expense")
                                .doc(expenseModel.docid)
                                .set(expenseModel.toMap());
                            Fluttertoast.showToast(
                                msg: "Expense added Successfully :) ");
                            setState(() {
                              expensesCards.add(ExpanseCard(
                                name: expenseModel.name,
                                cost: expenseModel.cost,
                                month: expenseModel.month,
                                uid: expenseModel.uid,
                                docid: expenseModel.docid,
                                index: expensesCards.length,
                                reset: reset,
                                delete: delete,
                              ));
                            });

                            Navigator.pop(context);
                          },
                          child: const Text('Submit'),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                        ),
                      ),
                      // ],
                      //      ),
                      // ),
                    ]),
                  ])));

          // end modal func
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Title(
            color: Colors.black,
            child: Center(
              child: Text(
                '$dificon\$$diffrenceEB',
                style: TextStyle(fontSize: 75, color: difcolor),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 70),
                  child: TextButton(
                    child: Text('Budget: \$$budget',
                        style: const TextStyle(fontSize: 15)),
                    onPressed: () {
                      print("pressedbudget");
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          context: context,
                          builder: (builder) => Container(
                                height: 340,
                                child: Column(children: [
                                  Column(children: [
                                    SizedBox(
                                      height: 45,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black,
                                                width: 1.0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 0),
                                              decoration: BoxDecoration(),
                                              child: const Text(
                                                "\nEdit budget",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 40),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Container(),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 8),
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                border: UnderlineInputBorder(),
                                                labelText: 'Budget',
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              controller: budgetcont,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 120, vertical: 10),
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  if (budgetcont.text.isEmpty) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Please Fill all the info!");
                                                    return;
                                                  }
                                                  final int Budget = int.parse(
                                                      budgetcont.text);

                                                  FirebaseFirestore
                                                      firebaseFirestore =
                                                      FirebaseFirestore
                                                          .instance;

                                                  Month expenseModel = Month(
                                                      name: args.name,
                                                      order: args.order,
                                                      budget: Budget,
                                                      year: args.year,
                                                      expenses: [],
                                                      //dataM.docs[i].data()['expenses'] as List<Expense>?,
                                                      docid: args.docid,
                                                      uid: args.uid);

                                                  await firebaseFirestore
                                                      .collection("Months")
                                                      .doc(args.docid)
                                                      .set(
                                                          expenseModel.toMap());
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Budget Saved Successfully :) ");

                                                  setState(() {
                                                    budget = Budget;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Submit'),
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.green),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ]),
                              ));
                    },
                    style: TextButton.styleFrom(primary: Colors.black),
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 65),
                  child: Text(
                    'Expenses: $sumExpense',
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  )),
            ],
          ),
          const Divider(
            height: 20,
            thickness: 2,
            endIndent: 0,
            color: Colors.black,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: expensesCards.length,
            itemBuilder: ((_, index) => ListTile(title: expensesCards[index])),
          ))
        ],
      ),
    );
  }
}

class ExpanseCard extends StatefulWidget {
  String? name;
  double? cost;
  int? month;
  String? uid;
  String? docid;
  int index;
  var reset;
  var delete;

  double? getCost() {
    return cost;
  }

  ExpanseCard({
    Key? key,
    this.name,
    this.cost,
    this.month,
    this.uid,
    this.docid,
    required this.index,
    required this.reset,
    required this.delete,
  }) : super(key: key);

  @override
  _ExpanseCardState createState() => _ExpanseCardState();
}

class _ExpanseCardState extends State<ExpanseCard> {
  // editing controller
  final TextEditingController nameCont = TextEditingController();
  final TextEditingController costCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? name = widget.name;
    double? cost = widget.cost;

    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                context: context,
                builder: (builder) => Container(
                      height: 340,
                      child: Column(children: [
                        Column(children: [
                          SizedBox(
                            height: 45,
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 0),
                                    decoration: BoxDecoration(),
                                    child: const Text(
                                      "\nEdit expense",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 40),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 8),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Expense',
                                    ),
                                    textInputAction: TextInputAction.next,
                                    controller: nameCont,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 8),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Cost',
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: costCont,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 120, vertical: 10),
                                  child: Row(children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (nameCont.text.isEmpty ||
                                              costCont.text.isEmpty) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Please Fill all the info!");
                                            return;
                                          }
                                          final name = nameCont.text;
                                          final double cost =
                                              double.parse(costCont.text);

                                          FirebaseFirestore firebaseFirestore =
                                              FirebaseFirestore.instance;
                                          Expense expenseModel = Expense(
                                              name: name,
                                              cost: cost,
                                              month: widget.month,
                                              uid: widget.uid,
                                              docid: widget.docid);

                                          await firebaseFirestore
                                              .collection("Expense")
                                              .doc(widget.docid)
                                              .set(expenseModel.toMap());
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Expense Saved Successfully :) ");

                                          var eCC = ExpanseCard(
                                            name: name,
                                            cost: cost,
                                            month: widget.month,
                                            uid: widget.uid,
                                            docid: widget.docid,
                                            index: widget.index,
                                            reset: widget.reset,
                                            delete: widget.delete,
                                          );

                                          widget.reset(eCC, widget.index);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Submit'),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.green),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        final docUser = FirebaseFirestore
                                            .instance
                                            .collection("Expense")
                                            .doc(widget.docid)
                                            .delete();
                                        widget.delete(widget.index);

                                        Navigator.pop(context);
                                      },
                                      child: const Text('Delete'),
                                    )
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ]),
                    ));
          },
          child: SizedBox(
            width: 300,
            height: 100,
            child: Center(
              // child: Text('A card that can be tapped'),
              child: Text("$name: $cost"),
            ),
          ),
        ),
      ),
    );
  }
}

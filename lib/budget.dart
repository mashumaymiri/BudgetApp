import 'dart:math';

import 'package:budget_app/Clasess/Expenses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Clasess/Month.dart';
import 'HomeScreen.dart';

List<Widget> expensesCards = [];

class BudgetPage extends StatefulWidget {
  //const MonthCard({Key? key}) : super(key: key);
  Month? month;

  BudgetPage({super.key, this.month});

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  void initState() {
    print(widget.month?.budget);
    print(widget.month);
    //print(ModalRoute.of(context)!.settings.arguments as Month);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Month;
    print(args.budget);
    var budget = args.budget!;
    var expenses = args.expenses!;
    final MONTH_NAME = args.name;

    List<Widget> expensesCards = [];
    // for (var expense in expenses) {
    //   expensesCards.add(ExpanseCard(
    //     name: expense.name,
    //     cost: expense.cost,
    //     month: expense.month,
    //     id: expense.id,
    //     index: expensesCards.length + 1
    //   ));
    // }
    for (int i=0;i<expenses.length;i++) {
      var expense = expenses.elementAt(i);
      expensesCards.add(ExpanseCard(
          name: expense?.name,
          cost: expense?.cost,
          month: expense?.month,
          id: expense?.id,
          index: i
      ));
    }

    print(expenses.length);
    print(expenses[0]);



    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(MONTH_NAME!),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // start modal func
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              context: context,
              builder: (builder) => Container(
                  height: 340,
                  child: Column(children: [
                    Column(children: [
                      SizedBox(
                        height: 45,
                        child: Container(
                          decoration: BoxDecoration(
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
                                child: Text(
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
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(),
                            ),
                            SizedBox(
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
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Budget',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint('submit');
                          },
                          child: const Text('Submit'),
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
                '\$$budget',
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
          Expanded(
            child: Column(
              children: expensesCards,
            ),
          )
        ],
      ),
    );
  }
}

class ExpanseCard extends StatelessWidget {
  String? name;
  double? cost;
  int? month;
  String? id;
  int index;

  // editing controller
  final TextEditingController nameCont = TextEditingController();
  final TextEditingController costCont = TextEditingController();

  ExpanseCard(
      {Key? key,
      required this.name,
      required this.cost,
      required this.month,
      required this.id,
      required this.index
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            // start modal func

            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                context: context,
                builder: (builder) => Container(
                      height: 340,
                      child: Column(children: [
                        Column(children: [
                          SizedBox(
                            height: 45,
                            child: Container(
                              decoration: BoxDecoration(
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
                                    child: Text(
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
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(),
                                ),
                                SizedBox(
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
                                      labelText: 'Budget',
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
                                  padding: EdgeInsets.all(10),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final name = nameCont.text;
                                      final double cost =
                                          double.parse(costCont.text);

                                      FirebaseFirestore firebaseFirestore =
                                          FirebaseFirestore.instance;

                                      Expense expenseModel = Expense(
                                          name: name,
                                          cost: cost,
                                          month: month,
                                          id: id);

                                      // writing all the values
                                      // userModel.email = user!.email;
                                      // userModel.uid = user.uid;
                                      // userModel.firstName = firstNameCont.text;
                                      // userModel.secondName =
                                      //     secondNameCont.text;
                                      // uuid.v4()
                                      await firebaseFirestore
                                          .collection("Expense")
                                          .doc(id)
                                          .set(expenseModel.toMap());
                                      Fluttertoast.showToast(
                                          msg:
                                              "Expense Saved Successfully :) ");

                                      //expensesCards.contains(id) ? expensesCards[expensesCards.indexWhere((v) => v == id)] = replaceWith : expensesCards;
                                      print(index);
                                      expensesCards[index] = ExpanseCard(
                                          name: name,
                                          cost: cost,
                                          month: month,
                                          id: id,
                                          index: expensesCards.length
                                      );




                                    },
                                    child: const Text('Submit'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ]),
                    ));

            //end modal func
            debugPrint('Card tapped.');
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


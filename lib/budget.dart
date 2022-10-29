import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Clasess/Month.dart';
import 'HomeScreen.dart';

List<Widget> expensesCards = [
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
  )
];

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

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('January'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

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

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Expense',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
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
                              }
                              ,
                              child: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ]),
              ));


          // end modal func
        },
        child: Icon(Icons.add),
      ),
      body: Column(children: [
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
        const ExpanseCard(),
      ]),
    );
  }
}


class ExpanseCard extends StatelessWidget {
  const ExpanseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
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
                  borderRadius: const BorderRadius.all(
                      Radius.circular(12)),
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
                              bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Container(
                                margin:
                                EdgeInsets.only(
                                    left: 0),
                                decoration:
                                BoxDecoration(),
                                child: Text(
                                  "\nAdd expense",
                                  textAlign: TextAlign
                                      .center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: 40),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Expense',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
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
                                  }
                                ,
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
          child: const SizedBox(
            width: 300,
            height: 100,
            child: Center(
              child: Text('A card that can be tapped'),
            ),
          ),
        ),
      ),
    );;
  }
}

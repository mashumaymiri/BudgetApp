import 'package:budget_app/Clasess/Expenses.dart';

class Month {
  String? name;
  int? order;
  int? budget;
  String? year;
  String? docid;
  String? uid;
  List<Expense>? expenses;

  Month({this.name, this.order, this.budget, this.year, this.expenses, this.docid, this.uid});

  // receiving data from server
  factory Month.fromMap(map) {
    return Month(
      name: map['name'],
      order: map['order'],
      budget: map['budget'],
      year: map['year'],
      expenses: map['expenses'],
      docid: map['docid'],
      uid: map['uid'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'order': order,
      'budget': budget,
      'year': year,
      'expenses': expenses,
      'docid': docid,
      'uid': uid,
    };
  }

}
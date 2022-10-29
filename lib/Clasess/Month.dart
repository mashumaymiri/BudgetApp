import 'package:budget_app/Clasess/Expenses.dart';

class Month {
  String? name;
  int? order;
  int? budget;
  String? year;
  List<Expense>? expenses;

  Month({this.name, this.order, this.budget, this.year, this.expenses});

}
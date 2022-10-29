class Expense {
  String? name;
  double? cost;
  int? month;
  String? id;

  Expense({required this.name, required this.cost, required this.month, required this.id});

  // receiving data from server
  factory Expense.fromMap(map) {
    return Expense(
      id: map['id'],
      name: map['name'],
      cost: map['cost'],
      month: map['month'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cost': cost,
      'month': month,
    };
  }
}
class Expense {
  String? name;
  double? cost;
  int? month;
  String? docid;
  String? uid;


  Expense({required this.name, required this.cost, required this.month, required this.docid, required this.uid});

  // receiving data from server
  factory Expense.fromMap(map) {
    return Expense(
      docid: map['docid'],
      uid: map['uid'],
      name: map['name'],
      cost: map['cost'],
      month: map['month'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'docid': docid,
      'uid': uid,
      'name': name,
      'cost': cost,
      'month': month,
    };
  }
}
class ExpenseModel {
  String? sId;
  String? title;
  String? paidBy;
  Map<String, dynamic>? owe;
  num? expense;
  String? groupId;
  int? category;
  String? date;

  ExpenseModel({
    this.sId,
    this.title,
    this.paidBy,
    this.owe,
    this.expense,
    this.groupId,
    this.category,
    this.date,
  });

  ExpenseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    paidBy = json['paidBy'];
    owe = json['owe'];
    expense = json['expense'];
    groupId = json['groupId'];
    category = json['category'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['paidBy'] = this.paidBy;
    data['owe'] = this.owe;
    data['expense'] = this.expense;
    data['groupId'] = this.groupId;
    data['category'] = this.category;
    data['date'] = this.date;
    return data;
  }
}

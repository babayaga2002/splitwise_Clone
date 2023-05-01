class UserModel {
  String? name;
  List<String>? friends;
  List<String>? groups;
  int? totalSpendings;
  List<int>? itemtypes;

  UserModel(
      {this.name,
        this.friends,
        this.groups,
        this.totalSpendings,
        this.itemtypes});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    friends = json['friends'].cast<String>();
    groups = json['groups'].cast<String>();
    totalSpendings = json['totalSpendings'];
    itemtypes = json['itemtypes'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['friends'] = this.friends;
    data['groups'] = this.groups;
    data['totalSpendings'] = this.totalSpendings;
    data['itemtypes'] = this.itemtypes;
    return data;
  }
}

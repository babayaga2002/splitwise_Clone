class UserModel {
  String? sId;
  String? name;
  List<String>? friends;
  List<String>? groups;
  int? totalSpendings;
  List<String>? items;
  int? iV;

  UserModel(
      {this.sId,
      this.name,
      this.friends,
      this.groups,
      this.totalSpendings,
      this.items,
      this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    friends = json['friends'].cast<String>();
    groups = json['groups'].cast<String>();
    items = json['items'].cast<String>();
    totalSpendings = json['totalSpendings'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['friends'] = this.friends;
    data['groups'] = this.groups;
    data['totalSpendings'] = this.totalSpendings;
    data['items']=this.items;
    data['__v'] = this.iV;
    return data;
  }
}

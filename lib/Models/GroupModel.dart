class GroupModel {
  String? sId;
  String? title;
  List<String>? members;
  List<String>? items;
  num? totalSpendings;
  Map<String, Map<String, num>>? memberOwes;

  GroupModel(
      {this.sId,
      this.title,
      this.members,
      this.items,
      this.totalSpendings,
      this.memberOwes});

  GroupModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    members = json['members'].cast<String>();
    items = json['items'].cast<String>();
    totalSpendings = json['totalSpendings'];
    memberOwes = {};
    if (json['memberOwes'] != null) {
      json['memberOwes']?.forEach((key, value) {
        memberOwes?.addEntries([MapEntry(key, Map<String, num>.from(value))]);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['members'] = this.members;
    data['items'] = this.items;
    data['totalSpendings'] = this.totalSpendings;
    data['memberOwes'] = this.memberOwes;
    return data;
  }
}
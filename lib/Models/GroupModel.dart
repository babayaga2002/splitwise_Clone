class GroupModel {
  String? sId;
  String? title;
  List<String>? members;
  List<String>? items;
  int? totalSpendings;
  Map<String,Map<String,int>>? memberOwes;

  GroupModel({this.sId, this.title, this.members, this.items, this.totalSpendings, this.memberOwes});

  GroupModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    members = json['members'].cast<String>();
    items = json['items'].cast<String>();
    totalSpendings = json['totalSpendings'];
    if(memberOwes!=null){
      memberOwes?.forEach((key, value) {
        memberOwes?[key]=value;
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
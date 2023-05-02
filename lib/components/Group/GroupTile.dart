import "package:flutter/material.dart";
import 'package:splitwise/components/Group/GroupPage.dart';
import 'dart:math';

import '../../Models/GroupModel.dart';

class GroupTile extends StatelessWidget {
  String title = "";
  String text1 = "";
  GroupModel model;

  GroupTile(
      {Key? key, required this.title, required this.text1, required this.model})
      : super(key: key);
  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  @override
  Widget build(BuildContext context) {
    int x=random(0, 5);
    return ListTile(
      leading: Image.asset(
        "images/grp${random(0, 4)}.png",
        width: 72,
        height: 72,
      ),
      title: Text(title,style: TextStyle(color: Colors.grey.shade300,fontSize: 16),),
      subtitle: Text(text1,style: TextStyle(color: Colors.grey.shade400,fontSize: 13),),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GroupPage(model: model,img: x)),
        );
      },
    );
  }
}

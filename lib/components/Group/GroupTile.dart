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
    return ListTile(
      leading: Image.asset(
        "path/${random(0, 5)}",
        width: 72,
        height: 72,
      ),
      title: Text(title),
      subtitle: Text(text1),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GroupPage(model: model)),
        );
      },
    );
  }
}

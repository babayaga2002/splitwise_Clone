import 'package:flutter/material.dart';
import 'dart:math';

class ActivityTile extends StatelessWidget {
  String title = "";
  String text1 = "";
  String text2 = "";
  bool isDeleted = false;
  ActivityTile(
      {Key? key,
      required this.title,
      required this.text1,
      required this.text2,
      required this.isDeleted})
      : super(key: key);

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        "path/${random(0, 5)}",
        width: 30,
        height: 72,
      ),
      title: Text(
        title,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: TextStyle(
                decoration: (isDeleted) ? TextDecoration.lineThrough : null),
          ),
          Text(text2),
        ],
      ),
      onTap: () {},
    );
  }
}

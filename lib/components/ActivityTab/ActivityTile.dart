import 'package:flutter/material.dart';
import 'dart:math';

class ActivityTile extends StatelessWidget {
  String title = "";
  String text1 = "";
  String text2 = "";
  Color color = Colors.green.shade400;
  bool isDeleted = false;
  ActivityTile(
      {Key? key,
      required this.title,
      required this.text1,
      required this.text2,
       required this.color,
      required this.isDeleted})
      : super(key: key);

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        "images/grp${random(0, 4)}.png",
        width: 30,
        height: 72,
      ),
      title: Text(
        title,style: TextStyle(color: Colors.grey.shade300,fontSize: 20)
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: TextStyle(color: Colors.green.shade400,fontSize: 16,decoration: (isDeleted) ? TextDecoration.lineThrough : null),
          ),
          Text(text2,style: TextStyle(color: Colors.grey.shade400,fontSize: 12),),
        ],
      ),
      onTap: () {},
    );
  }
}

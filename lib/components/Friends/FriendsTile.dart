import "package:flutter/material.dart";
import 'dart:math';

class FriendsTile extends StatelessWidget {
  String friendName="";
  String friendid="";

  FriendsTile({Key? key,required this.friendName,required this.friendid}) : super(key: key);

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset("path/${random(0, 5)}",width: 30,height: 30,),
      title: Text(friendName),
    );
  }
}

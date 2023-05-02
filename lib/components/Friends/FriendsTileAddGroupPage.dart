import "package:flutter/material.dart";
import 'dart:math';

class FriendsTileGroupPage extends StatelessWidget {
  String friendName="";
  String friendid="";


  FriendsTileGroupPage({Key? key,required this.friendName,required this.friendid}) : super(key: key);

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){

      },
      leading: Image.asset("path/${random(0, 5)}",width: 30,height: 30,),
      title: Text(friendName),
    );
  }
}

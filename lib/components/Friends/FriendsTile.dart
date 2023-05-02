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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.asset("images/frd${random(0, 4)}.png",width: 30,height: 30,),
        title: Text(friendName,style: TextStyle(color: Colors.grey,fontSize: 20),),
      ),
    );
  }
}

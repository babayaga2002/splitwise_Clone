import "package:flutter/material.dart";
import 'dart:math';

class FriendsTileAddGroupFriends extends StatefulWidget {
  String friendName="";
  String friendUid="";
  FriendsTileAddGroupFriends({Key? key,required this.friendName,required this.friendUid}) : super(key: key);

  @override
  State<FriendsTileAddGroupFriends> createState() =>
      _FriendsTileAddGroupFriendsState();
}

class _FriendsTileAddGroupFriendsState
    extends State<FriendsTileAddGroupFriends> {
  bool value = false;
  void onChanged(bool? val) {
    setState(() {
      value = val ?? false;
    });
  }
  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      secondary: Image.asset(
        "images/frd${random(0, 4)}.png",
        width: 30,
        height: 30,
      ),
      title: Text(
        widget.friendName,
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
    );
  }
}

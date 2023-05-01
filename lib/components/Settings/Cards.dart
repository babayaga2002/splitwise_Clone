import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/Settings/editProfile.dart';
import 'package:splitwise/Stores/loginStore.dart';

class CardOne extends StatefulWidget {
  const CardOne({Key? key}) : super(key: key);

  @override
  State<CardOne> createState() => _CardOneState();
}

class _CardOneState extends State<CardOne> {
  @override
  Widget build(BuildContext context) {
    var loginStore=context.read<LoginStore>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0,20,25,0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${loginStore.userData["name"]}",style: TextStyle(color: Colors.white,fontSize: 28,),softWrap: true,),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, EditProfile.id);
            },
            child: SizedBox(
              height: 90,
              width: 90,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage: loginStore.userData["image"]==null ? null :FileImage(
                      File(loginStore.userData["image"]!),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CardTwo extends StatefulWidget {
  const CardTwo({Key? key}) : super(key: key);

  @override
  State<CardTwo> createState() => _CardTwoState();
}

class _CardTwoState extends State<CardTwo> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(8),
        color: Colors.grey.shade800,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: (width - 100) / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(""),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Help",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
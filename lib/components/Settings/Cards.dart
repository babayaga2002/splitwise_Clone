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
    var loginStore = context.read<LoginStore>();
    print(loginStore.image.value);
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 20, 25, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loginStore.name.value,
                style: TextStyle(
                  color: Colors.green.shade400,
                  fontSize: 28,
                ),
                softWrap: true,
              ),
              SizedBox(height: 15,),
              Text(
                loginStore.phoneNumber.value,
                style: TextStyle(
                  color: Colors.green.shade400,
                  fontSize: 18,
                ),
                softWrap: true,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
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
                    backgroundImage: loginStore.image.value != ""
                        ? FileImage(
                            File(loginStore.image.value),
                          )
                        : null,
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
        width: width-100,
        padding: EdgeInsets.all(8),
        color: Colors.grey.shade800,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Help",
              style: TextStyle(color: Colors.white, fontSize: 20),
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}

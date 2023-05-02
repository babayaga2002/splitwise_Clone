import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/HomeScreen/ActivityPage.dart';
import 'package:splitwise/HomeScreen/FriendsPage.dart';
import 'package:splitwise/HomeScreen/HomeTab.dart';
import 'package:splitwise/Settings/settings.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:splitwise/Stores/homeStore.dart';

class HomePage extends StatefulWidget {
  static String id = "home_screen";
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tabs = [
    HomeTab(),
    FriendsTab(),
    ActivityTab(),
    Settings(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      var homeStore = context.read<HomeStore>();
      Timer(Duration(minutes: 3), () {
        homeStore.reset();
      });
      return SafeArea(
        child: Scaffold(
          body: tabs[currentIndex],
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: currentIndex,
            onTap: (i) {
              setState(() {
                currentIndex = i;
              });
            },
            unselectedItemColor: Colors.white,
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: Text("Groups"),
                selectedColor: Color(0xff3D83C3),
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: Icon(Icons.face),
                title: Text("Friends"),
                selectedColor: Color(0xff3D83C3),
              ),

              /// Search
              SalomonBottomBarItem(
                icon: Icon(Icons.search),
                title: Text("Activity"),
                selectedColor: Color(0xff3D83C3),
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
                selectedColor: Color(0xff3D83C3),
              ),
            ],
          ),
        ),
      );
    });
  }
}

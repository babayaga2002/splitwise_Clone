import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:splitwise/Stores/homeStore.dart';
import 'package:splitwise/components/FloatingActionButton.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/components/Shimmer.dart';
import '../components/AddingNew/Groups.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool isScrolled = false;
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        var homeStore = context.read<HomeStore>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff232932),
            elevation: 1,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AddNewGroupPage.id);
                  },
                  child: Icon(Icons.group_add),
                ),
              ),
            ],
          ),
          body: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.forward) {
                setState(() {
                  isScrolled = true;
                });
              } else if (notification.direction == ScrollDirection.reverse) {
                setState(() {
                  isScrolled = false;
                });
              }
              return true;
            },
            child: (homeStore.loadOperation == null)
                ? ListShimmer(
                    count: 2,
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                homeStore.titleString,
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(15.0),
                            //   child: GestureDetector(
                            //     onTap: () {},
                            //     child: Icon(
                            //       Icons.filter_drama,
                            //       color: Colors.grey,
                            //       size: 40,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        // ...homeStore.groupTiles,
                        (homeStore.groupOperation.error != null)
                            ? Center(
                                child: Text("Error Loading the Groups",style: TextStyle(color: Colors.red.shade400,fontSize: 17),),
                              )
                            : (homeStore.groupOperation.value == null &&
                                    homeStore.groupTiles == null)
                                ? ListShimmer(
                                    count: 4,
                                  )
                                : (homeStore.groupTiles.isEmpty)
                                    ? Center(
                                        child: Padding(
                                        padding: const EdgeInsets.all(40.0),
                                        child: Text(
                                          "No Groups to Display",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 20),
                                        ),
                                      ))
                                    : SizedBox(),
                        ...homeStore.groupTiles,
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AddNewGroupPage.id);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                            width: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.group_add,
                                  color: Colors.green,
                                ),
                                Text(
                                  "Start a new group",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 250,
                        ),
                      ],
                    ),
                  ),
          ),
          floatingActionButton: float(isScrolled, context),
        );
      },
    );
  }
}

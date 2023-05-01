import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/Stores/homeStore.dart';
import 'package:splitwise/components/AddingNew/Friends.dart';
import 'package:splitwise/components/Friends/FriendsTile.dart';

import '../components/AddingNew/Groups.dart';
import '../components/FloatingActionButton.dart';
import '../components/Group/GroupTile.dart';
import '../components/Shimmer.dart';

class FriendsTab extends StatefulWidget {
  static String id = "friends_tab";
  FriendsTab({Key? key}) : super(key: key);

  @override
  State<FriendsTab> createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab> {
  @override
  bool isScrolled = false;
  @override
  Widget build(BuildContext context) {
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
                Navigator.pushNamed(context, AddNewFriendPage.id);
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
                            style: TextStyle(color: Colors.grey, fontSize: 16),
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
                    (homeStore.friendOperation.error != null)
                        ? Center(
                      child: Text("Error Loading the Groups"),
                    )
                        : (homeStore.friendOperation.value == null &&
                        homeStore.friendsTilesActivityList == null)
                        ? ListShimmer(
                      count: 4,
                    )
                        : (homeStore.groupTiles.isEmpty)
                        ? Center(child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text("No Friends to Display",style: TextStyle(color: Colors.grey,fontSize: 20),),
                    ))
                        : SizedBox(),
                    ...homeStore.friendsTilesActivityList,
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AddNewFriendPage.id);
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
                              "Add New Friends",
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
      floatingActionButton: float(isScrolled,context),
    );
  }
}

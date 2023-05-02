import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/Stores/homeStore.dart';
import 'package:splitwise/components/AddingNew/Friends.dart';
import 'package:splitwise/components/Friends/FriendsTile.dart';

import '../Shimmer.dart';

class AddNewFriendsToGroup extends StatefulWidget {
  const AddNewFriendsToGroup({Key? key}) : super(key: key);

  @override
  State<AddNewFriendsToGroup> createState() => _AddNewFriendsToGroupState();
}

class _AddNewFriendsToGroupState extends State<AddNewFriendsToGroup> {
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
      body: (homeStore.loadOperation == null)
          ? ListShimmer(
              count: 2,
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  (homeStore.friendOperation.error != null)
                      ? Center(
                          child: Text("Error Loading the Friends"),
                        )
                      : (homeStore.groupOperation.value == null &&
                              homeStore.friendsTilesAddGroupPage == null)
                          ? ListShimmer(
                              count: 4,
                            )
                          : (homeStore.friendsTilesAddGroupPage.isEmpty)
                              ? Center(
                                  child: Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Text(
                                    "No Friends to Display",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                  ),
                                ))
                              : SizedBox(),
                  ...homeStore.friendsTilesAddGroupPage,
                  SizedBox(
                    height: 250,
                  ),
                ],
              ),
            ),
    );
  }
}

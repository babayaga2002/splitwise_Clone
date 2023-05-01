import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/Stores/homeStore.dart';
import 'package:splitwise/components/ActivityTab/ActivityTile.dart';

import '../components/FloatingActionButton.dart';
import '../components/Friends/FriendsTile.dart';
import '../components/Shimmer.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({Key? key}) : super(key: key);

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  bool isScrolled = false;
  @override
  Widget build(BuildContext context) {
    var homeStore = context.read<HomeStore>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff232932),
        elevation: 1,
        title: Text("Activity"),
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
                count: 10,
                height: 40,
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (homeStore.friendOperation.error != null)
                        ? Center(
                            child: Text("Error Loading the Groups"),
                          )
                        : (homeStore.friendOperation.value == null &&
                                homeStore.activityTiles == null)
                            ? ListShimmer(
                                count: 4,
                              )
                            : (homeStore.activityTiles.isEmpty)
                                ? Center(
                                    child: Padding(
                                    padding: const EdgeInsets.all(40.0),
                                    child: Text(
                                      "No Activity to Display",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                  ))
                                : SizedBox(),
                    ...homeStore.activityTiles,
                    SizedBox(
                      height: 250,
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: float(isScrolled, context),
    );
  }
}

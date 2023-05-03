import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/Stores/homeStore.dart';
import 'package:splitwise/components/AddingNew/Friends.dart';
import 'dart:math';

import '../../Service/api.dart';
import '../Shimmer.dart';

class AddNewFriendsToGroup extends StatefulWidget {
  String groupId;
  AddNewFriendsToGroup({Key? key, required this.groupId}) : super(key: key);

  @override
  State<AddNewFriendsToGroup> createState() => _AddNewFriendsToGroupState();
}

class _AddNewFriendsToGroupState extends State<AddNewFriendsToGroup> {
  late HomeStore homeStore;
  String? idGroup;
  @override
  void initState() {
    homeStore = context.read<HomeStore>();
    idGroup = widget.groupId;
    super.initState();
    calculate();
  }

  List<Widget> members = [];
  Map<String, bool> values = {};
  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  calculate() {
    setState(() {
      members = [];
    });
    Map<String, String> map = homeStore.friendsNameToUid;
    print(map);
    map.forEach((key, value) {
      setState(() {
        members.add(CheckboxListTile(
          value: values[key] ?? false,
          selected: values[key] ?? false,
          onChanged: (val) {
            setState(() {
              print(val);
              values[key] = val!;
              print(values);
            });
          },
          secondary: Image.asset(
            "images/frd${random(0, 4)}.png",
            width: 30,
            height: 30,
          ),
          title: Text(
            value,
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    calculate();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff232932),
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                for (MapEntry<String, bool> entry in values.entries) {
                  if (entry.value)
                    await APIService.addNewUserToGroup(
                        widget.groupId, entry.key);
                }
                Navigator.pop(context);
              },
              child: Icon(Icons.check),
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
                              homeStore.friendsTiles == null)
                          ? ListShimmer(
                              count: 4,
                            )
                          : (homeStore.friendsTiles.isEmpty)
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
                  Column(
                    children: members,
                  ),
                  SizedBox(
                    height: 250,
                  ),
                ],
              ),
            ),
    );
  }
}

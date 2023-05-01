import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/components/AddingNew/Groups.dart';


import '../../Stores/homeStore.dart';

class AppBar extends StatefulWidget {
  int currentIndex;
  AppBar({Key? key,required this.currentIndex}) : super(key: key);

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    if (widget.currentIndex == 0) {
      return AppBarGroups();
    } else if (widget.currentIndex == 1) {
      return AppBarFriends();
    } else
      return SizedBox();
  }
}

class AppBarGroups extends StatefulWidget {
  const AppBarGroups({Key? key}) : super(key: key);

  @override
  State<AppBarGroups> createState() => _AppBarGroupsState();
}

class _AppBarGroupsState extends State<AppBarGroups> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AddNewGroupPage.id);
          },
          icon: Icon(Icons.group_add_rounded),
        ),
      ],
    );
  }
}

class AppBarFriends extends StatefulWidget {
  const AppBarFriends({Key? key}) : super(key: key);

  @override
  State<AppBarFriends> createState() => _AppBarFriendsState();
}

class _AppBarFriendsState extends State<AppBarFriends> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.group_add_rounded),
        ),
      ],
    );;
  }
}

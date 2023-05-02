import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/Stores/homeStore.dart';
import 'package:splitwise/components/Settle-Up/RecordPayment.dart';

import '../../Models/GroupModel.dart';
import '../../Service/api.dart';

class SettleUp extends StatefulWidget {
  GroupModel? model;
  SettleUp({Key? key, required this.model}) : super(key: key);

  @override
  State<SettleUp> createState() => _SettleUpState();
}

class _SettleUpState extends State<SettleUp> {
  late HomeStore homeStore;
  @override
  void initState() {
    homeStore = context.read<HomeStore>();
    formWidgets();
    super.initState();
  }

  List<Widget> a = [];
  Map<String, num> finalMap = {};
  Map<String, String> nameMap = {};
  formWidgets() {
    Map<String, num>? mp = widget.model?.memberOwes?[homeStore.uid.value] ?? {};
    Map<String, String> nameToUid =
        homeStore.GroupMemberName[widget.model?.sId!] ?? {};
    mp.forEach((key, value) {
      if (nameToUid[key] != null && nameToUid[key] != "") {
        setState(() {
          nameMap[nameToUid[key]!] = key;
          finalMap[nameToUid[key]!] = value;
        });
      }
    });
    finalMap.forEach((key, value) {
      String text = "";
      if (value > 0) {
        text = "You are owed";
        setState(() {
          a.add(ListTile(
            leading: Text(
              key,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  value.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            ),
            onTap: () {
              showErrorDialog(context, widget.model!.sId!, value, key);
            },
          ));
        });
      } else {
        text = "You borrowed";
        setState(() {
          a.add(ListTile(
            leading: Text(
              key,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  value.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecordPayment(
                          value: -value,
                          ower: key,
                          borrower: "You",
                          groupId: widget.model!.sId!,
                          borrowerid: homeStore.uid.value,
                          owerid: nameMap[key] ?? "",
                        )),
              );
            },
          ));
        });
      }
    });
  }

  void showErrorDialog(
      BuildContext context, String groupId, num value, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Payment"),
          content: Text("You got cash payment"),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Done'),
              onPressed: () async {
                await APIService.settleUp(
                    groupId, nameMap[name] ?? "", homeStore.uid.value, value);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.close),
        ),
        title: Text("Select a balance to Settle"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: a,
      ),
    ));
  }
}

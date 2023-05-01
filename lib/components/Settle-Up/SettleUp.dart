import 'package:flutter/material.dart';
import 'package:splitwise/components/Settle-Up/RecordPayment.dart';

class SettleUp extends StatefulWidget {
  Map<String, int> oweMap;
  SettleUp({Key? key, required this.oweMap}) : super(key: key);

  @override
  State<SettleUp> createState() => _SettleUpState();
}

class _SettleUpState extends State<SettleUp> {
  @override
  void initState() {
    formWidgets();
    super.initState();
  }

  List<Widget> a = [];
  formWidgets() {
    widget.oweMap.forEach((key, value) {
      String text = "";
      if (value > 0) {
        text = "You are owed";
        setState(() {
          a.add(ListTile(
            leading: Text(key),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text(text), Text(value.toString())],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecordPayment(
                        value: value, ower: "You", borrower: key)),
              );
            },
          ));
        });
      } else {
        text = "You borrowed";
        setState(() {
          a.add(ListTile(
            leading: Text(key),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text(text), Text((-value).toString())],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecordPayment(
                        value: -value, ower: key, borrower: "You")),
              );
            },
          ));
        });
      }
    });
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

import 'package:flutter/material.dart';

class ExpenseTile extends StatefulWidget {
  const ExpenseTile({Key? key}) : super(key: key);

  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Nov"),
          Text("22"),
        ],
      ),
      title: Text("Condoms"),
      subtitle: Text("You paid bsdj"),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("You lent"),
          Text("fdhs")
        ],
      ),
    );
  }
}

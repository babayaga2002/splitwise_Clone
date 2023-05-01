import 'package:flutter/material.dart';

class ExpenseTile extends StatefulWidget {
  String month="";
  String date="";
  String paidBy="";
  String amountPaid="";
  int amount=0;
  String title="";
  ExpenseTile({Key? key,required this.date,required this.month,required this.amount,required this.amountPaid,required this.paidBy,required this.title}) : super(key: key);

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
          Text(widget.month),
          Text(widget.date),
        ],
      ),
      title: Text(widget.title),
      subtitle: Text(widget.paidBy+" paid "+widget.amountPaid),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (widget.amount>0)?Text("You lent"):Text("You Borrowed"),
          Text(widget.amount.toString()),
        ],
      ),
    );
  }
}

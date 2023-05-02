import 'package:flutter/material.dart';

class ExpenseTile extends StatefulWidget {
  String month="";
  String date="";
  String paidBy="";
  String amountPaid="";
  num amount=0;
  String title="";
  ExpenseTile({Key? key,required this.date,required this.month,required this.amount,required this.amountPaid,required this.paidBy,required this.title}) : super(key: key);

  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.month,style: TextStyle(color: Colors.grey.shade400,fontSize: 16),),
            SizedBox(height: 4,),
            Text(widget.date,style: TextStyle(color: Colors.grey.shade400,fontSize: 18),),
          ],
        ),
        title: Text(widget.title,style: TextStyle(color: Colors.grey.shade300,fontSize: 20)),
        subtitle: Text(widget.paidBy +" paid "+widget.amountPaid,style: TextStyle(color: Colors.grey.shade400,fontSize: 13),),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            (widget.amount>0)?Text("You lent",style: TextStyle(color: Colors.grey.shade400,fontSize: 13),):Text("You Borrowed",style: TextStyle(color: Colors.grey.shade400,fontSize: 16),),
            SizedBox(height: 4,),
            Text(widget.amount.toString(),style: TextStyle(color: Colors.grey.shade400,fontSize: 18),),
          ],
        ),
      ),
    );
  }
}

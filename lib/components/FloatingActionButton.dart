import 'package:flutter/material.dart';
import 'package:splitwise/components/addExpense/addExpense.dart';

FloatingActionButton float(bool isScrolled,BuildContext context) {
  return FloatingActionButton.extended(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddExpense()),
      );
    },
    label: Text("Add Expense"),
    icon: Icon(Icons.add),
    isExtended: isScrolled,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );
}

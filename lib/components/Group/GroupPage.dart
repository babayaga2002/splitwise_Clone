import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/Models/ExpenseModel.dart';
import 'package:splitwise/Service/api.dart';
import 'package:splitwise/Stores/homeStore.dart';
import 'package:splitwise/components/Group/AddNewMembersToGroup.dart';
import 'package:splitwise/components/Group/ExpenseTile.dart';
import 'package:splitwise/components/Settle-Up/SettleUp.dart';

import '../../Models/GroupModel.dart';
import '../Shimmer.dart';

class GroupPage extends StatefulWidget {
  GroupModel model;
  int img;
  GroupPage({Key? key, required this.model, required this.img})
      : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  List<String> _buttonData = [
    "Settle Up",
    "Balances",
    "Totals",
    "Charts",
    "Export"
  ];

  late HomeStore homeStore;
  @override
  void initState() {
    homeStore = context.read<HomeStore>();
    calculate();
    super.initState();
  }

  List<Widget> expenseTiles = [];
  List<Widget> data = [];
  Map<String, num> finalMap = {};
  void calculate() {
    setState(() {
      data = [];
    });
    Map<String, num>? mp = widget.model.memberOwes?[homeStore.uid.value] ?? {};
    Map<String, String> nameToUid =
        homeStore.GroupMemberName[widget.model.sId!] ?? {};
    mp.forEach((key, value) {
      if (nameToUid[key] != null && nameToUid[key] != "") {
        setState(() {
          finalMap[nameToUid[key]!] = value;
        });
      }
    });
    print(finalMap);
    finalMap.forEach((key, value) {
      if (value > 0) {
        setState(() {
          data.add(Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 5, bottom: 5),
                child: Text(
                  key + " owes you " + value.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ],
          ));
        });
      } else if (value < 0) {
        setState(() {
          data.add(Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 5, bottom: 5),
                child: Text(
                  "You owe " + key + " " + (-value).toString(),
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ],
          ));
        });
      }
    });
    if (data.length == 1) {
      setState(() {
        data.add(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 5, bottom: 5),
              child: Text(
                "Settled-up",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 16),
              ),
            ),
          ],
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 25, bottom: 10),
                    child: Image.asset(
                      "images/grp${widget.img}.png",
                      width: 72,
                      height: 72,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 40, bottom: 8),
                    child: Text(
                      widget.model.title!,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ],
              ),
              (data.isNotEmpty)
                  ? Column(mainAxisSize: MainAxisSize.min, children: data)
                  : SizedBox(),
              Container(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _buttonData.map((button) {
                    int index = _buttonData.indexOf(button);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettleUp(model: widget.model,),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (_buttonData[index] == "Settle Up")
                                ? Colors.orange.shade300
                                : Colors.grey.shade600,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _buttonData[index],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              FutureBuilder(
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final data = snapshot.data as List<Widget>;
                      if (data.length > 1)
                        return Column(
                          children: data,
                        );
                      else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "All Settled Up",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ],
                        );
                      }
                    }
                  }
                  return ListShimmer(
                    count: 3,
                    height: 40,
                  );
                },
                future: getData(widget.model),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddNewMembersToGroup(model: widget.model)),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.group_add,
                        color: Colors.green,
                      ),
                      Text(
                        "Add Members to Group",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               AddNewMembersToGroup(model: widget.model)),
              //     );
              //   },
              //   child: Container(
              //     padding: EdgeInsets.all(8),
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         color: Colors.green,
              //         width: 2,
              //       ),
              //     ),
              //     width: 250,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         Icon(
              //           Icons.group_add,
              //           color: Colors.green,
              //         ),
              //         Text(
              //           "Add Friends to Group",
              //           style: TextStyle(color: Colors.green),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  getData(GroupModel model) async {
    List<ExpenseModel> expenses =
        await APIService.getGroupExpenses(widget.model.sId!);
    List<Widget> a = [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40.0, top: 5, bottom: 5),
            child: Text(
              "May 2023",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    ];
    expenses.forEach((element) {
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(element.date!);
      num x = element.owe?[homeStore.uid.value] ?? 0;
      if (x < 0) {
        num amount = element.expense! + x;
        a.add(ExpenseTile(
            date: parseDate.day.toString(),
            month: monthsMap[parseDate.month] ?? "",
            amount: amount,
            amountPaid: element.expense!.toString(),
            paidBy: homeStore.GroupMemberName[model.sId]?[element.paidBy] ?? "",
            title: element.title ?? ""));
      } else if (x > 0) {
        a.add(ExpenseTile(
            date: parseDate.day.toString(),
            month: monthsMap[parseDate.month] ?? "",
            amount: -x,
            amountPaid: element.expense!.toString(),
            paidBy: homeStore.GroupMemberName[model.sId]?[element.paidBy] ?? "",
            title: element.title ?? ""));
      }
    });
    return a;
  }

  Map<int, String> monthsMap = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };
}

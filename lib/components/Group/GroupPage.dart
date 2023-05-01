import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/Models/ExpenseModel.dart';
import 'package:splitwise/Service/api.dart';
import 'package:splitwise/Stores/homeStore.dart';
import 'package:splitwise/components/Group/AddNewMembersToGroup.dart';
import 'package:splitwise/components/Group/ExpenseTile.dart';

import '../../Models/GroupModel.dart';
import '../Shimmer.dart';

class GroupPage extends StatefulWidget {
  GroupModel model;
  GroupPage({Key? key, required this.model}) : super(key: key);

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
    super.initState();
    homeStore = context.read<HomeStore>();
  }

  List<Widget> expenseTiles = [];
  List<String> data = [];
  Map<String, int> finalMap = {};
  void calculate() {
    Map<String, int> mp = widget.model.memberOwes![homeStore.uid]!;
    Map<String, String> nameToUid = homeStore.friendsNameToUid;
    mp.forEach((key, value) {
      if (nameToUid[key] != ""){
        setState(() {
          finalMap[nameToUid[key]!] = value;
        });
      }
    });

    finalMap.forEach((key, value) {
      if (value > 0) {
        data.add(key + " owes you " + value.toString());
      } else if (value < 0) {
        data.add("You owe " + key + " " + (-value).toString());
      }
      if (data.isEmpty) data.add("Settled-up");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 30, bottom: 8),
                child: Text(widget.model.title!),
              ),
              ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 30, bottom: 8),
                      child: Text(data[index]),
                    );
                  }),
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
                      return ListView(
                        children: data,
                      );
                    }
                  }
                  return ListShimmer(
                    count: 3,
                    height: 40,
                  );
                },
                future: getData(),
              ),
              Container(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _buttonData.map((icon) {
                    int index = _buttonData.indexOf(icon);
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: (_buttonData[index] == "Settle Up")
                              ? Colors.orange
                              : Colors.transparent,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _buttonData[index],
                                style: TextStyle(
                                  color: Colors.grey,
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
                        "Start a new group",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getData() async {
    List<ExpenseModel> expenses =
        await APIService.getGroupExpenses(widget.model.sId!);
    List<Widget> a = [];
    String uid = homeStore.uid.value;
    expenses.forEach((element) {
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(element.date!);
      element.owe!.forEach((key, value) {
        a.add(ExpenseTile(
            date: parseDate.day.toString(),
            month: monthsMap[parseDate.month]!,
            amount: element.owe![uid]!,
            amountPaid: element.expense!.toString(),
            paidBy: homeStore.friendsNameToUid[element.paidBy!]!,
            title: element.title!));
      });
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

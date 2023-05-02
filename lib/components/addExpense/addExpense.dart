import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/Service/api.dart';
import 'package:splitwise/Stores/homeStore.dart';

import '../../Models/GroupModel.dart';
import '../Shimmer.dart';


class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  @override
  String expenseTitle = "";
  String amount = "";
  int selectedIndex = 0;
  int index=-1;
  GroupModel? selectedModel;
  List<IconData> _iconData = [
    Icons.add,
    Icons.abc,
    Icons.ac_unit,
    Icons.access_alarm_outlined
  ];
  List<String> _iconString = ["Trip", "Home", "Couple", "Other"];
  List<String> buttonTitles = ["Equally", "By Percentage", "Manually"];

  Widget build(BuildContext context) {
    var homeStore = context.read<HomeStore>();
    return Observer(
      builder: (context){
        return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.close),
                ),
                title: Text("Add Expense"),
                actions: [
                  TextButton(
                    onPressed: () async {
                      if (expenseTitle == "" || int.parse(amount) == 0)
                        showErrorDialog(context);
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("With You and: ",style: TextStyle(color: Colors.grey,fontSize: 18),),
                          Container(
                            height: 60,
                            width: 130,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: (homeStore.groupOperation!=null && homeStore.groupOperation.value!= null &&homeStore.groupOperation.value!.isNotEmpty)?homeStore.groupOperation.value!.map((model){
                                int indexof = homeStore.groupOperation.value!.indexOf(model);
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      index=indexof;
                                      selectedModel=model;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: (index==indexof)?Colors.green.shade300:Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            model!.title!,
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
                              }).toList():[SizedBox()],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 90.0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                        ),
                        child: TextField(
                          autofocus: true,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              BorderSide(width: 2, color: Color(0xff3D83C3)),
                            ),
                            labelText: "Expense Title",
                            labelStyle: TextStyle(color: Color(0xff3D83C3)),
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: Color(0xff3D83C3),
                            ),
                          ),
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          onChanged: (value) {
                            setState(() {
                              expenseTitle = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4,
                            left: 15.0,
                            right: 15.0,
                          ),
                          child: Text(
                            "Category",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 60,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _iconData.map((icon) {
                          int index = _iconData.indexOf(icon);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: (selectedIndex==index)?Colors.green.shade300:Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _iconData[index],
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      _iconString[index],
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
                    Container(
                      height: 90.0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 15.0,
                          right: 15.0,
                        ),
                        child: TextField(
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              BorderSide(width: 2, color: Color(0xff3D83C3)),
                            ),
                            labelText: "Amount",
                            labelStyle: TextStyle(color: Color(0xff3D83C3)),
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: Color(0xff3D83C3),
                            ),
                          ),
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          onChanged: (value) {
                            setState(() {
                              amount = value;
                            });
                            print(amount);
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Paid by You and Share",style: TextStyle(color: Colors.grey,fontSize: 13),),
                        TextButton(
                            onPressed: () {
                              if(expenseTitle=="" || amount=="" || index==-1 || selectedModel==null) showErrorDialog(context);
                              else showPicker(context,expenseTitle,amount,selectedModel!,selectedIndex,homeStore.uid.value);
                            },
                            child: Text(buttonTitles[homeStore.indexAddExpense])),
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("You haven't entered a title and amount yet!"),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showPicker(BuildContext context,String Title,String amount,GroupModel model,int category,String uid) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          var homeStore = bc.read<HomeStore>();
          return Observer(
            builder: (bc) {
              return SafeArea(
                child: Container(
                  color: Colors.grey.shade600,
                  child: new Wrap(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          GestureDetector(
                              onTap: () {
                                homeStore.setIndex(0);
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: (homeStore.indexAddExpense == 0)
                                      ? Border(
                                          bottom: BorderSide(
                                            color: Colors.white,
                                            width: 2.0,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Text(buttonTitles[0]),
                              )),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  homeStore.setIndex(1);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: (homeStore.indexAddExpense == 1)
                                      ? Border(
                                          bottom: BorderSide(
                                            color: Colors.white,
                                            width: 2.0,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Text(buttonTitles[1]),
                              )),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  homeStore.setIndex(2);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: (homeStore.indexAddExpense == 2)
                                      ? Border(
                                          bottom: BorderSide(
                                            color: Colors.white,
                                            width: 2.0,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Text(buttonTitles[2]),
                              )),
                        ],
                      ),
                      if(homeStore.indexAddExpense==0) EquallyTab(model: model, title: Title, amount: amount, category: category, uid: uid),
                      if(homeStore.indexAddExpense==1) PercentageTab(model: model, title: Title, amount: amount, category: category, uid: uid),
                      if(homeStore.indexAddExpense==2) ManualTab(model: model, title: Title, amount: amount, category: category, uid: uid),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}

class EquallyTab extends StatefulWidget {
  GroupModel? model;
  String? title;
  String amount;
  int category;
  String uid;
  EquallyTab({Key? key,required this.model,required this.title,required this.amount,required this.category,required this.uid}) : super(key: key);

  @override
  State<EquallyTab> createState() => _EquallyTabState();
}

class _EquallyTabState extends State<EquallyTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 80,),
          Text("Everyone in the Group pays Equally"),
          SizedBox(height: 80,),
          GestureDetector(
            onTap: () {
              APIService.addNewExpensePaidEqually(widget.model!.sId!, widget.title!, widget.category, widget.uid, int.parse(widget.amount));
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.money,
                    color: Colors.black,
                  ),
                  Text(
                    "Done",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }
}

class ManualTab extends StatefulWidget {
  GroupModel? model;
  String? title;
  String amount;
  int category;
  String uid;
  ManualTab({Key? key,required this.model,required this.title,required this.amount,required this.category,required this.uid}) : super(key: key);

  @override
  State<ManualTab> createState() => _ManualTabState();
}

class _ManualTabState extends State<ManualTab> {
  @override
  Map<String,int> values={};
  Widget build(BuildContext context) {
    return FutureBuilder(
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
            final data = snapshot.data as Map<String,String>;
            List<Widget>a=[];
            data.forEach((key, value) {
              a.add(ListTile(leading: Text(value),trailing: TextField(
                style: TextStyle(color: Colors.white),
                onChanged: (amount) {
                  setState(() {
                    values[key]=int.parse(amount);
                  });
                },
              ),));
            });
            a.add(GestureDetector(
              onTap: () {
                APIService.addNewExpensePaidManually(widget.model!.sId!, widget.title!, widget.category, widget.uid, int.parse(widget.amount), values);
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 30,bottom: 20),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.group_add,
                      color: Colors.black,
                    ),
                    Text(
                      "Done",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),);
            return Column(
              children: a,
            );
          }
        }
        return ListShimmer(
          count: 3,
          height: 40,
        );
      },
      future: getData(),
    );
  }
  getData()async{
    Map<String,String>m={};
    widget.model?.members!.forEach((element) async{
      String name= await APIService.getUserName(element);
      if(name!=null){
        m[element]=name;
      }
    });
    return m;
  }
}

class PercentageTab extends StatefulWidget {
  GroupModel? model;
  String? title;
  String amount;
  int category;
  String uid;
  PercentageTab({Key? key,required this.model,required this.title,required this.amount,required this.category,required this.uid}) : super(key: key);

  @override
  State<PercentageTab> createState() => _PercentageTabState();
}

class _PercentageTabState extends State<PercentageTab> {
  @override
  Map<String,int> values={};
  Widget build(BuildContext context) {
    return FutureBuilder(
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
            final data = snapshot.data as Map<String,String>;
            List<Widget>a=[];
            data.forEach((key, value) {
              a.add(ListTile(leading: Text(value),trailing: TextField(
                style: TextStyle(color: Colors.white),
                onChanged: (amount) {
                  setState(() {
                    values[key]=int.parse(amount);
                  });
                },
              ),));
            });
            a.add(GestureDetector(
              onTap: () {
                APIService.addNewExpensePaidPercentage(widget.model!.sId!, widget.title!, widget.category, widget.uid, int.parse(widget.amount), values);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.group_add,
                      color: Colors.black,
                    ),
                    Text(
                      "Done",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),);
            return Column(
              children: a,
            );
          }
        }
        return ListShimmer(
          count: 3,
          height: 40,
        );
      },
      future: getData(),
    );
  }
  getData()async{
    Map<String,String>m={};
    widget.model?.members?.forEach((element) async{
      String name= await APIService.getUserName(element);
      if(name!=null){
        m[element]=name;
      }
    });
    return m;
  }
}


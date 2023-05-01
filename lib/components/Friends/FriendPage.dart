import 'package:flutter/material.dart';
import 'package:splitwise/components/Friends/ExpenseTile.dart';

import '../Shimmer.dart';



class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  List<String> _buttonData = [
    "Settle Up",
    "Balances",
    "Totals",
    "Charts",
    "Export"
  ];
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
                child: Text(""),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 30, bottom: 8),
                child: Text(""),
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
              SizedBox(height: 20,),
              Text("Nov"),
              ListShimmer(
                count: 5,
                height: 120,
              ),
              ExpenseTile(),
            ],
          ),
        ),
      ),
    );
  }
}

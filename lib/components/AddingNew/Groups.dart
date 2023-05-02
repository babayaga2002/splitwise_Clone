import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Service/api.dart';

class AddNewGroupPage extends StatefulWidget {
  AddNewGroupPage({Key? key}) : super(key: key);
  static String id = "addnewgroup";
  @override
  State<AddNewGroupPage> createState() => _AddNewGroupPageState();
}

class _AddNewGroupPageState extends State<AddNewGroupPage> {
  @override
  String GroupName = "";
  int selectedIndex = 0;
  List<Color> _itemColors = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent
  ];
  List<IconData> _iconData = [
    Icons.add,
    Icons.abc,
    Icons.ac_unit,
    Icons.access_alarm_outlined
  ];
  List<String> _iconString = ["Trip", "Home", "Couple", "Other"];
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
          title: Text("Create a group"),
          actions: [
            TextButton(
              onPressed: () async {
                if(GroupName==""){
                  showErrorDialog(context);
                }
                else{
                  if(await APIService.addNewGroup(GroupName)){
                    Navigator.pop(context);
                  }
                }
              },
              child: Text(
                "Done",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 90.0,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
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
                    labelText: "Group Name",
                    labelStyle: TextStyle(color: Color(0xff3D83C3)),
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Color(0xff3D83C3),
                    ),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  onChanged: (value) {
                    GroupName = value;
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
                    "Type",
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
                        selectedIndex=index;
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
          ],
        ),
      ),
    );
  }
  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("You haven't entered a name for your group yet!"),
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
}




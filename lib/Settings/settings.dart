import 'package:flutter/material.dart';
import '../components/Settings/Cards.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  static String id = 'settings';
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          CardOne(),
          SizedBox(
            height: 0.03625 * height,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardTwo(),
                CardTwo(),
                CardTwo(),
              ],
            ),
          ),
          SizedBox(
            height: 0.015 * height,
          ),
          Divider(
            thickness: 3,
            color: Colors.grey,
          ),
          ListTile(
            leading: const Icon(Icons.add,color: Colors.white,),
            title: const Text(
              'Messages',
              style: TextStyle(color: Colors.white,fontSize: 20),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.add,color: Colors.white,),
            title: const Text(
              'Messages',
              style: TextStyle(color: Colors.white,fontSize: 20),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.add,color: Colors.white,),
            title: const Text(
              'Messages',
              style: TextStyle(color: Colors.white,fontSize: 20),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.add,color: Colors.white,),
            title: const Text(
              'Messages',
              style: TextStyle(color: Colors.white,fontSize: 20),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/Stores/loginStore.dart';
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
    var loginStore=context.read<LoginStore>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff232932),
        elevation: 1,
        title: Text("Account",style: TextStyle(color: Colors.white,fontSize: 25),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardOne(),
            SizedBox(
              height: 0.03625 * height,
            ),
            // ListTile(
            //   leading: const Icon(Icons.qr_code,color: Colors.white,),
            //   title: const Text(
            //     'Scan Code',
            //     style: TextStyle(color: Colors.white,fontSize: 20),
            //   ),
            //   onTap: () {},
            // ),
            SizedBox(
              height: 0.01 * height,
            ),
            Divider(
              thickness: 3,
              color: Colors.green.shade400,
            ),
            ListTile(
              leading: Icon(Icons.logout,color: Colors.green.shade200,),
              title: Text(
                'Log Out',
                style: TextStyle(color: Colors.green.shade200,fontSize: 20),
              ),
              onTap: () {
                loginStore.logout();
                while(Navigator.canPop(context)){ // Navigator.canPop return true if can pop
                  Navigator.pop(context);
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

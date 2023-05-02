import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:splitwise/HomeScreen/HomePage.dart';
import 'package:splitwise/Service/api.dart';
import 'package:splitwise/Stores/loginStore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signIn.dart';

class SignUp extends StatefulWidget {
  static String id = 'sign_up';
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = '';
  String name = '';
  String address = "";
  String district = "";
  String state = "";
  String pincode = "";

  String referral = '';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 0.07875 * height,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'NexuSAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 46,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: 0.093 * height,
              ),
              Container(
                height: 70.0,
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
                            BorderSide(width: 3, color: Color(0xff3D83C3)),
                      ),
                      labelText: "Name",
                      labelStyle: TextStyle(color: Color(0xff3D83C3)),
                      prefixIcon: Icon(
                        Icons.account_circle,
                        color: Color(0xff3D83C3),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      name = value;
                      print(name);
                    },
                  ),
                ),
              ),
              // SizedBox(
              //   height: 0.06125 * height,
              // ),
              // TextButton(
              //   onPressed: () {
              //     showDialog(
              //         context: context,
              //         builder: (context) {
              //           return AlertDialog(
              //             title: Text(
              //               'Enter Referral Code',
              //               textAlign: TextAlign.center,
              //               style: TextStyle(
              //                 fontSize: 14,
              //               ),
              //             ),
              //             content: Container(
              //               height: 0.075 * height,
              //               width: 0.777 * width,
              //               color: _colorFromHex('#E0E0E0'),
              //               child: TextField(
              //                 cursorColor: _colorFromHex('#E46D0C'),
              //                 onChanged: (value) {
              //                   if (value.length > 8) {
              //                     setState(() {
              //                       referral = value;
              //                     });
              //                   }
              //                 },
              //                 keyboardType: TextInputType.emailAddress,
              //                 decoration: InputDecoration(
              //                   focusedBorder: UnderlineInputBorder(
              //                     borderSide: BorderSide(
              //                       color: _colorFromHex('#E46D0C'),
              //                     ),
              //                   ),
              //                   border: InputBorder.none,
              //                   filled: true,
              //                   focusColor: Colors.white,
              //                 ),
              //               ),
              //             ),
              //             actions: [
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   TextButton(
              //                     onPressed: () async {
              //                       Navigator.pop(context);
              //                     },
              //                     child: Text(
              //                       'Apply',
              //                       style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         color: Colors.white,
              //                       ),
              //                     ),
              //                     style: flatButtonStyle,
              //                   ),
              //                 ],
              //               )
              //             ],
              //           );
              //         });
              //   },
              //   child: Text(
              //     'I Have A Referral Code!',
              //     style: TextStyle(
              //       fontSize: 12,
              //       decoration: TextDecoration.underline,
              //       color: _colorFromHex('#0EA0DD'),
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 0.04625 * height,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 0),
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
              SizedBox(
                height: 0.035 * height,
              ),
              // GestureDetector(
              //   onTap: (){
              //     Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
              //   },
              //   child: Text(
              //     'Skip',
              //     style: TextStyle(
              //       color: Color(0xff3D83C3),
              //       fontSize: 18,
              //     ),
              //   ),
              // ),
              GestureDetector(
                onTap: () async {
                  context.read<LoginStore>().saveNameToPrefernces(name);
                  await APIService.addNewUser(name);
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomePage.id, (route) => false);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 92, vertical: 20),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xff3D83C3),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

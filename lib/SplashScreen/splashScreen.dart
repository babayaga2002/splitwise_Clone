// ignore_for_file: use_key_in_widget_constructors, unnecessary_new, prefer_const_constructors, file_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:logger/logger.dart';
import 'package:splitwise/HomeScreen/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitwise/OnBoardingScreens/onboardingScreen.dart';
import 'package:splitwise/SignUp/signIn.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'Splash_Screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String authToken = '';
  String userID = '';
  bool firstcall = true;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return Timer(_duration, getValidation);
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  Future getValidation() async {
    firstcall = await IsFirstRun.isFirstRun();
    print("call" + firstcall.toString());
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      authToken = (preferences.getString('auth') == null
          ? ""
          : preferences.getString('auth'))!;
      // authToken = obtainedPhoneNumber ?? '0';
    });
    Logger().d(authToken);
    // String? obtainedPhoneNumber = preferences.getString('driverPhoneNumber');

    if (firstcall == true) {
      print("1");
      Navigator.pushReplacementNamed(context, OnboardingScreens.id);
    } else {
      print("2");
      Logger().d(authToken);
      if (authToken == '') {
        print("3");
        Navigator.pushReplacementNamed(context, SignIn.id);
      } else {
        print("4");
        Navigator.pushReplacementNamed(context, HomePage.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              width: 0.2 * width,
              height: 0.2 * height,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'NexuSAR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 46,
                  // fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

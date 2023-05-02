import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitwise/HomeScreen/HomePage.dart';
import 'package:splitwise/SignUp/signIn.dart';
import 'package:splitwise/constants.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({Key? key}) : super(key: key);
  static String id = 'onboarding_1';

  @override
  _OnboardingScreensState createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  late PageController _onboarding;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _onboarding = PageController();
  }

  @override
  void dispose() {
    _onboarding.dispose();
    super.dispose();
  }

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  nextFunction() {
    _onboarding.nextPage(duration: _kDuration, curve: _kCurve);
  }

  previousFunction() {
    _onboarding.previousPage(duration: _kDuration, curve: _kCurve);
  }

  static const _kDuration = const Duration(milliseconds: 500);
  static const _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (BuildContext context, child) => Scaffold(
        body: Container(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: PageView(
                      onPageChanged: onChangedFunction,
                      controller: _onboarding,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/logo.png'),
                            SizedBox(
                              height: 94.h,
                            ),
                            Text(
                              'Accept your Money',
                              style: TextStyle(
                                fontFamily: 'SF UI Display',
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 33.h,
                            ),
                            SizedBox(
                              width: 300.w,
                              height: 60.h,
                              child: Text(
                                "Manage Money Like a Pro",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'SF UI Display',
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // TextButton(
                            //   onPressed: () async {
                            //     final SharedPreferences preferences =
                            //         await SharedPreferences.getInstance();
                            //     int? checker =
                            //         preferences.getInt('firsttime') == null
                            //             ? 0
                            //             : preferences.getInt('firsttime');
                            //     Logger().d(checker);
                            //     preferences.setInt('firsttime', checker!);
                            //     if (checker == 1) {
                            //       Navigator.pushReplacementNamed(
                            //           context, HomePage.id);
                            //     } else {
                            //       Navigator.pushReplacementNamed(
                            //         context,
                            //         SignIn.id,
                            //       );
                            //     }
                            //   },
                            //   child: Text(
                            //     'Skip',
                            //     style: TextStyle(
                            //       fontSize: 17.h,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/logo.png',
                              scale: 1.1,
                            ),
                            SizedBox(
                              height: 94.h,
                            ),
                            Text(
                              'Tracking Realtime',
                              style: TextStyle(
                                fontFamily: 'SF UI Display',
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 33.sp,
                            ),
                            SizedBox(
                              width: 300.w,
                              height: 60.h,
                              child: Text(
                                "Track your expenses and payments in time.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'SF UI Display',
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // TextButton(
                            //   onPressed: () async {
                            //     final SharedPreferences preferences =
                            //         await SharedPreferences.getInstance();
                            //     int? checker =
                            //         preferences.getInt('firsttime') == null
                            //             ? 0
                            //             : preferences.getInt('firsttime');
                            //     Logger().d(checker);
                            //     preferences.setInt('firsttime', checker!);
                            //     if (checker == 1) {
                            //       Navigator.pushReplacementNamed(
                            //           context, HomePage.id);
                            //     } else {
                            //       Navigator.pushReplacementNamed(
                            //         context,
                            //         SignIn.id,
                            //       );
                            //     }
                            //   },
                            //   child: Text(
                            //     'Skip',
                            //     style: TextStyle(
                            //       fontSize: 17.sp,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/logo.png',
                              scale: 1.1,
                            ),
                            SizedBox(
                              height: 90.h,
                            ),
                            Text(
                              'Money Matters',
                              style: TextStyle(
                                fontFamily: 'SF UI Display',
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 33.h,
                            ),
                            SizedBox(
                              width: 300.w,
                              height: 60.h,
                              child: Text(
                                "Get paid for every payment you make",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'SF UI Display',
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                int? checker =
                                    preferences.getInt('firsttime') == null
                                        ? 0
                                        : preferences.getInt('firsttime');
                                Logger().d(checker);
                                preferences.setInt('firsttime', checker!);
                                if (checker == 1) {
                                  Navigator.pushReplacementNamed(
                                      context, HomePage.id);
                                } else {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    SignIn.id,
                                  );
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 92),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xff3D83C3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Center(
                                  child: Text(
                                    'GET STARTED',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: size.height * .08,
                left: size.width * .5 - 25,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Indicator(
                        positionIndex: 0,
                        currentIndex: currentIndex,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Indicator(
                        positionIndex: 1,
                        currentIndex: currentIndex,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Indicator(
                        positionIndex: 2,
                        currentIndex: currentIndex,
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
}

class Indicator extends StatelessWidget {
  final int positionIndex, currentIndex;
  const Indicator({required this.currentIndex, required this.positionIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.h,
      width: 12.h,
      decoration: BoxDecoration(
        color: positionIndex == currentIndex
            ? Color(0xff3D83C3)
            : Color(0xFFF1F2F6),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}

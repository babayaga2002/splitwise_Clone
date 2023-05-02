import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splitwise/HomeScreen/FriendsPage.dart';
import 'package:splitwise/Settings/editProfile.dart';
import 'package:splitwise/Settings/privacy.dart';
import 'package:splitwise/Settings/settings.dart';
import 'package:splitwise/SignUp/otpVerification.dart';
import 'package:splitwise/SplashScreen/splashScreen.dart';
import 'package:splitwise/OnBoardingScreens/onboardingScreen.dart';
import 'package:splitwise/Stores/homeStore.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/components/AddingNew/Friends.dart';
import 'package:splitwise/components/AddingNew/Groups.dart';
import 'package:splitwise/components/Settle-Up/RecordPayment.dart';
import 'HomeScreen/HomePage.dart';
import 'SignUp/signIn.dart';
import 'SignUp/signUp.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Stores/loginStore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginStore>(
          create: (_) => LoginStore(),
        ),
        // Provider<MapBoxStore>(
        //   create: (_) => MapBoxStore(),
        // ),
        Provider<HomeStore>(
          create: (_) => HomeStore(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xff3D83C3),
          ),
          scaffoldBackgroundColor: Color(0xff232932),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          OnboardingScreens.id: (context) => OnboardingScreens(),
          SignIn.id: (context) => SignIn(),
          OtpVerification.id: (context) => OtpVerification(),
          SignUp.id: (context) => SignUp(),
          HomePage.id: (context) => HomePage(),
          Settings.id: (context) => Settings(),
          Privacy.id: (context) => Privacy(),
          EditProfile.id: (context) => EditProfile(),
          AddNewGroupPage.id: (context) => AddNewGroupPage(),
          AddNewFriendPage.id: (context) =>AddNewFriendPage(),
          FriendsTab.id: (context) => FriendsTab(),
        },
      ),
    );
  }
}

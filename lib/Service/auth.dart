import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:splitwise/HomeScreen/HomePage.dart';
import 'package:splitwise/Service/api.dart';
import 'package:splitwise/SignUp/otpVerification.dart';
import 'package:splitwise/SignUp/signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
String verificationIdFinal="";
Future<void> verifyPhoneNumber(
    String phoneNumber, BuildContext context, Function setData) async {
  PhoneVerificationCompleted verificationCompleted =
      (PhoneAuthCredential phoneAuthCredential) async {
    print("Verification Completed");
  };
  PhoneVerificationFailed verificationFailed =
      (FirebaseAuthException exception) {
    print(exception.toString());
  };
  PhoneCodeSent codeSent =
      (String verificationID, [ int ?forceResnedingtoken]) {
    print("Verification Code sent on the phone number");
    setData(verificationID);
    verificationIdFinal=verificationID;
    Navigator.pushNamed(context, OtpVerification.id);
  };

  PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationID) {
    print("Time out");
  };
  try {
    await auth.verifyPhoneNumber(
        timeout: Duration(seconds: 60),
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  } catch (e) {
    print(e.toString());
  }
}

Future<void> signInwithPhoneNumber(String smsCode, BuildContext context) async {
  try {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdFinal, smsCode: smsCode);
    bool flag=false;
    UserCredential userCredential =
    await auth.signInWithCredential(credential);
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    sharedPreferences.setString("auth", userCredential.toString());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.toString())
        .get()
        .then((doc) {
      if (doc.exists) {
        Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
      }else{
        Navigator.pushNamedAndRemoveUntil(context, SignUp.id, (route) => false);
      }
    });
    print("logged In");
  } catch (e) {
    print(e.toString());
  }
}
void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
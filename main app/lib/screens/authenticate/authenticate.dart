import 'package:flutter/material.dart';
import 'package:mostadeem/Screens/authenticate/bodyLogin.dart';
import 'package:mostadeem/Screens/authenticate/bodySignUp.dart';
//import 'package:mostadeem/Screens/Login/login_screen.dart';
//import 'package:mostadeem/Screens/Signup/signup_screen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    // print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return BodyLogin(toggleView: toggleView); // كانت لوق ان الكبيرة
    } else {
      return BodySignUp(toggleView: toggleView);
    }
  }
}

// don't need this class
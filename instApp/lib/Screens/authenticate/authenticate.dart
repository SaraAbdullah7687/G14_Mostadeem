import 'package:flutter/material.dart';
import 'package:inst_trial/Screens/authenticate/logIn.dart';
import 'package:inst_trial/Screens/authenticate/registerScreen.dart';
//import 'package:test_project/Screens/Login/login_screen.dart';
//import 'package:test_project/Screens/Signup/signup_screen.dart';



class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return logIn(toggleView: toggleView); // كانت لوق ان الكبيرة
    } else {
      return regScreen(toggleView:  toggleView);
    }
  }
}


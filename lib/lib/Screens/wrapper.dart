import 'package:test_project/models/userMu.dart';
import 'package:test_project/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Login/login_screen.dart';
import 'Signup/signup_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserMu>(context);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return LoginScreen(); // was Authenticate indtead of LoginScreen
    } else {
      return Home();
    }
    
  }
}
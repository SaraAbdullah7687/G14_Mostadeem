import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mostadeem/Admin/adminHome.dart';
import 'package:mostadeem/Screens/authenticate/authenticate.dart';
import 'package:mostadeem/Screens/authenticate/bodyLogin.dart';
//import 'package:mostadeem/institution/start.dart';
import 'package:mostadeem/models/userMu.dart';
import 'package:mostadeem/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/shared/loading.dart';

//import 'Login/login_screen.dart';
import 'Signup/signup_screen.dart';
//import 'Welcome/welcome_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMu>(context);
    final AuthService _authService = AuthService();
    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate(); // was Authenticate indtead of LoginScreen  SignUpScreen
    } else {
      // make it else if insted of else
      return new FutureBuilder(
          future: _authService.checkUserType(),
          builder: (BuildContext context, AsyncSnapshot<String> text) {
            // add code to wait for data
            print("inside builder");
            if (text.connectionState == ConnectionState.done) {
              print("inside if connection stm");
              if (!text.hasData) {
                print("inside hasData");
                return Loading();
              } else {
                if (text.data == "admin") {
                  return AdminHome(
                    feedback: () {
                      _authService.showTopSnackBar(
                        context,
                        "Welcome",
                        "Good to have you in Mostadeem",
                        Icons.check_circle_outline_outlined,
                      );
                    },
                  ); //عدليه وخليه هذا
                  //return ViewInstitution();
                } else if (text.data == "contributor") {
                  print("entered home");
                  return Home(
                    feedback: () {
                      _authService.showTopSnackBar(
                        context,
                        "Welcome",
                        "Good to have you in Mostadeem",
                        Icons.check_circle_outline_outlined,
                      );
                    },
                  );
                } else {
                  return BodyLogin();
                }
              }
            }
            print("still loading !!!");
            return Loading(); // يجي هنا بعد الساين اب
          });
      /*   
dynamic userType= checkType();
if ( userType=="admin"){
return AdminHome(); 
}
else if (userType=="contributor"){
  print("entered home");
          return Home();
}
    }// end of else
return Loading();*/
    } // method build
  }
}

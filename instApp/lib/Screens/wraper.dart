import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inst_trial/Screens/authenticate/authenticate.dart';
import 'package:inst_trial/Screens/authenticate/logIn.dart';
import 'package:inst_trial/Screens/authenticate/registerScreen.dart';
import 'package:inst_trial/models/instModel.dart';
import 'package:inst_trial/services/auth.dart';
import 'package:inst_trial/models/userMu.dart';
import 'package:inst_trial/shared/loading.dart';
import 'package:provider/provider.dart';

import 'home.dart';



class Wrapper1 extends StatelessWidget {



final FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {

     final user = Provider.of<UserMu>(context);

     final AuthService _authService= AuthService();
     if (user == null)
     {
      return Authenticate(); // was Authenticate indtead of LoginScreen  SignUpScreen
    } else {// make it else if insted of else
      return new FutureBuilder(
      future: _authService.checkStatus(),
      builder: (BuildContext context, AsyncSnapshot<String> text) { // add code to wait for data
        print("inside builder");
        if(text.connectionState == ConnectionState.done ){
          print("inside if connection stm");
          if (!text.hasData) {
            print("inside hasData");
            return logIn(); // loading 
          }
        
       else{ 
         if (text.data == "pending")
        {return Authenticate(); //عدليه وخليه هذا
        //return ViewInstitution();
        }
        else if (text.data == "approved")
        { print("entered home");
          return Home();}
        else{ return Authenticate();}} 
      }
      print("still loading !!!");
      return Loading(); // يجي هنا بعد الساين اب
      }
      
      );

}}}
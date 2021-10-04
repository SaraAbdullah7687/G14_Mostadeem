import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/Admin/adminHome.dart';
import 'package:test_project/Admin/viewInstitution.dart';
import 'package:test_project/Screens/authenticate/authenticate.dart';
import 'package:test_project/Screens/authenticate/bodyLogin.dart';
import 'package:test_project/models/userMu.dart';
import 'package:test_project/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/services/auth.dart';
import 'package:test_project/shared/loading.dart';

//import 'Login/login_screen.dart';
import 'Signup/signup_screen.dart';
import 'Welcome/welcome_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserMu>(context);
    final AuthService _authService=AuthService();
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate(); // was Authenticate indtead of LoginScreen  SignUpScreen
    } else {// make it else if insted of else
      return new FutureBuilder(
      future: _authService.checkUserType(),
      builder: (BuildContext context, AsyncSnapshot<String> text) { // add code to wait for data
        print("inside builder");
        if(text.connectionState == ConnectionState.done ){
          print("inside if connection stm");
          if (!text.hasData) {
            print("inside hasData");
            return Loading();
          }
        
       else{ 
         if (text.data == "admin")
        {return AdminHome(); //عدليه وخليه هذا
        //return ViewInstitution();
        }
        else if (text.data == "contributor")
        { print("entered home");
          return Home();}
        else{ return BodyLogin();}} 
      }
      print("still loading !!!");
      return Loading(); // يجي هنا بعد الساين اب
      }
      
      );
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
  }// method build

    
  }


dynamic checkType()async{

AuthService _auth = AuthService();
dynamic result= await _auth.checkUserType();
return result;

}



     checkRole( DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return Center(
        child: Text('no data set in the userId document in firestore'),
      );
    }
    if (snapshot['userType'] == 'admin') {
      print('user type is admin');
      return AdminHome();
    } else if (snapshot['userType'] =='contributor'){
      print('user type is contributor');
      return Home();
    }else {
  print("could not configure");
 // print(userType);
  return ViewInstitution();
  }
}
}
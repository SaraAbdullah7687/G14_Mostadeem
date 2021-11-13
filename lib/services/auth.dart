

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/Screens/authenticate/bodyLogin.dart';
import 'package:mostadeem/globals/global.dart';
import 'package:mostadeem/models/ContributorModel.dart';
import 'package:mostadeem/models/userMu.dart';
import 'package:mostadeem/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<Flushbar> flushBars = [];
  // create user obj based on firebase user
  UserMu _userFromFirebaseUser(User user) { // was FirebaseUser instead of User
  print(user); // maybe wrong
    return user != null ? UserMu(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserMu> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser); // was onAuthStateChanged instead of authStateChanges()
     
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in with email and password
  Future <dynamic> signInWithEmailAndPassword(String email, String password,) async {
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      User _user = _result.user; // was FirebaseUser instead of User
      return _user;
    }  on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
    return "No-user-found"; // maybe change it 
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
    return "Wrong-password"; // maybe change it 
  }
} 
  }

  // register with email and password
  Future <dynamic>registerWithEmailAndPassword(String email, String password, String name, String phone) async { // خلي الميثود تقبل رقم جواله
   String retVal = "retVal error";
   try {
     print("before registering contributor");
      UserCredential _result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
     //await _auth.currentUser.reload(); //delete it
      User user = _result.user; // was FirebaseUser instead of User
      print("contributor registered");
       ContributorModel _userCont = ContributorModel(
        uid: user.uid,
        email: user.email,
        name: name,
        phone: phone,
        points:0,); //notifToken: await _fcm.getToken(),?? 

        String _returnString = await DatabaseService().createUserContributor(_userCont); // maybe database service
        print("contributor created");
        if (_returnString == "success") { // didn't work
        retVal = "success";
        print("retVal success");
      }
   // print(retVal); // delete it 
       
      // create a new document for the user with the uid
     // await DatabaseService(uid: _user.uid).updateUserData('0','new crew member', 100);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (signUpError) {
      print("catch error in register");
      //if (signUpError is PlatformException){
        switch(signUpError.code){
          case "ERROR_EMAIL_ALREADY_IN_USE": // ما تضبط
          print("email exists 1 case");
          return "email exists";
          break;

          case "email-already-in-use":
          print("email exists 2 case");
          return "email exists";
          break;
        
      }
    } 
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }

   /* _auth.signOut().then((res) {
            Navigator.pushReplacement(
context, MaterialPageRoute(builder: (context) => MyApp()));
        
        });*/
  
  
  }

  //get the current user
   Future<User> getCurrentUser() async {
    return _auth.currentUser;
  }

  //get current user ID
   String getCurrentUserID() {
     print(_auth.currentUser.uid);
    return _auth.currentUser.uid;
  }

String updateInstitutionStatus(String status, String uid){ // return string ?

//String uid =getCurrentUserID(); WRONG this is returns current user!!! i need uid of the selected institution
String result = DatabaseService().updateInstitution(uid,status);
return result;

}

Future<String> checkUserType ()async{

String uid = getCurrentUserID();
print(uid);
print("check user type method");
//dynamic userType =
await Future.delayed(const Duration(seconds: 1), (){});
 return await DatabaseService().getUserType(uid//,context
 );
 
//print("retrived user type");
/*userType.toString();
if (userType!=null){
  DatabaseService().getUserType(uid).then((value) {
  return value.toString();
});
  print("user type is $userType");
//return userType.toString();
}
else {
  print("user type returned null");
return "could not find userType";}
return "user type is problem";*/
}


Future<dynamic> resetPassword(String email) async{
try {
 await _auth.sendPasswordResetEmail(email: email);
 return "pass";
} on FirebaseAuthException catch (e) {
 print(e.message);
 return "fail";
}

}

Future<String> getInstName(String uid) async {
String name = await DatabaseService().getUserName(uid);
return name;

}

String updateAppointmentStatus(String status, String appointmentID){ // return string ?

String institutionID=getCurrentUserID(); 
String result = DatabaseService().updateAppointment(appointmentID,status,institutionID);
return result;
}
Future<String> updateRequestStatus(String status, String contID, String reqID) async { // return string ?
String institutionID=getCurrentUserID(); 
String result = await DatabaseService().updateRequest(contID,status, reqID,institutionID);
return result;

}

void showTopSnackBar(BuildContext context, String title, String message,IconData icon) => show(
        context,
        Flushbar(
          icon: Icon(icon, size: 32, color: Colors.white),
          shouldIconPulse: false,
          title: title,
          message: message,
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
         // margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
         borderRadius: BorderRadius.circular(6),
           barBlur: 20,
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
      );


          Future show(BuildContext context, Flushbar newFlushBar) async {
           // await Future.delayed(const Duration(seconds: 2), (){});
    await Future.wait(flushBars.map((flushBar) => flushBar.dismiss()).toList());
    flushBars.clear();

    newFlushBar.show(context);
    flushBars.add(newFlushBar);
  }

} // end of class

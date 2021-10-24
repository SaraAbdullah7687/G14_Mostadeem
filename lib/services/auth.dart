import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/models/ContributorModel.dart';
import 'package:mostadeem/models/userMu.dart';
import 'package:mostadeem/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  Future <dynamic>registerWithEmailAndPassword(String email, String password, String name) async { // خلي الميثود تقبل رقم جواله
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
        name: name,); //notifToken: await _fcm.getToken(),?? 

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
      print("email exists");
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

Future<String> checkUserType (//BuildContext context
)async{

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

Future<String> getName() async {
  await Future.delayed(const Duration(seconds: 4), (){});
String uid = getCurrentUserID();

String name = await DatabaseService().getUserName(uid);
return name;

}


} // end of class
import 'package:flutter/services.dart';
import 'package:test_project/models/ContributorModel.dart';
import 'package:test_project/models/userMu.dart';
import 'package:test_project/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  // sign in anon
  /*
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously(); // was AuthResult instead of UserCredential
      User user = result.user; // was FirebaseUser instead of User
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }*/

  // sign in with email and password
  Future <dynamic> signInWithEmailAndPassword(String email, String password) async {
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
     print("before registering user");
      UserCredential _result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
     await _auth.currentUser.reload(); //delete it
      User user = _result.user; // was FirebaseUser instead of User
      print("user registered");
       ContributorModel _userCont = ContributorModel(
        uid: user.uid,
        email: user.email,
        name: name,); //notifToken: await _fcm.getToken(),?? 

        String _returnString = await DatabaseService().createUser(_userCont); // maybe database service
        print("user created");
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
    return _auth.currentUser.uid;
  }



}
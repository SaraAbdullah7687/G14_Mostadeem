import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:inst_app/models/InstModel.dart';
import 'package:inst_app/models/userMu.dart';
import 'package:inst_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;


class AuthService {

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  // create user obj based on firebase user
  UserMu _userFromFirebaseUser(auth.User user) { 
  if (user ==null)
  return null;
    return UserMu(uid: user.uid,); 
  }

  // auth change user stream
  Stream<UserMu> get user {
    return _firebaseAuth.authStateChanges().map((_userFromFirebaseUser));
       }


  Future <dynamic>  signInWithEmailAndPassword(
    String email, 
    String password,
  ) async{
    UserCredential _result = await _firebaseAuth.signInWithEmailAndPassword(email: email.trim(), password: password);
      User _user = _result.user; // was FirebaseUser instead of User
      return _user;

  }





  Future<UserMu> registerInstitution(

    
  String email,
  String password,
  String phone,
  String name, 
  String twitter, 
  String cr,
  String categ,

  ) async{
     String retVal = "retVal error";
    UserCredential _result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
     //await _auth.currentUser.reload(); //delete it
      User user = _result.user; 

      print("institution registered");

    



     String _returnString = await databaseService().createUserInstitution(
         _result.user.uid,
          name,
          email,
          phone, 
          twitter,
          cr, 
          categ
       );
       
        print("institution created");
        if (_returnString == "success") { 
        retVal = "success";
        print("retVal success");

        }
    return _userFromFirebaseUser(user);
  }




  Future<void> signOut() async{
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

Future<String> checkStatus (//BuildContext context
)async{

String uid = getCurrentUserID();
print(uid);
print("check user type method");
//dynamic userType =
await Future.delayed(const Duration(seconds: 3), (){});
 return await databaseService().getUserStatus(uid//,context
 );

//return userType;
}


 String getCurrentUserID() {
     print(_firebaseAuth.currentUser.uid);
    return _firebaseAuth.currentUser.uid;
  }
  
  
 String updateAppointmentStatus(String status, String appointmentID){ // return string ?

String institutionID=getCurrentUserID(); 
String result = databaseService().updateAppointment(appointmentID,status,institutionID);
return result;
}
String updateRequestStatus(String status, String contID, String reqID){ // return string ?
String result = databaseService().updateRequest(contID,status, reqID);
return result;

}
 
  
  
  
  
  
  }



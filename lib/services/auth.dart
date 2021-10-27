

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/models/ContributorModel.dart';
import 'package:mostadeem/models/userMu.dart';
import 'package:mostadeem/services/database.dart';
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
        phone: phone); //notifToken: await _fcm.getToken(),?? 

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

String updateAppointmentStatus(String status, String appointmentID){ // return string ?

String institutionID=getCurrentUserID(); 
String result = DatabaseService().updateAppointment(appointmentID,status,institutionID);
return result;
}
String updateRequestStatus(String status, String contID, String reqID){ // return string ?
String result = DatabaseService().updateRequest(contID,status, reqID);
return result;

}



} // end of class

/*
String updateRequestStatusInAllInst(String status, String reqID){
  //https://petercoding.com/firebase/2020/04/04/using-cloud-firestore-in-flutter/
String result="initial";
//dynamic newValue='rejected';
WriteBatch batch = FirebaseFirestore.instance.batch();

var theRequest = FirebaseFirestore.instance.collectionGroup('appointment')
   .where("requestID", isEqualTo: reqID).where("status", isEqualTo: "pending"); // only bring the request that is pending and has requestID=reqID, (I specify the status pending bc I already accepted one)
   if(status=='accept'){
     print('in accept if database');
 theRequest.get().then( (querySnapshot) { // change status to rejected
     querySnapshot.docs.forEach((document) {
       //if(document.exists){
       try{
         print(document['contEmail']);
         print(document['status']+' before');
         //var docRef= document.reference;
         document.reference.update({'status' : 'rejected'}); // doesn't work!!
        print(document['status']+' after');
        print(document['contName']);
        result="success";
       } 
       on FormatException catch (error) {
         print("error in update status all");
         result="fail";
       }//}
     });
     batch.commit();
 });
   return result;
   }
}
*/
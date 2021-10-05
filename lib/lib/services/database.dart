//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project/Admin/adminHome.dart';
import 'package:test_project/Admin/viewInstitution.dart';
import 'package:test_project/Screens/home/home.dart';
import 'package:test_project/models/ContributorModel.dart';
import 'package:test_project/models/emailMessage.dart';

class DatabaseService {


  //final String uid;
 //DatabaseService({ this.uid });

  // collection reference
  final CollectionReference _contributorCollection = FirebaseFirestore.instance.collection('contributor'); // was Firestore instead of FirebaseFirestore
  final CollectionReference _institutionCollection = FirebaseFirestore.instance.collection('institution'); // was Firestore instead of FirebaseFirestore
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users'); // was Firestore instead of FirebaseFirestore
  // get institution stream
  final CollectionReference _sendEmailCollection = FirebaseFirestore.instance.collection('sendEmail'); // was Firestore instead of FirebaseFirestore
  Stream<QuerySnapshot> get brews {
    return _institutionCollection.snapshots();
  }

Future<String> createUserContributor(ContributorModel user) async {
    String retVal = "error";
//ممكن طريقة انشاء الكولكشن غلط مدري كم عندنا من كوليكشن
    try {
      print("create contributor collection");
      await _contributorCollection.doc(user.uid).set({
        'uid':user.uid,
        'name': user.name,
        'email': user.email,
        'userType': 'contributor',
        //'notifToken': user.notifToken,?? what should we add?
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    try {
      print("create users collection");
      await _usersCollection.doc(user.uid).set({
        'name': user.name,
        'userType': 'contributor',
        //'notifToken': user.notifToken,?? what should we add?
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

String updateInstitution(String uid, String status){
String result="nothing changed";
// check condition approve or disapprove
if(status =='approve'){
_institutionCollection.doc(uid)
    .update({'status' : 'approved'})
    .then((_) => print(result='Success approve'),)
    .catchError((error) => print(result='Fail approve'),);
    result='Success approve';
}
else{ // delete institution and send them email 
/*
_institutionCollection.doc(uid) // also delete it from users collecction
    .delete()
    .then((_) => print(result='Success delete'),)
    .catchError((error) => print(result='Fail delete'),);

_usersCollection.doc(uid) // also delete it from users collecction
    .delete()
    .then((_) => print(result='Success delete'),)
    .catchError((error) => print(result='Fail delete'),);*/
_institutionCollection.doc(uid)
    .update({'status' : 'disapproved'})
    .then((_) => print(result='Success disapprove'),)
    .catchError((error) => print(result='Fail disapprove'),);
result='Success disapprove';
}
return result;

}

Future<String> getUserType(String uid/*,BuildContext context*/) async{

print(uid);
print("database file");
final snapshot =await _usersCollection.doc(uid).get();
print("after getting type");
print (snapshot['userType']+" in database method");
 String userType = snapshot['userType'];
 return userType;
    }

//return userType;

}

//}
// modify this class from the bookclub
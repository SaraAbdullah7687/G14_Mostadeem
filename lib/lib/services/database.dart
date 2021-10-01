//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project/Admin/adminHome.dart';
import 'package:test_project/Admin/viewInstitution.dart';
import 'package:test_project/Screens/home/home.dart';
import 'package:test_project/models/ContributorModel.dart';

class DatabaseService {


  //final String uid;
 //DatabaseService({ this.uid });

  // collection reference
  final CollectionReference _contributorCollection = FirebaseFirestore.instance.collection('contributor'); // was Firestore instead of FirebaseFirestore
  final CollectionReference _institutionCollection = FirebaseFirestore.instance.collection('institution'); // was Firestore instead of FirebaseFirestore
   final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users'); // was Firestore instead of FirebaseFirestore
  // get institution stream
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
}
else{ // delete institution and send them email 
_institutionCollection.doc(uid) // also delete it from users collecction
    .delete()
    .then((_) => print(result='Success delete'),)
    .catchError((error) => print(result='Fail delete'),);

_usersCollection.doc(uid) // also delete it from users collecction
    .delete()
    .then((_) => print(result='Success delete'),)
    .catchError((error) => print(result='Fail delete'),);


}
return result;

}

Future<String> getUserType(String uid/*,BuildContext context*/) async{

print(uid);
final snapshot =await _usersCollection.doc(uid).get();
print (snapshot['userType']+" in database method");
 String userType = snapshot['userType'];
 return userType;
/*
if(userType.toString()=='admin'){
  print("user is admin");
       Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new AdminHome()));
       // return AdminHome();      
             }

else if (userType=='contributor') {
  print("user is contributor");
  Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new Home()));
           //return Home();                            
            }     
else {
  print("could not configure");
  print(userType);
  Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new ViewInstitution()));
                    
      //return   ViewInstitution();        
          }*/
    }

//return userType;


}

//}
// modify this class from the bookclub
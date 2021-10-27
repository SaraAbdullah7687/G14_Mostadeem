//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mostadeem/models/ContributorModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:mostadeem/models/requestModel.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:developer';

class DatabaseService {
  //final String uid;
  //DatabaseService({ this.uid });

  // collection reference
  final CollectionReference _contributorCollection = FirebaseFirestore.instance
      .collection('contributor'); // was Firestore instead of FirebaseFirestore
  final CollectionReference _institutionCollection = FirebaseFirestore.instance
      .collection('institution'); // was Firestore instead of FirebaseFirestore
  final CollectionReference _usersCollection = FirebaseFirestore.instance
      .collection('users'); // was Firestore instead of FirebaseFirestore
  // get institution stream
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _sendEmailCollection = FirebaseFirestore.instance
      .collection('sendEmail'); // was Firestore instead of FirebaseFirestore
  Stream<QuerySnapshot> get brews {
    return _institutionCollection.snapshots();
  }

  Future<String> createUserContributor(ContributorModel user) async {
    String retVal = "error";
//ممكن طريقة انشاء الكولكشن غلط مدري كم عندنا من كوليكشن
    try {
      print("create contributor collection");
      await _contributorCollection.doc(user.uid).set({
        'uid': user.uid,
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

  String updateInstitution(String uid, String status) {
    String result = "nothing changed";
// check condition approve or disapprove
    if (status == 'approve') {
      _institutionCollection
          .doc(uid)
          .update({'status': 'approved'})
          .then(
            (_) => print(result = 'Success approve'),
          )
          .catchError(
            (error) => print(result = 'Fail approve'),
          );
      result = 'Success approve';
    } else {
      // delete institution and send them email
/*
_institutionCollection.doc(uid) // also delete it from users collecction
    .delete()
    .then((_) => print(result='Success delete'),)
    .catchError((error) => print(result='Fail delete'),);

_usersCollection.doc(uid) // also delete it from users collecction
    .delete()
    .then((_) => print(result='Success delete'),)
    .catchError((error) => print(result='Fail delete'),);*/
      _institutionCollection
          .doc(uid)
          .update({'status': 'disapproved'})
          .then(
            (_) => print(result = 'Success disapprove'),
          )
          .catchError(
            (error) => print(result = 'Fail disapprove'),
          );
      result = 'Success disapprove';
    }
    return result;
  }

  Future<String> getUserType(String uid /*,BuildContext context*/) async {
    print(uid);
    print("database file");
    final snapshot = await _usersCollection.doc(uid).get();
    print("after getting type");
    print(snapshot['userType'] + " in database method");
    String userType = snapshot['userType'];
    return userType;
  }

//return userType;
/* get name 
  String getName() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.
  }*/

  //addRequest
  Future<String> addRequest(String contId, requestModel request) async {
    String retVal = "error";

    print("DB 22########################################################");
    try {
      CollectionReference _docRef = _firestore
          .collection("contributor")
          .doc(contId)
          .collection("request");

      print("DB 28 ########################################################" +
          _docRef.toString());

      _docRef.add({
        'category': request.category.trim().toLowerCase(),
        'date': request.date.trim(),
        'location': request.location.data,
        'status': request.status.trim(),
        'time': request.time.trim(),
        //'requestID': _docRef.id.toString(), //'name': request.name.trim(),
        // 'descreption': request.descreption.trim(),
      }).then((_docRef) {
        print("!!!!!!!!!Document written with ID: " + _docRef.id.toString());
      });

      print("DB 35########################################################");

// ADD appointment to suitble instituations
      addAppointment(contId, request);
      retVal = "success";
    } catch (e) {
      print("DB 41########################################################");

      print(e);
      print("DB 44########################################################");
    }
    return retVal;
  }

  // ADD appointment to instituations
  Future<String> addAppointment(String contribId, requestModel request) async {
    String retVal = "error";
    String contName;
    String contEmail;
    String contPhone;
    ////
    FirebaseFirestore firestoreObj = FirebaseFirestore.instance;
    /* TO GET NAME*/
    firestoreObj.collection("contributor").doc(contribId).get().then((value) {
      contName = (value.data()['name']);
    });
    /*TO GET EMAIL*/
    firestoreObj.collection("contributor").doc(contribId).get().then((value) {
      contEmail = (value.data()['email']);
    });
    /*TO GET PHONE
      firestoreObj.collection("contributor").doc(contribId).get().then((value) {
      contPhone = (value.data()['phone']);
    });*/

    print("DB 52########################################################");

    try {
      // first get the instituations that accept this categories
      List<String> insIDs = await findCategory(request.category.toLowerCase());
      print("DB 57########################################################");

      insIDs.forEach((element) async {
        DocumentReference _docRef = await _firestore
            .collection("institution")
            .doc(element)
            .collection("appointment")
            .add({
          'contribId':
              contribId, ////----------------------------------------------------------------NEW ADDED

          'category': request.category.trim().toLowerCase(),
          'date': request.date.trim(),
          'location': request.location.data,
          'time': request.time.trim(),
          'status': request.status.trim(),
          //'requestID': request.requestID.trim(),
          // 'descreption': request.descreption.trim(),
          'contName': contName,
          'contEmail': contEmail,
        });
      }); // END outer foreach
      print("DB 74########################################################");

      retVal = "success";
    } catch (e) {
      print("DB 78########################################################");

      print(e);
      print("DB 81########################################################");
    }
    return retVal;
  }
  // END ADD appointment to instituations

  // Find institutions that has the selected category ----------------------------------------------------------------
  Future<List<String>> findCategory(String categories) async {
    List<String> ids = []; //list();
    try {
// string formalition
      List<String> userCat = null;
      int catLength = categories.length;
      for (var i = 0; i < catLength; i++) {
        userCat = categories.split(",");
      }
      /*  print("DB 97########################################################" +
          userCat!.length.toString() +
          "");*/

      QuerySnapshot query = await _firestore.collection("institution").get();
      print("DB 119########################################################");
      bool flag = false;
      query.docs.forEach((element) {
        print("DB 122########################################################" +
            element.toString());

        // retVal.add(BookModel.fromDocumentSnapshot(doc: element));
        //==============
        int count = userCat
            .length; // NULLABLE ###################################################################
        int indexIDs = 0;
        for (var i = 0; i < count; i++) {
          if (element
              .get("category")
              .toLowerCase()
              .contains(userCat[i].toLowerCase())) {
            flag = true;
          }
        } // inner loop

        if (flag) {
          ids.add(element.id);
        }
        print("DB 117########################################################" +
            flag.toString());

        //===========
      } //outer loop
          );
    } catch (e) {
      print(
          "CATCH333333333333333333333333333333333333333333333333333333333333333");
      print(e);
    }
    return ids;
  }
  ///////////////////////////////////////////////
  ///

}

//}
// modify this class from the bookclub

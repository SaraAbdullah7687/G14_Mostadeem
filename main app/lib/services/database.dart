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
  final CollectionReference _adminCollection = FirebaseFirestore.instance
      .collection('admin'); // was Firestore instead of FirebaseFirestore

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
        'phone': user.phone,
        'points': user.points,
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

  Future<String> getUserName(String uid /*,BuildContext context*/) async {
    print(uid);
    final snapshot = await _institutionCollection.doc(uid).get();
    print("after getting type");
    print(snapshot['name'] + " in database method");
    String userName = snapshot['name'];
    return userName;
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
    String ID;
    print("DB 22########################################################");
    try {
      CollectionReference _docRef = _firestore
          .collection("contributor")
          .doc(contId)
          .collection("request");

      print("DB 28 ########################################################" +
          _docRef.toString());

      DocumentReference dic1 = await _docRef.add({
        'category': request.category.trim().toLowerCase(),
        'contribId': contId,
        'date': request.date.trim(),
        'location': request.location.data,
        'status': request.status.trim(),
        'time': request.time.trim(),
        'title': request.title,
        /*SARA RATING*/
        'instID':
            "notAssigened", //=======================================for rating====================================================================
        'instName': "notAssigened",
        'isRated': false,
        'reqRate': 0.0,
      });

      _firestore
          .collection("contributor")
          .doc(contId)
          .collection("request")
          .doc(dic1.id)
          .update({
        'reqID': dic1.id,
      });
      print("DB 35########################################################");
      /////

      addAppointment(contId, request, dic1.id.toString());
      retVal = "success";
    } catch (e) {
      print("DB 41########################################################");

      print(e);
      print("DB 44########################################################");
    }
    return retVal;
  }

  // ADD appointment to instituations
  Future<String> addAppointment(
      String contribId, requestModel request, String requestId) async {
    String retVal = "error";
    String contName;
    String contEmail;
    String contPhone;
    //String requestID;
    ////
    FirebaseFirestore firestoreObj = FirebaseFirestore.instance;
    /*TO GET ID
    firestoreObj
        .collection("contributor")
        .doc(contribId)
        .collection("request")
        .doc(requestID)
        .get()
        .then((value) {
      requestID = (value.data()['requestID']);
    });*/

/*TO GET EMAIL*/
    firestoreObj.collection("contributor").doc(contribId).get().then((value) {
      contEmail = (value.data()['email']);
    });
    /* TO GET NAME*/
    firestoreObj.collection("contributor").doc(contribId).get().then((value) {
      contName = (value.data()['name']);
    });

    /* TO GET PHONE*/
    firestoreObj.collection("contributor").doc(contribId).get().then((value) {
      contPhone = (value.data()['phone']);
    });

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
          'requestID': requestId,
          'reqTitle': request.title.trim(),
          'contName': contName,
          'contEmail': contEmail,
          'contPhone': contPhone,
        });
      });

      // END outer foreach
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
        flag = false;
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

/************************************NEWLY ADDED *********************/
  String updateAppointment(String uid, String status, String instID) {
    String result = "nothing changed";
// check condition approve or disapprove
    if (status == 'accept') {
      // get current user uid
      _institutionCollection
          .doc(instID)
          .collection("appointment")
          .doc(uid) // لحظة هذا الاي دي حق الدوك للابوينمنت؟
          .update({'status': 'accepted'}) // modify it
          .then(
            (_) => print(result = 'Success accept'),
          )
          .catchError(
            (error) => print(result = 'Fail accept'),
          );
      result = 'Success accept';
    } else if (status == 'reject') {
      _institutionCollection
          .doc(instID)
          .collection("appointment")
          .doc(uid)
          .delete()
          .then(
            (_) => print(result = 'Success reject'),
          )
          .catchError(
            (error) => print(result = 'Fail reject'),
          );
      result = 'Success reject';
    } else {
      // status==done
      _institutionCollection
          .doc(instID)
          .collection("appointment")
          .doc(uid) // لحظة هذا الاي دي حق الدوك للابوينمنت؟
          .update({'status': 'complete'})
          .then(
            (_) => print(result = 'Success done'),
          )
          .catchError(
            (error) => print(result = 'done failed'),
          );
      result = 'Success done';
    }
    return result;
  }

  Future<String> updateRequest(
      String contID, String status, String reqID, String instID) async {
    String result = "nothing changed";
    String instName = await getUserName(instID); // اضفته

// check condition approve or disapprove
    if (status == 'accept') {
      // get current user uid
      _contributorCollection
          .doc(contID)
          .collection("request")
          .doc(reqID) // لحظة هذا الاي دي حق الدوك للابوينمنت؟
          .update({'status': 'accepted'})
          .then(
            (_) => print(result = 'accepted'),
          )
          .catchError(
            (error) => print(result = 'failed'),
          );
      result = 'accepted';

      _contributorCollection
          .doc(contID)
          .collection("request")
          .doc(reqID) // لحظة هذا الاي دي حق الدوك للابوينمنت؟
          .update({'instID': instID})
          .then(
            (_) => print(result = 'accepted'),
          )
          .catchError(
            (error) => print(result = 'failed'),
          );
      result = 'accepted';

      _contributorCollection
          .doc(contID)
          .collection("request")
          .doc(reqID) // لحظة هذا الاي دي حق الدوك للابوينمنت؟
          .update({'instName': instName})
          .then(
            (_) => print(result = 'accepted'),
          )
          .catchError(
            (error) => print(result = 'failed'),
          );
      result = 'accepted';
    } else if (status == 'reject') {
      _contributorCollection
          .doc(contID)
          .collection("request")
          .doc(reqID)
          .update({'status': 'rejected'})
          .then(
            (_) => print(result = 'rejected'),
          )
          .catchError(
            (error) => print(result = 'Fail reject'),
          );
      result = 'Success reject';
    } else {
      // status==done
      _contributorCollection
          .doc(contID)
          .collection("request")
          .doc(reqID) // لحظة هذا الاي دي حق الدوك للابوينمنت؟
          .update({'status': 'complete'})
          .then(
            (_) => print(result = 'done'),
          )
          .catchError(
            (error) => print(result = 'could not mark done'),
          );
      result = 'done';
    }
    return result;
  }

  Future<String> updateRequestStatusInAllInst(
      String status, String reqID) async {
    String result = "initial";
    var theRequest = FirebaseFirestore.instance
        .collectionGroup('appointment')
        .where("requestID", isEqualTo: reqID)
        .where("status",
            isEqualTo:
                "pending"); // only bring the request that is pending and has requestID=reqID, (I specify the status pending bc I already accepted one)
    if (status == 'accept') {
      print('in accept if database');
      QuerySnapshot<Map<String, dynamic>> query = await theRequest.get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> document = query.docs;
      print('before checking doc length');
      if (document.length != 0) {
        for (int i = 0; i < document.length; i++) {
          print('before if doc exixts');
          if (document[i].exists) {
            try {
              print('inside for loop,before changing status');
              var docRef = document[i].reference;
              docRef.delete(); // call method to delete rejected req
              result = "success";
            } on FormatException catch (error) {
              print("error in update status all");
              return result = "fail";
            }
          } else {
            return result = "no institutions has the same req";
          }
        } // end for
      } else {
        print('doc length is 0');
        result = "no doc with same req";
      }
      return result;

      //return result;
    } else {
      // status == reject => check if there is inst that has the same request
      QuerySnapshot<Map<String, dynamic>> query = await theRequest.get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> document = query.docs;
      print('before checking doc length');
      if (document.length == 0) {
        // no inst has the req => change status in request collection
        return "No inst has the request";
      } else {
        // there's inst has the request
        return "There is inst has the request";
      }
    }
  }

  Future<int> getContPoints(String contID) async {
    final snapshot = await _contributorCollection.doc(contID).get();
    return snapshot['points'];
  }

  String updateContPoints(int numOfPoints, String contID) {
    String result = "points not updated";
    _contributorCollection
        .doc(contID)
        .update({"points": numOfPoints})
        .then(
          (_) => print(result = 'success'),
        )
        .catchError(
          (error) => print(result = 'Fail'),
        );
    return result = 'points updated';
  }

  getInstDoc(String uid /*,BuildContext context*/) {
    print(uid + " get inst doc");
    return _institutionCollection.doc(uid).snapshots();
  }

//addRequest
  Future<String> addRequestForSpec(
      String contId, requestModel request, String insName) async {
    String retVal = "error";
    String ID;
    try {
      CollectionReference _docRef = _firestore
          .collection("contributor")
          .doc(contId)
          .collection("request");

      DocumentReference dic1 = await _docRef.add({
        'category': request.category.trim().toLowerCase(),
        'contribId': contId,
        'date': request.date.trim(),
        'location': request.location.data,
        'status': request.status.trim(),
        'time': request.time.trim(),
        'title': request.title,
        'instID':
            "notAssigened", //=======================================for rating====================================================================
        'instName': "notAssigened",
        'isRated': false,
        'reqRate': 0.0,
      });

      _firestore
          .collection("contributor")
          .doc(contId)
          .collection("request")
          .doc(dic1.id)
          .update({
        'reqID': dic1.id,
      });

      addAppointmentToSpecIns(contId, request, dic1.id.toString(), insName);

      retVal = "success";
    } catch (e) {
      print(
          "DB in addRequestForSpec() ########################################################");

      print(e);
    }
    return retVal;
  }

// ADD appointment to 1 instituation
  Future<String> addAppointmentToSpecIns(String contribId, requestModel request,
      String requestId, String insName) async {
    String retVal = "error";
    String contName;
    String contEmail;
    String contPhone;

    FirebaseFirestore firestoreObj = FirebaseFirestore.instance;

    /* TO GET NAME*/
    firestoreObj.collection("contributor").doc(contribId).get().then((value) {
      contName = (value.data()['name']);
    });
    /*TO GET EMAIL*/
    firestoreObj.collection("contributor").doc(contribId).get().then((value) {
      contEmail = (value.data()['email']);
    });

    /* TO GET PHONE*/
    firestoreObj.collection("contributor").doc(contribId).get().then((value) {
      contPhone = (value.data()['phone']);
    });

    try {
      String insID;

      QuerySnapshot query = await _firestore.collection("institution").get();
      bool flag = false;
      print('InsName is $insName%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

      query.docs.forEach((element) {
        if (element['name'] == insName) {
          insID = element.id;
          print('InsID is $insID%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
          // need to exit the loop
        }
      });

      DocumentReference _docRef = await _firestore
          .collection("institution")
          .doc(insID)
          .collection("appointment")
          .add({
        'contribId':
            contribId, ////----------------------------------------------------------------NEW ADDED
        'category': request.category.trim().toLowerCase(),
        'date': request.date.trim(),
        'location': request.location.data,
        'time': request.time.trim(),
        'status': request.status.trim(),
        'requestID': requestId,
        'reqTitle': request.title.trim(),
        'contName': contName,
        'contEmail': contEmail,
        'contPhone': contPhone,
      });

      // END outer foreach
      print(
          "DB in addAppointmentToSpecIns() ########################################################");
      retVal = "success";
    } catch (e) {
      print(e);
      print(
          "DB in catch addAppointmentToSpecIns() ########################################################");
    }
    return retVal;
  }

  Future<String> getCat(String insName) async {
    QuerySnapshot query = await _firestore.collection("institution").get();

    query.docs.forEach((element) {
      if (element['name'] == insName) {
        return element["category"];
        // need to exit the loop
      }
    });
  }

//==========END SARA sprint 3=======================

  Future<String> addInfo(String uid, String title, String des) async {
    CollectionReference infoCollection =
        _adminCollection.doc(uid).collection("information");
    String retVal = "error info";

    try {
      print("create info collection");
      DocumentReference doc1 = await infoCollection.add({
        'title': title,
        'description': des,
        //'notifToken': user.notifToken,?? what should we add?
      });
      infoCollection.doc(doc1.id).update({
        'reqID': doc1.id,
      });

      retVal = "success info";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> addStore(String uid, String name, String ig) async {
    CollectionReference storeCollection =
        FirebaseFirestore.instance.collection('store');
//CollectionReference infoCollection=_adminCollection.doc(uid).collection("stores");
    String retVal = "error info";

    try {
      print("create info collection");
      DocumentReference doc1 = await storeCollection.add({
        'name': name,
        'instagram': ig,
        // image path
        //'notifToken': user.notifToken,?? what should we add?
      });
      storeCollection.doc(doc1.id).update({
        'docID': doc1.id,
      });

      retVal = "success add";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> checkStoreExists(String name) async {
    String result = "initial";
    var theRequest = FirebaseFirestore.instance
        .collection('store')
        .where("name", isEqualTo: name);

    QuerySnapshot<Map<String, dynamic>> query = await theRequest.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> document = query.docs;
    print('before checking doc length');
    if (document.length == 0) {
      // no inst has the req => change status in request collection
      return "No store";
    } else {
      return "there is store";
    }
  }
}




//}
// modify this class from the bookclub

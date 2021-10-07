// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:mostadeem/models/requestModel.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:developer';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp LocationApp = await Firebase.initializeApp();
  runApp(db());
}

class db extends StatefulWidget {
  // const db({Key? key, required this.title}) : super(key: key);

  @override
  State<db> createState() => database();
}

class database extends State<db> {
  //FirebaseFirestore.initializeApp();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
//    String day, GeoPoint location, String state, String time
  /* void initState() {
    findCategory("jjjjjjjjj");
  }*/

  //addRequest
  Future<String> addRequest(String contId, requestModel request) async {
    String retVal = "error";
    print("DB 22########################################################");
    try {
      CollectionReference _docRef = _firestore
          .collection("contributor")
          .doc("NK9m5Zwe40aIAo722ulq")
          .collection("request");
      print("DB 28 ########################################################" +
          _docRef.toString());

      _docRef.add({
        'category': request.category.trim(),
        'date': request.date.trim(),
        'location': request.location.data,
        'status': request.status.trim(),
        'time': request.time.trim()
      });
      print("DB 35########################################################");

// ADD appointment to suitble instituations
      addAppointment("NK9m5Zwe40aIAo722ulq", request);
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
    print("DB 52########################################################");

    try {
      // first get the instituations that accept this categories
      List<String> insIDs = await findCategory(request.category);
      print("DB 57########################################################");

      insIDs.forEach((element) async {
        DocumentReference _docRef = await _firestore
            .collection("institution")
            .doc(element)
            .collection("appointment")
            .add({
          'contribId':
              contribId, ////----------------------------------------------------------------NEW ADDED

          'category': request.category.trim(),
          'date': request.date.trim(),
          'location': request.location.data,
          //  'status': request.status.trim(),
          'time': request.time.trim(),
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
      List<String>? userCat = null;
      int catLength = categories.length;
      for (var i = 0; i < catLength; i++) {
        userCat = categories.split(",");
      }
      /*  print("DB 97########################################################" +
          userCat!.length.toString() +
          "");*/

      QuerySnapshot query = await _firestore.collection("institution").get();
      print("DB 119########################################################");
      bool flag = true;
      query.docs.forEach((element) {
        print("DB 122########################################################" +
            element.toString());

        // retVal.add(BookModel.fromDocumentSnapshot(doc: element));
        //==============
        int count = userCat!
            .length; // NULLABLE ###################################################################
        int indexIDs = 0;
        for (var i = 0; i < count; i++) {
          if (!element.get("category").contains(userCat[i])) {
            flag = false;
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

  /*@override
  void initState() {
    addRequest();
    super.initState();
  }*/

//=============================================================================================================== DELETE BUILD
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
} // END CLASS

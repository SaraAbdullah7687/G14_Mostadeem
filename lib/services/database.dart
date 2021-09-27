import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_xd/models/requestModel.dart';
import 'package:flutter_application_xd/models/appointmentModel.dart';

import 'dart:developer';

void main() {
  runApp(database());
}

class database extends StatelessWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
//    String day, GeoPoint location, String state, String time
  /* void initState() {
    findCategory("jjjjjjjjj");
  }*/

  // Add request to database *call it in location page*
  Future<String> addRequest(String contribId, requestModel request) async {
    String retVal = "error";

    try {
      DocumentReference _docRef = await _firestore
          .collection("contributor")
          .doc(contribId)
          .collection("request")
          .add({
        'day': "WED", //request.day!.trim(),

        ///****NULL CHECk '!' */
        'location':
            "37.4219983 -122.084", // request.location, //NO NULL CHECK!!
        'state': "NEW", //request.state!.trim(),
        'time': "00:00 am" //request.time!.trim
      });
      //////=================================
      /* to be reviewd *why?  AZ *
    QuerySnapshot query = await _firestore  /* is it fine to acess appioments collection direct? AZ */
          .collection("appointment")
          .doc(appId).set("state: unavalible");*/
      ///===========
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  // Find institutions that has the selected category  ----------------------------------------------------------------
  Future<List<String>> findCategory(String categories) async {
    List<String> insIDs = []; //list(); /* i changed varible name AZ */

// string formalition
    List<String>? userCat = null;
    int catLength = categories.length;
    for (var i = 0; i < catLength; i++) {
      userCat = categories.split(",");
    }

    QuerySnapshot query = await _firestore.collection("instituation").get();
    /* log('data: $query');
    print(query);*/

    bool flag = true;
    query.docs.forEach((element) {
      // retVal.add(BookModel.fromDocumentSnapshot(doc: element));
      //==============
      int count = userCat!.length; /* what do u mean by "!" AZ */
      int indexIDs = 0;
      for (var i = 0; i < count; i++) {
        if (!element.get("category").contains(userCat[i])) {
          flag = false;
        }
      } // inner loop

      if (flag)
      {
        insIDs[indexIDs] = element.id; // .add ####################
      }
      
      //===========
    } //outer loop
        );
    return insIDs;
  }

  
  Future<List<String>> findAvailable(List<String> insIDs) async {
    //// علامة الاستفهام في الاوتبوت
    List<String> appIDs = [];

    insIDs.forEach((element) async {
      QuerySnapshot query = await _firestore
          .collection("instituation")
          .doc(element)
          .collection("appointments")
          .get();

      query.docs.forEach((appoint) {
        //  retVal.add(BookModel.fromDocumentSnapshot(doc: element2));
        if (appoint.get("state").equals("available")) {
          // available SPELLING#################################################
          appIDs.add(appoint.id);
        }
      }); // inner foreach
    }); // END outer foreach

    return appIDs;
  } // END findAvailable

// CHANGE
Future<String> changeStateAndLocation(String appId /* OR insId */) async {
  /*  QuerySnapshot query = await _firestore
        .collection("instituation")
        .doc(
        .collection("appointment")
        .doc(appId)
        .update({"state": "unavalible"});
*/
    return "";
  }

  Future<List<requestModel>?> displayApps(List<requestModel> availableApps) async {
    //// في الواجهة

    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  /*Future<String> checkNoCurrentRequest(String contId) async {} 

    return "";
  }*/
} // END CLASS

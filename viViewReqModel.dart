import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:swe444/Models/request.dart';

class ViewRequestViewModel {
/* for ID*/
  var firebaseUser = FirebaseAuth.instance.currentUser;

  /* to store docs*/
  List itemsList = [];

  final CollectionReference requestList = FirebaseFirestore.instance
      .collection('contributor')
      .doc('1jJuO9tixUnDamCYf6Hx')
      .collection('request');

/* To retrive requests*/
  Future getRequestList() async {
    try {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await requestList
          //  .where("status", isEqualTo: "new")
          //  .orderBy("dateCreated")
          .get();
      print('I am here line 27 vi vi');

      querySnapshot.docs.forEach((element) {
        itemsList.add(element.data());
      });

      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future cancelRequest(int index) async {
    var docRef = FirebaseFirestore.instance
        .collection('contributor')
        .doc("X01gyr2qkFMP47ClkZHX")
        .collection("request")
        .doc();

// delete the document
    docRef.delete();
    print('WELL DONE!!!!!!');
  }
}

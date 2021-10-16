import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:swe444/Models/request.dart';

class ViewRequestViewModel {
/* for ID*/
  var firebaseUser = FirebaseAuth.instance.currentUser;

  final CollectionReference requestList = FirebaseFirestore.instance
      .collection('contributor')
      .doc('1jJuO9tixUnDamCYf6Hx')
      .collection('request');

  Future getRequestList() async {
    List itemsList = [];

    try {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await requestList
          .where("status", isEqualTo: "new")
          //        .orderBy("dateCreated")
          .get();

      querySnapshot.docs.forEach((element) {
        itemsList.add(element.data());
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

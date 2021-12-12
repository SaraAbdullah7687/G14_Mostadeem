import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mostadeem/models/Institution.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:swe444/Models/request.dart';

class ViewInstViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> _institutions;
  Stream<QuerySnapshot<Map<String, dynamic>>> _institutions2;
  List<String> searchResults = [];
  AuthService auth = AuthService();

  fetchInst() async {
    var firebase = FirebaseFirestore.instance
        .collection("institution")
        .where("status", isEqualTo: "approved");
    _institutions = firebase.orderBy("dateCreated").snapshots();
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get Institutions {
    return _institutions;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get Institutions2 {
    return _institutions;
  }

  List<String> get getSearchResults {
    return searchResults;
  }

  Future<int> getLength() async {
    int length = searchResults.length;
    notifyListeners();
    return length;
  }

  Future QueryInsts(String query) async {
    searchResults.clear();

    FirebaseFirestore.instance
        .collection('institution')
        .where("status", isEqualTo: "approved")
        .where('name', isGreaterThanOrEqualTo: query)
        .snapshots()
        .forEach((snapshot) {
      var i = snapshot.docs.iterator;
      while (i.moveNext()) {
        if (i.current["name"].toString().contains(query)) {
          String id = i.current.id;
          print(id);
          if (!searchResults.contains(id)) searchResults.add(id);
        }
      }
    }).onError((error, stackTrace) => print("error"));
    notifyListeners();
  }
}

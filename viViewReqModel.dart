import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:swe444/Models/request.dart';

class ViewRequestViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> _requests;
  Stream<QuerySnapshot<Map<String, dynamic>>> _currentRequests;
  AuthService auth = AuthService();
  final List<Flushbar> flushBars = [];

  fetchRequests() async {
    String uid = auth.getCurrentUserID();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    // print(uid + "in view model");
    var firebase = FirebaseFirestore.instance
        .collection("contributor")
        .doc(uid)
        .collection("request");
    _requests = firebase
        //    .where("status", isEqualTo: "pending")
        .where(
          "date",
          isGreaterThanOrEqualTo: dateFormat.format(DateTime.now()),
        )
        .orderBy("date")
        .snapshots(); // order by  + exclude old dates
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get requests {
    return _requests;
  }

  Future openLocation(Map location) async {
    print("in view model openLocation ");
    print(location['geopoint'].latitude);
    final String lat = location['geopoint'].latitude.toString();
    final String lng = location['geopoint'].longitude.toString();
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  String convertDate(BuildContext context, DocumentSnapshot document) {
    String date = document['date'].toString().substring(0, 10);
    return date;
  }

  String convertTime(BuildContext context, DocumentSnapshot document) {
    String before = document['time'].toString().substring(10); //9
    String time = before.substring(0, 5);
    return time;
  }

/*
void showTopSnackBar(BuildContext context ,String title,String message) => show(
        context,
        Flushbar(
          icon: Icon(Icons.error, size: 32, color: Colors.white),
          shouldIconPulse: false,
          title: title,
          message: message, // change message
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
          borderRadius: 16,
           barBlur: 20,
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
      );*/

/*
Future show(BuildContext context, Flushbar newFlushBar) async {
    await Future.wait(flushBars.map((flushBar) => flushBar.dismiss()).toList());
    flushBars.clear();

    newFlushBar.show(context);
    flushBars.add(newFlushBar);
  }*/

} // end class

///////////////////
/*
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
      .doc('HjwkryLRi4loaSunp9Pv')
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
/*
  Future cancelRequest(int index) async {
    var docRef = FirebaseFirestore.instance
        .collection('contributor')
        .doc("X01gyr2qkFMP47ClkZHX")
        .collection("request")
        .doc();

// delete the document
    docRef.delete();
    print('WELL DONE!!!!!!');
  }*/
}
*/

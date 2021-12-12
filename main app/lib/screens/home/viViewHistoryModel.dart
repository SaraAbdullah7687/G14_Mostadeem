import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:swe444/Models/request.dart';

class ViewHistoryViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> _requests;
  Stream<QuerySnapshot<Map<String, dynamic>>> _currentRequests;
  AuthService auth = AuthService();

  fetchRequests() async {
    String uid = auth.getCurrentUserID();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    // print(uid + "in view model");
    var firebase = FirebaseFirestore.instance
        .collection("contributor")
        .doc(uid)
        .collection("request");
    _requests =
        firebase.where("status", whereIn: ["done", "rejected", "canceled"])
            //  .orderBy("date")
            .snapshots();
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

  Future cancelRequest(String id) async {
    String uid = auth.getCurrentUserID();
    print('THE ID IS' + uid);
    FirebaseFirestore.instance
        .collection('contributor')
        .doc(uid)
        .collection("request")
        .doc(id)
        .delete();
    print('WELL DONE!!!!!!');
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

}

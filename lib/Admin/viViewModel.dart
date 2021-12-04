//import 'dart:js';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/components/twoButtonsAlert.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/services/database.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:swe444/Models/request.dart';

class ViewInstitutionViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> _institutions;
  Stream<QuerySnapshot<Map<String, dynamic>>> _instProfile;
    final List<Flushbar> flushBars = []; 
    final AuthService _auth = AuthService();

  fetchInstitutions() async {
    var firebase=  FirebaseFirestore.instance
        .collection('institution');
    _institutions =
        firebase.where("status", isEqualTo: "pending").orderBy("dateCreated" ).snapshots();
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get institutions {
    return _institutions;
  }

  fetchInstProfile(String uid) async {
    var _instProfile=  FirebaseFirestore.instance.collection('institution').doc(uid).snapshots();
    notifyListeners();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> get InstProfile {
    return _instProfile;
  }

Future sendingMails(String email) async {
  print("in view model hii ");
  String url = 'mailto:$email'; // specify mail from snapchot
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future goToTwitter(String account) async {
  print("in view model twitter ");
  String url = 'https://twitter.com/$account';
if (await canLaunch(url)) {
    await launch(url,forceWebView: true,enableJavaScript: true,
    enableDomStorage: true,);
  } else {
    throw 'Could not launch $url';
  }
}

Future goToWhatsapp(String phone) async {
 String newPhone= phone.substring(1);
String url ="whatsapp://send?phone=+966$newPhone"; // maybe needs to be modified to api?
if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future openLocation(Map location) async {
print("in view model openLocation ");
print(location['geopoint'].latitude);
final String lat=location['geopoint'].latitude.toString();
final String lng=location['geopoint'].longitude.toString();
final String googleMapsUrl= 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

if (await canLaunch(googleMapsUrl)) {
    await launch(googleMapsUrl);
  } else {
    throw 'Could not launch $googleMapsUrl';
  }

}


void showTopSnackBar(BuildContext context ,String title,String message, IconData icon) => show(
        context,
        Flushbar(
          icon: Icon(icon, size: 32, color: Colors.white),
          shouldIconPulse: false,
          title: title,
          message: message, // change message
          borderRadius: BorderRadius.circular(6),
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        //  margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
          
           barBlur: 20,
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
      );

Future show(BuildContext context, Flushbar newFlushBar) async {
    await Future.wait(flushBars.map((flushBar) => flushBar.dismiss()).toList());
    flushBars.clear();

    newFlushBar.show(context);
    flushBars.add(newFlushBar);
  }

}
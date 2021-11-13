//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:swe444/Models/request.dart';

class ViewInstitutionViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> _institutions;
  Stream<QuerySnapshot<Map<String, dynamic>>> _instProfile;

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




}
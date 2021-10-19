import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:swe444/Models/request.dart';

class ViewRequestViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> _requests;

  fetchRequests() async {
    var firebase=  FirebaseFirestore.instance
        .collection('requests');
    _requests =
        firebase.where("status", isEqualTo: "pending").snapshots(); // order by  + exclude old dates
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get requests {
    return _requests;
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

Future goToWhatsapp(String phone) async {
 String newPhone= phone.substring(1);
String url ="whatsapp://send?phone=+966$newPhone"; // maybe needs to be modified to api?
if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

String convertDate(BuildContext context, DocumentSnapshot document){
  String date = document['date'].toString().substring( 0,10);
return date;
}

String convertTime(BuildContext context, DocumentSnapshot document){
  String before = document['time'].toString().substring(10); //9
  String time = before.substring(0,5); 
return time;
}

}
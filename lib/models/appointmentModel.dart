import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class appointmentModel {
  String appId;
  String category;
  String date;
  GeoPoint location;
  // String? isAvailable; //نحذفه؟
  String time;

  appointmentModel({
    @required this.appId,
    @required this.category,
    @required this.date,
    @required this.location,
    //this.isAvailable,
    @required this.time,
  });

  /*requestModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    // appId = doc.documentID;
    category= doc.data["category"]
    day = doc.data["day"];
    location = doc.data["location"];
    state = doc.data["state"];
    time = doc.data['time'];
  }*/
}
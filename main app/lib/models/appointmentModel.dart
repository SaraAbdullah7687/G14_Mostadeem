import 'package:cloud_firestore/cloud_firestore.dart';

class appointmentModel {
  String appId;
  String category;
  String date;
  GeoPoint location;
  // String? isAvailable; //نحذفه؟
  String time;

  appointmentModel({
    this.appId,
    this.category,
    this.date,
    this.location,
    //this.isAvailable,
    this.time,
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

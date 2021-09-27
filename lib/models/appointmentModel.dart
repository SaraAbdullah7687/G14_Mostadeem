import 'package:cloud_firestore/cloud_firestore.dart';

class appointmentModel {
// category array
  String? day;
  GeoPoint? location;
  String? state;
  String? time;

  appointmentModel({
    this.day,
    this.location,
    this.state,
    this.time,
  });

  /*requestModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    // id = doc.documentID;
    day = doc.data["day"];
    location = doc.data["location"];
    state = doc.data["state"];
    time = doc.data['time'];
  }*/
}

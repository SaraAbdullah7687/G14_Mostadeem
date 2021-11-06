import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class requestModel {
//  String? reqId; =========================== DO WE NEED IT?

  String contId;
  String category;
  String date; // غيرته--------------------------------------------------------
  String time;
  GeoFirePoint location;
  String status;
  //String requestID;
  String title;
  //String contName;

  requestModel({
    //  this.reqId, ================================================

    this.contId,
    this.category,
    this.date,
    this.time,
    this.location,
    this.status,
    // this.requestID,
    this.title,
    // this.contName,
  });

  /*requestModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    reqId = doc.documentID;
    category= doc.data["category"]
    day = doc.data["day"];
    location = doc.data["location"];
    state = doc.data["state"];
    time = doc.data['time'];
  }*/
}

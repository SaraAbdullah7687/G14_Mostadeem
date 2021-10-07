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

  requestModel({
    //  this.reqId, ================================================

    required this.contId,
    required this.category,
    required this.date,
    required this.time,
    required this.location,
    required this.status,
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

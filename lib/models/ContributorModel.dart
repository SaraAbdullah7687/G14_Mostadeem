import 'package:cloud_firestore/cloud_firestore.dart';

class ContributorModel {
  String? uid;
  String? email;
  String? name;
  //final String phoneNum;

  ContributorModel({
    this.uid,
    this.email,
    this.name,
  });

  /*ContributorModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    // uid = doc.documentID;
   // email = doc.data['email'];
   // name = doc.data['name'];
  }*/
}

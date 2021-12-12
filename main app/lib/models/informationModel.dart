import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mostadeem/screens/request.dart';

class Information {
  final String id;
  final String description;
  final String title;

  Information(String i, String d, {this.id, this.description, this.title});

  Information.fromSnapshot(DocumentSnapshot snapshot)
      : description = snapshot['description'],
        id = snapshot.id,
        title = snapshot['title'];
}

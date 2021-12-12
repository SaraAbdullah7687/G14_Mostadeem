import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mostadeem/screens/request.dart';

class Institution {
  final String id;
  final String email;
  final String name;
  final String rates;
  final String status;
  final String ratesAvg;
  final int ratesNo;
  final String categories;

  Institution(
    String i,
    String m,
    String l,
    String r,
    String st,
    int rN,
    String cat, {
    this.id,
    this.email,
    this.name,
    this.rates,
    this.status,
    this.ratesAvg,
    this.ratesNo,
    this.categories,
  });

  Institution.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        email = snapshot['email'],
        id = snapshot.id,
        rates = snapshot['rates'],
        status = snapshot['status'],
        ratesAvg = snapshot['ratesAvg'],
        ratesNo = snapshot['ratesNo'],
        categories = snapshot['category'];
}

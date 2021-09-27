import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';

class requestScreen extends StatefulWidget {
  //static String tag = '/BookAppointmentScreen';
  @override
  requestScreenState createState() => requestScreenState();
}

class requestScreenState extends State<requestScreen> {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

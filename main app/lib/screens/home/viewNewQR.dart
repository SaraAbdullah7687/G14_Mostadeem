import 'package:flutter/material.dart';
import 'package:mostadeem/screens/home/home.dart';
import 'package:mostadeem/screens/home/points.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mostadeem/globals/global.dart' as globals;

class viewNewQR extends StatelessWidget {
  final String uid, code, status, dateCreated, docId;
  final double amount;
  viewNewQR(
      {final Key key,
      @required this.uid,
      @required this.code,
      @required this.amount,
      @required this.dateCreated,
      @required this.status,
      @required this.docId})
      : super(key: key);

  Widget build(BuildContext context) {
    String qrData = code + ',' + amount.toString() + ',' + docId;
    getPoints();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              getPoints();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => points()));
            }),
        title: Text('QR Code'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: Color.fromRGBO(1, 140, 93, 1),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 7,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              image: DecorationImage(
                image: AssetImage('assets/images/background.JPG'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              margin:
                  EdgeInsets.only(top: 160, left: 30, right: 30, bottom: 140),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 185, left: 65),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/square1.gif'),
                  fit: BoxFit.cover,
                ),
              ),
              height: 190,
              width: 190),
          Container(
            width: 600,
            margin: EdgeInsets.only(top: 190, left: 70, right: 70),
            child: QrImage(
                data: qrData, foregroundColor: Color.fromRGBO(48, 126, 80, 1)),
          ),
          Container(
            margin: EdgeInsets.only(top: 400, left: 50),
            child: Text(
              'Amount: ' +
                  amount.toString() +
                  ' SR\nCreated at: ' +
                  dateCreated,
              style: TextStyle(
                color: Color.fromRGBO(48, 126, 80, 1),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          )
        ]),
      ),
    );
  }
}

final firestoreInstance = FirebaseFirestore.instance;

String getPoints() {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  firestoreInstance
      .collection("contributor")
      .doc(firebaseUser.uid)
      .get()
      .then((value) {
    int points = (value.data()['points']);
    globals.userPoints = points;
  });
  return globals.userPoints.toString();
}

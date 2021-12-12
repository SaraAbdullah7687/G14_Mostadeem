import 'dart:core';

//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:mostadeem/components/advancedAlertNew.dart';
import 'package:mostadeem/screens/home/home.dart';
import 'package:mostadeem/screens/home/points.dart';
import 'package:mostadeem/screens/home/viewQR.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/components/advanceAlert.dart';
import 'package:mostadeem/shared/loading.dart';

import 'package:mostadeem/globals/global.dart' as globals;

class qrCodes extends StatefulWidget {
  const qrCodes({Key key}) : super(key: key);

  @override
  _qrCodesState createState() => _qrCodesState();
}

class _qrCodesState extends State<qrCodes> {
  String uid = '';

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    getName();
    getEmail();
    getPhone();
    getPoints();

    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('code')
                .where(('uid'),
                    isEqualTo: FirebaseAuth.instance.currentUser.uid)
                .where(('status'), isEqualTo: ('valid'))
                .orderBy('amount') //it returns snapshot.hasData false  Check it
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                print(snapshot.hasData);
                return Loading();

                //return Container(

                // child: Column (children: [

                //    Image.asset('assets/images/qrGreen.png', height:100),

                // ]
                //  )
                //);
              }
              if (snapshot.data.docs.length == 0) {
                return noQR('No valid QR codes',
                    'To generate a QR code, you can redeem your points');
              }

              return ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                    margin: EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Stack(children: <Widget>[
                      Row(children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(20, 14, 10, 5),
                                  child: Text(
                                    document['amount'].toDouble().toString() +
                                        ' SR',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: Color.fromRGBO(48, 126, 80, 1)),
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(13, 5, 20, 10),
                                  child: Text(
                                    'Created at: ' + document['dateRedeemed'],
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  )),
                            ]),
                      ]),
                      Positioned(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.brown[50],
                                  ),
                                  margin: EdgeInsets.only(right: 10, top: 12),
                                  height: 40,
                                  width: 80,
                                  child: OutlinedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0))),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return restorePointsCustomAlert(
                                              icon: Icons.arrow_circle_down,
                                              msgContent:
                                                  'Are you sure you want to restore your points',
                                              btn1Content: 'Cancel',
                                              btn2Content: 'Restore Points',
                                              status: 'valid',
                                              dateCreated: globals.todayDate,
                                              newPoints: (globals.userPoints +
                                                      (document['amount']
                                                              .toDouble() *
                                                          5.ceil()))
                                                  .ceil(),
                                              docId: document.id,
                                            );
                                          });
                                    },
                                    child: Text('Restore points',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color.fromRGBO(48, 126, 80, 1),
                                          fontSize: 11,
                                        )),
                                  )),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Color.fromRGBO(48, 126, 80, 0.3),
                                  ),
                                  margin: EdgeInsets.only(right: 10, top: 12),
                                  height: 40,
                                  width: 80,
                                  child: OutlinedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0))),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => viewQR(
                                              code: document['code'],
                                              status: document['status'],
                                              dateCreated:
                                                  document['dateRedeemed'],
                                              amount:
                                                  document['amount'].toDouble(),
                                              docId: document.id),
                                        ));
                                      },
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "View QR code  ",
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    48, 126, 80, 1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11.0,
                                              ),
                                            ),
                                            WidgetSpan(
                                              child: Icon(Icons.qr_code,
                                                  size: 16,
                                                  color: Color.fromRGBO(
                                                      48, 126, 80, 1)),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              )
                            ]),
                      )
                    ]),
                  );
                }).toList(),
              );
            }));
  }
}

final firestoreInstance = FirebaseFirestore.instance;

String getName() {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  firestoreInstance
      .collection("contributor")
      .doc(firebaseUser.uid)
      .get()
      .then((value) {
    String name = (value.data()['name']);
    globals.userName = name;
  });

  return globals.userName;
}

String getEmail() {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  firestoreInstance
      .collection("contributor")
      .doc(firebaseUser.uid)
      .get()
      .then((value) {
    String email = (value.data()['email']);
    globals.userEmail = email;
  });

  return globals.userEmail;
}

void getPhone() {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  firestoreInstance
      .collection("contributor")
      .doc(firebaseUser.uid)
      .get()
      .then((value) {
    String phone = (value.data()['phone']);
    globals.userPhone = phone;
  });
}

Widget noQR(String title, String msg) {
  return Center(
      child: Container(
          margin: EdgeInsets.only(top: 40),
          child: Column(children: [
            Image.asset('assets/images/qrGreen.png', height: 100),
            Text(
              '\n' + title + '\n',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(msg)
          ])));
}

class InvalidQRCodes extends StatefulWidget {
  const InvalidQRCodes({Key key}) : super(key: key);

  @override
  _InvalidQRCodesState createState() => _InvalidQRCodesState();
}

class _InvalidQRCodesState extends State<InvalidQRCodes> {
  String uid = '';
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    getName();
    getEmail();
    getPhone();
    getPoints();

    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('code')
                .where(('uid'),
                    isEqualTo: FirebaseAuth.instance.currentUser.uid)
                .where(('status'), isEqualTo: ('used'))
                .orderBy('used')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                print(snapshot.hasData);
                return Loading();

                //return Container(

                // child: Column (children: [

                //    Image.asset('assets/images/qrGreen.png', height:100),

                // ]
                //  )
                //);
              }
              if (snapshot.data.docs.length == 0) {
                return noQR('No used QR codes',
                    'To generate a QR code, you can redeem your points');
              }

              return ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                      margin: EdgeInsets.only(
                          top: 10, left: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Stack(children: <Widget>[
                        Row(children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(20, 15, 20, 8),
                                  child: Text(
                                    document['amount'].toDouble().toString() +
                                        ' SR',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: Color.fromRGBO(48, 126, 80, 1)),
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(20, 5, 20, 8),
                                  child: Text(
                                    'Created at: ' + document['dateRedeemed'],
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  )),
                            ],
                          ),
                          Positioned(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        document['dateUsed'].substring(0, 4) ==
                                                ('Used')
                                            ? "  " + document['dateUsed']
                                            : document['dateUsed'],
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: document['dateUsed']
                                                        .substring(0, 4) ==
                                                    ('Used')
                                                ? Colors.grey
                                                : Colors.orange,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      )),
                                ]),
                          )
                        ]),
                      ]));
                }).toList(),
              );
            }));
  }
}

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

class restorePointsCustomAlert extends StatelessWidget {
  IconData icon;
  String msgContent;
  String btn1Content;
  String btn2Content;
  String uid;
  String code;
  String status;
  String dateCreated;
  int newPoints;
  String docId;

  restorePointsCustomAlert({
    @required this.icon,
    @required this.msgContent,
    @required this.btn1Content,
    @required this.btn2Content,
    @required this.status,
    @required this.dateCreated,
    @required this.newPoints,
    @required this.docId,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.transparent),
              height: 180,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text(
                      msgContent,
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 14),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 120.0,
                            height: 40.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.orange[700]),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        width: 0, color: Colors.transparent),
                                  ))),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                btn1Content,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 120.0,
                            height: 40.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(48, 126, 80, 1)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        width: 0, color: Colors.transparent),
                                  ))),
                              onPressed: () {
                                setState() => globals.userPoints = newPoints;

                                try {
                                  getPoints();

                                  globals.userPoints = newPoints;
                                  //Navigator.of(context).push(
                                  // MaterialPageRoute(builder: (context)=>points()));

                                  FirebaseFirestore.instance
                                      .collection('contributor')
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .update({'points': globals.userPoints});
                                  FirebaseFirestore.instance
                                      .collection('code')
                                      .doc(docId)
                                      .update({'status': 'used'});

                                  FirebaseFirestore.instance
                                      .collection('code')
                                      .doc(docId)
                                      .update({
                                    'dateUsed': 'Restored to points at: \n' +
                                        globals.todayDate,
                                    'used': DateTime.now()
                                  });

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => points()));
                                  showTopSnackBar(context);
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: Text(
                                btn2Content,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ),
                        ])
                  ],
                ),
              ),
            ),
            Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(48, 126, 80, 1),
                  radius: 60,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 50,
                  ),
                )),
          ],
        ));
  }
}

final List<Flushbar> flushBars = [];

void showTopSnackBar(BuildContext context) => show(
      context,
      Flushbar(
        icon: Icon(Icons.check_outlined, size: 32, color: Colors.white),
        shouldIconPulse: false,
        title: 'Points restored Successfully',
        message: 'You can redeem the points again', // change message
        duration: Duration(seconds: 4),
        borderRadius: BorderRadius.circular(6),
        flushbarPosition: FlushbarPosition.TOP,
        barBlur: 20,
        backgroundColor: Colors.black.withOpacity(0.5),
      ),
    );

Future show(BuildContext context, Flushbar newFlushBar) async {
  await Future.wait(flushBars.map((flushBar) => flushBar.dismiss()).toList());
  flushBars.clear();

  newFlushBar.show(context);
  flushBars.add(newFlushBar);
}

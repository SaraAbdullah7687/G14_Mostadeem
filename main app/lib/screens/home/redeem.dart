import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/components/advancedAlertNew.dart';
import 'package:mostadeem/globals/global.dart' as globals;
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mostadeem/screens/home/home.dart';
import 'package:mostadeem/screens/home/stores.dart';
import 'package:mostadeem/screens/home/viewNewQR.dart';
import 'package:mostadeem/screens/home/viewQR.dart';
import 'package:mostadeem/screens/home/points.dart';

String code = '';
String points = '';
String documentId;

class redeem extends StatefulWidget {
  const redeem({Key key}) : super(key: key);

  @override
  _redeemState createState() => _redeemState();
}

class _redeemState extends State<redeem> {
  String sar;
  double sarNum = 0;
  double amount = globals.userPoints / 5;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Widget buildSAR() => TextFormField(
      cursorColor: Color.fromRGBO(48, 126, 80, 1),
      keyboardType: TextInputType.number,
      controller: _controller,
      validator: (value) {
        if (value == null) {
          return 'Required';
        } else if (_isNumeric(value) == false)
          return "Please enter a number";
        else if (amount < double.parse(_controller.text))
          return "You only have " + amount.toString() + ' SAR';
        else if (double.parse(_controller.text) < 0)
          return ('Please enter a positive number');
        else if (double.parse(_controller.text) == 0)
          return ('Please enter a non-zero number');
        else
          return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        prefixIcon: Padding(
          padding: EdgeInsets.all(0.0),
          child: Icon(Icons.money, color: Color.fromRGBO(48, 126, 80, 1)),
        ),
        labelText: 'Saudi Riyals',
        labelStyle: TextStyle(color: Color.fromRGBO(48, 126, 80, 1)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromRGBO(48, 126, 80, 1)),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onChanged: (value) => setState(() {
            sar = value;

            if (_isNumeric(value) && (double.parse(value) > 0)) {
              if (_controller.text == null)
                globals.newPoints = null;
              else if (_controller.text != '') {
                if (amount < double.parse(_controller.text))
                  globals.newPoints = '';
                else
                  globals.newPoints = "You will be redeeming " +
                      (((double.tryParse(_controller.text)) * 5).ceil())
                          .toInt()
                          .toString() +
                      ' points';
              } else if (_controller.text == '')
                globals.newPoints = "You will be redeeming 0 points";
            } else
              globals.newPoints = '';
          }));

  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }

  final firestoreInstance = FirebaseFirestore.instance;

  Widget buildCreateQr(BuildContext context) {
    return ElevatedButton(
      child: Text('Get QR Code',
          style: TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () async {
        code = generateRandomString(10);

        if (formKey.currentState.validate()) {
          sarNum = double.parse(sar);

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return qrCodeCustomAlert(
                    icon: Icons.qr_code,
                    msgContent:
                        'Are you sure you want to redeem your points and generate a qr code?',
                    btn1Content: 'Cancel',
                    btn2Content: 'Generate QR Code',
                    code: generateRandomString(10),
                    status: 'valid',
                    dateCreated: globals.todayDate,
                    amount: double.parse(sar),
                    uid: firebaseUser.uid,
                    sarNum: sarNum,
                    sar: sar);
              });
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
        primary: Color.fromRGBO(48, 126, 80, 1),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  TextEditingController _controller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String today = DateFormat('dd-MM-yyy').format(now);
    globals.todayDate = today;

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                height: 400,
                child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: formKey,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.brown[50],
                          ),
                          margin: EdgeInsets.only(
                            left: 30,
                            top: 20,
                          ),
                          height: 50,
                          width: 300,
                          child: TextButton.icon(
                              icon: Icon(
                                Icons.store,
                                color: Color.fromRGBO(48, 126, 80, 1),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => stores(),
                                ));
                              },
                              label: Text(
                                'View stores to redeem your points',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(48, 126, 80, 1)),
                              )),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                              top: 90,
                              left: 33,
                            ),
                            child: Text(
                              'Enter the amount of SR you want to use',
                              style: TextStyle(
                                  color: Color.fromRGBO(48, 126, 80, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                        Container(
                            margin:
                                EdgeInsets.only(left: 30, right: 26, top: 120),
                            child: Text(
                              'Please note that the QR code can be used (scanned) only once, so specify your need of SAR precisely',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            )),
                        Container(
                          margin:
                              EdgeInsets.only(top: 170, left: 20, right: 20),
                          child: buildSAR(),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 290, left: 90, right: 20),
                          child: buildCreateQr(context),
                        ),
                        Container(
                            margin:
                                EdgeInsets.only(top: 250, left: 20, bottom: 7),
                            child: Text(
                              globals.newPoints,
                              style: TextStyle(
                                  color: Colors.orange[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                      ],
                    )))));
  }
}

String generateRandomString(int len) {
  var r = Random();
  String randomString =
      String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
  return randomString;
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

class qrCodeCustomAlert extends StatelessWidget {
  IconData icon;
  String msgContent;
  String btn1Content;
  String btn2Content;
  String uid;
  String code;
  String status;
  String dateCreated;
  double amount;
  String sar;
  double sarNum;

  qrCodeCustomAlert({
    @required this.icon,
    @required this.msgContent,
    @required this.btn1Content,
    @required this.btn2Content,
    @required this.uid,
    @required this.code,
    @required this.status,
    @required this.dateCreated,
    @required this.amount,
    @required this.sarNum,
    @required this.sar,
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
              height: 200,
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
                            width: 100.0,
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
                            width: 100.0,
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
                                try {
                                  firestoreInstance.collection("code").add({
                                    "amount": amount,
                                    "code": code,
                                    "dateRedeemed": dateCreated,
                                    "status": status,
                                    'uid': uid,
                                  });
                                  int usedPoints = (sarNum * 5.ceil()).toInt();
                                  FirebaseFirestore.instance
                                      .collection('contributor')
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .update({
                                    'points': globals.userPoints - usedPoints
                                  });

                                  getPoints();

                                  FirebaseFirestore.instance
                                      .collection('code')
                                      .where(('code'), isEqualTo: code)
                                      .get()
                                      .then((snapshot) {
                                    globals.newQRDocId = snapshot.docs.first.id;

                                    print(globals.newQRDocId);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => viewNewQR(
                                                code: code,
                                                status: 'valid',
                                                dateCreated: globals.todayDate,
                                                amount: double.parse(sar),
                                                docId: globals.newQRDocId)));
                                    globals.newPoints = '';
                                    getPoints();
                                  });

                                  documentId = globals.newQRDocId;
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: Text(
                                btn2Content,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                                textAlign: TextAlign.center,
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

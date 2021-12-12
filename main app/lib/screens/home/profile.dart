import 'dart:core';

//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:another_flushbar/flushbar.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mostadeem/screens/home/changePass.dart';
import 'package:mostadeem/screens/home/editProfile.dart';
import 'package:mostadeem/screens/home/home.dart';
import 'package:mostadeem/screens/authenticate/bodyLogin.dart';
import 'package:mostadeem/Admin/components/social_icon.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/components/advanceAlert.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'package:mostadeem/globals/global.dart' as globals;

class profile extends StatefulWidget {
  const profile({Key key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  String uid = '';
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    getName();
    getEmail();
    getPhone();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          child: Column(children: <Widget>[
            Stack(children: <Widget>[
              Container(
                  height: 160,
                  margin:
                      EdgeInsets.only(top: 20, bottom: 10, left: 15, right: 20),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: Stack(children: <Widget>[
                    ListTile(
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                          Row(children: <Widget>[
                            Icon(
                              Icons.person,
                              color: Color.fromRGBO(48, 126, 80, 1),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
                                child: Text(globals.userName,
                                    style: TextStyle(fontSize: 20))),
                          ]),
                          // Change it to globals

                          TextButton.icon(
                              icon: Icon(Icons.edit_outlined,
                                  color: Color.fromRGBO(48, 126, 80, 1),
                                  size: 28),
                              label: Text('Edit Profile',
                                  style: TextStyle(
                                    color: Color.fromRGBO(48, 126, 80, 1),
                                  )),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: Color.fromRGBO(48, 126, 80, 1)),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => editProfile(),
                                ));
                              })
                        ])),
                    Row(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 65, 20, 20),
                        child: Icon(
                          Icons.mail,
                          color: Color.fromRGBO(48, 126, 80, 1),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 65, 20, 20),
                          child: Text(globals.userEmail,
                              style: TextStyle(fontSize: 20))),
                    ]),
                    Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(15, 105, 20, 20),
                          child: Icon(
                            Icons.phone,
                            color: Color.fromRGBO(48, 126, 80, 1),
                          )),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 105, 20, 20),
                          child: Text(globals.userPhone,
                              style: TextStyle(fontSize: 20))),
                    ]),
                  ])),
            ]),
            InkWell(
              child: Container(
                child: ListTile(
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 20, 20),
                        child: Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 20, 15),
                          child: Text('Change Password',
                              style: TextStyle(
                                  fontSize: 22, color: Colors.white))),
                    ])),
                height: 60,
                margin:
                    EdgeInsets.only(top: 15, bottom: 20, left: 20, right: 20),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(48, 126, 80, 1),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ]),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => changePass(),
                ));
              }, //Reset Password
            ),
            InkWell(
                child: Container(
                  child: ListTile(
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 20, 20),
                          child: Icon(
                            Icons.logout_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 20, 20),
                            child: Text('Logout',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white))),
                      ])),
                  height: 60,
                  margin:
                      EdgeInsets.only(top: 0, bottom: 30, left: 20, right: 20),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(48, 126, 80, 1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ]),
                ),
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return logOutCustomAlert(
                            icon: Icons.logout_outlined,
                            msgContent: 'Are you sure you want to log out\n',
                            btn1Content: 'cancel',
                            btn2Content: 'Log out');
                      });
                } //Logout
                ),

            /*    InkWell(
                      child: Container(
                        child: ListTile(
                           title: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: <Widget>[

                             Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 20, 20),
                                child: Icon(Icons.delete_forever,
                               color: Colors.red.shade700,
                                size: 28,),
                             ),

                           Padding(
                           padding: EdgeInsets.fromLTRB(0, 10, 20, 20),
                           child: Text('Delete Account',
                           style: TextStyle(fontSize: 22,
                           color: Colors.red.shade700,
                          ))),
                             ]
                           )                 
                           ),
                       
                       height: 60,
                       margin: EdgeInsets.only(top:0, bottom: 30, left: 20, right: 20),
                       alignment: Alignment.topCenter,
                       decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.all(Radius.circular(20)),
                       boxShadow: [
                       BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),)]

                    ),
                      ),
                      onTap: (){},  //Delete account
                    ),


                    */
          ]),
        ),
      ),
    );
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

class logOutCustomAlert extends StatelessWidget {
  IconData icon;
  String msgContent;
  String btn1Content;
  String btn2Content;

  logOutCustomAlert({
    @required this.icon,
    @required this.msgContent,
    @required this.btn1Content,
    @required this.btn2Content,
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
                              onPressed: () async {
                                try {
                                  await AuthService().signOut();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BodyLogin()),
                                      (route) => false);

                                  showTopSnackBar(context);
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: Text(
                                btn2Content,
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
        title: 'Logged out',
        message: 'You have been logged out successfully', // change message
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

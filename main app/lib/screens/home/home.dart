//import 'package:mustadeem/screens/home/brew_list.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mostadeem/screens/home/profile.dart';
import 'package:mostadeem/screens/home/requestsHome.dart';

import 'package:mostadeem/services/auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../initiate.dart';
// SARA NOTIFICATIONS
import 'package:mostadeem/services/localNotific.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:mostadeem/globals/global.dart' as globals;

import 'home0.dart';

class Home extends StatefulWidget {
  const Home({
    Key key,
    this.feedback,
  }) : super(key: key);

  final Function feedback;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeZero obj = new HomeZero();
  // SARA
  @override
  void initState() {
    super.initState();

    tz.initializeTimeZones();

    /*MODHI*/
    /*  WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        widget.feedback.call();
      },
    );*/
  }
  // END SARA

  final AuthService _auth = AuthService();

  final screens = [
    // indexes Sensitive
    HomeZero(),
    initiateRequest(), // for request
    RequestsHome(),
    profile(), //profile
  ];

  int index = 0;

  final items = <Widget>[
    Icon(Icons.home, size: 30),
    Icon(Icons.add, size: 30),
    Icon(Icons.local_shipping, size: 30),
    Icon(Icons.person, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    obj.getInfo();
    getPoints();
    getName();
    getEmail();
    getPhone();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        extendBody: true,

        //  backgroundColor: Colors.white10,
        body: screens[index],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(color: Colors.white),
          ),
          child: CurvedNavigationBar(
            color: Color.fromRGBO(48, 126, 80, 1),
            // buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            height: 60, // decreced nav height
            items: items,
            index: index,
            animationDuration: Duration(microseconds: 5000),
            onTap: (index) => setState(() => this.index = index),
          ),
        ));
  }
}

final firestoreInstance = FirebaseFirestore.instance;

String getPoints() {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  firestoreInstance
      .collection('contributor')
      .doc(firebaseUser.uid)
      .get()
      .then((value) {
    int points = (value.data()['points']);
    globals.userPoints = points;
  });
  return globals.userPoints.toString();
}

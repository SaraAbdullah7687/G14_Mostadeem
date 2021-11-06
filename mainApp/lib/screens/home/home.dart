//import 'package:mustadeem/screens/home/brew_list.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mostadeem/Admin/components/social_icon.dart';
import 'package:mostadeem/Screens/request.dart';
import 'package:mostadeem/screens/home/profile.dart';
import 'package:mostadeem/screens/home/viewReq.dart';
import 'package:mostadeem/screens/viewInstituation.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mostadeem/Screens/home/home0.dart';
import 'package:url_launcher/url_launcher.dart';
import '../initiate.dart';
// SARA NOTIFICATIONS
import 'package:mostadeem/services/localNotific.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

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
  // SARA
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    /*MODHI*/
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        widget.feedback.call();
      },
    );
  }
  // END SARA

  final AuthService _auth = AuthService();

  final screens = [
    // indexes Sensitive
    HomeZero(),
    initiateRequest(), // for request
    ViewRequest(),
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

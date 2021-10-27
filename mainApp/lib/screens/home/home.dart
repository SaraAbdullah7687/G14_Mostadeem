//import 'package:mustadeem/screens/home/brew_list.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mostadeem/Screens/request.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mostadeem/Screens/home/home0.dart';
import 'package:mostadeem/Screens/home/profile.dart';

// SARA NOTIFICATIONS
import 'package:mostadeem/services/notific.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'package:mostadeem/services/notific.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // SARA
  @override
  void initState() {
    super.initState();

    tz.initializeTimeZones();
  }
  // END SARA

  final AuthService _auth = AuthService();

  final screens = [
    // indexes Sensitive
    HomeZero(),
    requestScreen(), // for request
    Profile(),
  ];

  int index = 0;

  final items = <Widget>[
    Icon(Icons.home, size: 30),
    Icon(Icons.add, size: 30),
    Icon(Icons.person, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      /* appBar: AppBar(
          backgroundColor: Color.fromRGBO(103, 145, 61, 1),
          centerTitle: true,
          title: const Text('MOSTADEEM'),
        ),*/
      /*
         appBar: AppBar(
           shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(18),
      ),
    ),
      /*  title: Text(
          "MOSTADEEM",
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),*/
        
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),//Color.fromRGBO(103, 145, 61, 1),
        elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person , size: 30.0,
            color: Colors.white,),
              label: Text(
          "Logout",
          style: TextStyle(color: Colors.white,
          ),
        ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
          toolbarHeight:80.0,
        ),
*/

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
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromRGBO(236, 232, 201, 0.7)
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    // canvas.drawShadow(path, Colors.grey, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

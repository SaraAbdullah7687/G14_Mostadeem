import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// new screen page
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(103, 145, 61, 1),
          centerTitle: true,
          title: const Text('Home'),
        ),
        //  backgroundColor: Colors.white10,
        body: Stack(
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: size.width,
                  height: 80,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(size.width, 80),
                        painter: BNBCustomPainter(),
                      ),
                      Center(
                        heightFactor: 0.6,
                        child: FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: Color.fromRGBO(103, 145, 61, 1),
                          child: Icon(Icons.add_circle),
                          elevation: 0.1,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 30, bottom: 20),
                        width: size.width,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.house_rounded,
                                  color: Color.fromRGBO(103, 145, 61, 1),
                                  size: 50,
                                ),
                                onPressed: () {}),
                            IconButton(
                                icon: Icon(
                                  Icons.person_rounded,
                                  color: Color.fromRGBO(103, 145, 61, 1),
                                  size: 50,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ));
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



----------------------------------------------------------------------------------



/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Confirmation(),
    );
  }
}

class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  _ConfirmationState createState() => _ConfirmationState();
}

// new screen page
class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        color: Colors.white,
        height: size.height,
        width: double.infinity,
        child: Stack(children: <Widget>[
          Positioned(
            child: Image.asset('assets/images/main_top.png'),
          ),
          Positioned(
            bottom: 0,
            width: size.width,
            child: Image.asset('assets/images/main_bottom.png'),
          ),
          Positioned(
            left: 0,
            top: 190,
            width: size.width,
            child: Icon(
              Icons.celebration,
              size: 50,
              color: Color.fromRGBO(103, 145, 61, 1),
            ),
          ),
          Positioned(
              left: 100,
              top: 250,
              child: Text('We have recevied your request!',
                  style: TextStyle(
                    color: Color.fromRGBO(103, 145, 61, 1),
                    fontSize: 20,
                  ))),
          /*  Positioned(
            left: 60,
            top: 620,
            width: 300,
            height: 50,
            child: ElevatedButton(
              child: Text('Register',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(231, 226, 204, 1),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),*/
        ]));
  }
}*/

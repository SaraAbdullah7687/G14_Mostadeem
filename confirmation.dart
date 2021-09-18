import 'dart:async';
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
}

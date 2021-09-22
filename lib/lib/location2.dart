// ignore_for_file: deprecated_member_use

import 'dart:async';
//import 'dart:html';
import 'confirmation.dart';
import 'package:flutter/material.dart';
// import location packges
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FirebaseApp LocationApp = await Firebase.initializeApp();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LocationApp(),
    );
  }
}

class LocationApp extends StatefulWidget {
  const LocationApp({Key? key}) : super(key: key);

  @override
  _LocationAppState createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  //*السوري*//
  Completer<GoogleMapController> _controller = Completer();

  // when page first open this will show
  static final CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(24.724797214237658, 46.63837971603376), zoom: 14.4746);

  LatLng currentLocation = _initialCameraPosition.target;

  @override
  Widget build(BuildContext contexts) {
    // ignore: unnecessary_new
    return new Scaffold(
      body: GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          mapType: MapType.normal,
          onMapCreated: (controller) => _controller.complete(controller),

          /* to move camera*/
          onCameraMove: (CameraPosition newPos) {
            setState(() {
              currentLocation = newPos.target;
            });
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0, right: 40),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => getCurrentLocation(),
          child: Icon(
            Icons.gps_fixed,
            color: Color.fromRGBO(103, 145, 61, 1),
          ),
        ),
      ),

///////////////////////////////////////////

      /* to display location lang+long*/

      bottomNavigationBar: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AdvanceCustomAlert();
              });
        },
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25.0),
        ),
        backgroundColor: Color.fromRGBO(103, 145, 61, 1),
        child: Text(
            "Use This Location\n ${currentLocation.latitude} , ${currentLocation.longitude}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }

/*to get user current location*/
  Future<void> getCurrentLocation() async {
    final postition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _animateCamera(postition);
  }

/* move camera to user current location*/
  Future<void> _animateCamera(Position position) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 25.4746,
    );
    print(
        'animating camera to (lat: ${position.latitude}, long: ${position.longitude}"');
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }
}

class AdvanceCustomAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(15),
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: 200,
            width: 300,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white70,
                      child: Icon(
                        Icons.celebration,
                        size: 60,
                        color: Color.fromRGBO(103, 145, 61, 1),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    color: Color.fromRGBO(103, 145, 61, 1),
                    child: SizedBox.expand(
                      child: Column(
                        children: [
                          Text(
                            'Done!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'we have recievd your request',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          RaisedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Confirmation()), /*CHANGE IT TO HOME PAGE*/
                                );
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: Color.fromRGBO(103, 145, 61, 1),
                                ),
                              ))
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

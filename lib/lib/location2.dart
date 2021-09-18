import 'dart:async';
//import 'dart:html';

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
            // backgroundColor: Color.(fromRGBO(103, 145, 61, 1),
            color: Color.fromRGBO(103, 145, 61, 1),
          ),
        ),
      ),

///////////////////////////////////////////

      /* to display location lang+long*/

      bottomNavigationBar: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
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
/*
        bottomNavigationBar: Container(
          height: 60,
          alignment: Alignment.center,
          child: Text(
              "lat: ${currentLocation.latitude}, long: ${currentLocation.longitude}"),
        )*/
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

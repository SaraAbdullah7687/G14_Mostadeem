// ignore_for_file: unnecessary_new

import 'dart:async';
import 'dart:html';

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
  static final CameraPosition _initialCameraPosition =
      CameraPosition(target: LatLng(33.515343, 36.289590), zoom: 14.4746);

  var locationMessage; // ***** This variavle will contain the locatin coordonates *****

  /*ANOTHER WAY*/
  String longitudeData = "";
  String latitudeData = "";
/* to call it imedetily */
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  // ******** FUNCTION ***********
  void getCurrentLocation() async {
    final postition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // var lastPosition = await Geolocator.getLastKnownPosition();
    // print(lastPosition);

    setState(() {
      latitudeData = '${postition.latitude}';
      longitudeData = '${postition.longitude}';
    });
  }

  @override
  Widget build(BuildContext contexts) {
    Color c = const Color(0xFF467c54);
    return new Scaffold(
      /*  body: Row( GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      )),*/

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              size: 50.0,
              color: Color.fromRGBO(188, 212, 104, 1),
            ),

            const SizedBox(
              height: 20.0,
            ),
            Text("My location : $latitudeData, $longitudeData"),
            // ignore: deprecated_member_use

            /*const SizedBox(
              height: 10.0,
            ),
            const Text(
              "Set My Location",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),*/

            /****to put space */
            Container(
              margin: const EdgeInsets.all(10),
            ),

            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                //  getCurrentLocation();
              },
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              color: Color.fromRGBO(55, 126, 84, 1),
              child: const Text("Set My Location",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}











/* I DONT KNOW
class AddingImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*global varivle to add image*/
    AssetImage assetImage = const AssetImage('assets/main_top.png');
    Image image = Image(
      image: assetImage,
    );
    return Container(
      child: image,
    );
  }
}*/

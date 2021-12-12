// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mostadeem/components/advancedAlertNew.dart';
import 'package:mostadeem/globals/global.dart';
import 'package:mostadeem/models/contributorModel.dart';
import 'package:mostadeem/models/requestModel.dart';
import 'package:mostadeem/screens/home/home.dart';
import 'package:mostadeem/screens/home/requestsHome.dart';
import 'package:mostadeem/screens/request.dart';
import 'package:mostadeem/services/database.dart';
import 'package:mostadeem/main.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mostadeem/services/auth.dart';
// to store geoPoints
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:mostadeem/screens/calendar.dart';
import 'package:mostadeem/globals/global.dart' as global;
import 'package:mostadeem/services/localNotific.dart';

import 'initiate.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp LocationApp = await Firebase.initializeApp();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LocationApp(category: ' ', date: ' ', time: ' '),
    );
  }
}
*/
//AuthService a = new AuthService();
AuthService auth = AuthService();
/*newly added*/
var firebaseUser = FirebaseAuth.instance.currentUser;

class LocationApp extends StatefulWidget {
  String uid = auth.getCurrentUserID();
  //const LocationApp({Key? key, String category}) : super(key: key);
  String category; //FINAL ?
  String date;
  String time;
  String title;
  /*newly added*/
  //String currentUser = firebaseUser.uid;

//===========================================================================================

  LocationApp(
      {this.category,
      this.date,
      this.time,
      /*this.currentUser*/ uid,
      this.title});

  @override
  _LocationAppState createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  // FINAL STEP > ADD to database
  void _addRequest(
      BuildContext context, String contId, requestModel request) async {
    // NEED PARAMETERS ==================================================================================================================
    String _returnString;
    await Firebase.initializeApp();
    if (!global.isSpecific) {
      _returnString = await DatabaseService().addRequest(contId, request);
    } else {
      _returnString = await DatabaseService()
          .addRequestForSpec(contId, request, global.insName);
    }
    print("add success inside if in location line 79");

    if (_returnString == "success") {
/*SARA*/
      print("add success inside if in location line 84");
      // اشيل الاشعار اللي بسطر 421
      print("______Date in location___________$globalDate");
      Duration difference = global.globalDate.difference(DateTime.now());
      // if (difference.inHours > 24) {
      print("diff inside if in location line 88");
      NotificationService().showNotification(1, "Pickup Reminder",
          "Your request will be pickuped today.", 4 /*difference.inHours*/);
      //  }

      global.globalDate = null;
      global.globalTime = null;
      global.isSpecific = false;
      global.insName = "";
      global.institutions = [];
      global.reqCat = [
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false
      ];

      /* Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ),
          (route) => false);*/
    } // END inner if
    /* }*/ else {
      // WE must show error msg
      print("Sorry! the request not recievd");
    }
  } // END FINAL STEP > ADD to database

// when onPressed: take the cats and go to calendar screens
  void _goToCalendar(BuildContext context, String thisCategory) async {
    // AFNAN
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(
          // Calendar
          category: thisCategory,
        ),
      ),
    );
    //SARA
    /* Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => calendarScreen(
          category: thisCategory,
        ),
      ),
    );*/
  }

  //*السوري*//
  Completer<GoogleMapController> _controller = Completer();
  /* to add marker*/
  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;
  // when page first open this will show
  static final CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(24.724797214237658, 46.63837971603376), zoom: 14.4746);
  LatLng currentLocation = _initialCameraPosition.target;

  @override
  Widget build(BuildContext contexts) {
    // ignore: unnecessary_new
    return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Location'),
          backgroundColor: Color.fromRGBO(48, 126, 80, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(18),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              // ==========================================================================================================
              _goToCalendar(context, widget.category);
            },
          ),
          toolbarHeight: 60.0,
        ),
        body: Column(children: [
          Container(
            width: 280,
            margin: EdgeInsets.only(left: 10),
            child: Image.asset(
              'assets/images/step3.png',
              alignment: Alignment.center,
              height: 80,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            alignment: Alignment.center,
            //  borderRadius: BorderRadius.circular(25),
            /*decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Color.fromRGBO(48, 126, 80, 1), // red as border color
              ),
            ),*/
            child: SizedBox(
              width: 300, // or use fixed size like 200
              height: 480,

              child: GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  mapType: MapType.normal,
                  onMapCreated: (controller) =>
                      _controller.complete(controller),
                  markers: _markers,
                  onTap: _handelTap,

                  /* to move camera*/
                  onCameraMove: (CameraPosition newPos) {
                    setState(() {
                      currentLocation = newPos.target;
                    });
                  }),
            ),
          ),
          /* Container(
            padding: const EdgeInsets.only(bottom: 40.0, right: 40),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () => getCurrentLocation(),
              child: Icon(
                Icons.gps_fixed,
                color: Color.fromRGBO(48, 126, 80, 1),
              ),
            ),
          ),*/
        ]),
///////////////////////////////////////////

        /* to display location lang+long*/
        bottomNavigationBar: SizedBox(
          height: 45,
          child: FloatingActionButton(
            onPressed: () async {
              //======================================================================================================================
              // Init firestore and geoFlutterFire
              final geo = Geoflutterfire();
              GeoFirePoint point = geo.point(latitude: lat, longitude: lng);

              // make request obj
              requestModel request = requestModel(
                contId: widget
                    . /*this.currentUser*/ uid, // NULLABLE ###################################################################
                category: widget.category,
                date: widget.date,
                time: widget.time,
                title: widget.title,
                location: geo.point(latitude: lat, longitude: lng),
                status: 'pending',
              );

              // ADD TO DB
              _addRequest(context, widget. /*this.currentUser*/ uid,
                  request); // NULLABLE ###################################################################

              /* display conformation pop up*/
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AdvanceCustomAlertNew2(
                      icon: Icons.celebration,
                      msgContent: 'We have recievd your request.',
                      btnContent: 'Ok',
                    );
                  });
            },
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(25.0),
            ),
            backgroundColor: Color.fromRGBO(48, 126, 80, 1),
            child: Text("Submit The Request",
                // ${currentLocation.latitude} , ${currentLocation.longitude}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  //fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ),
        ));
  }

  /////////////METHOD////////////
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
      zoom: 19.4746,
    );
    print(
        'animating camera to (lat: ${position.latitude}, long: ${position.longitude}"');
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
    // controller.showMarkerInfoWindow(MarkerId('id-1'));
    // markerMethod(position);
    LatLng moveableLocation = LatLng(position.latitude, position.longitude);
    _handelTap(moveableLocation);
    // _onMapCreated(controller, position);
  }

  /*void _onMapCreated(GoogleMapController controller, Position position) {
    /// Convenience hue value representing green.
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('id-1'),
          icon: mapMarker,
          // icon: BitmapDescriptor.defaultMarkerWithHue(
          //    (true) ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
            title: 'Your current location',
            snippet: '${position.latitude}, ${position.longitude}',
          ),
        ),
      );
    });
  }*/

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();

    getCurrentLocation();
    setCustomMarker();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker.png');
  }

  double lat;
  double lng;
  void _handelTap(LatLng tappedPoint) {
    final posi = tappedPoint;
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('id-1'),
        icon: mapMarker,
        // icon: BitmapDescriptor.defaultMarkerWithHue(
        //    (true) ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed),
        position: tappedPoint,
        draggable: true,
        onDragEnd: (dragEndPosition) {
          print(dragEndPosition);
        },
        infoWindow: InfoWindow(
          title: 'Your current location',
          snippet: '${tappedPoint.latitude}, ${tappedPoint.longitude}',
        ),
      ));
    });

    lat = posi.latitude;
    lng = posi.longitude;

    // posi = tappedPoint as Position;
  }

/*
  Future<void> markerMethod(Position position) async {
    final GoogleMapController controller = await _controller.future;

    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId('id-1'),
            position: LatLng(position.latitude, position.longitude)),
      );
    });
  }*/
}

class AdvanceCustomAlertNew2 extends StatelessWidget {
  IconData icon;
  String msgContent;
  String btnContent;

  AdvanceCustomAlertNew2({
    @required this.icon,
    @required this.msgContent,
    @required this.btnContent,
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
                    SizedBox(
                      width: 100.0,
                      height: 40.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange[700]),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                  width: 0, color: Colors.transparent),
                            ))),
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (icon == Icons.celebration) {
                            //=======================================================================================================================
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                            /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()),
                                );*/
                          }
                        },
                        child: Text(
                          btnContent,
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
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

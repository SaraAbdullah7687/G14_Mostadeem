import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mostadeem/services/auth.dart';

import 'package:url_launcher/url_launcher.dart';

// RATING
import 'package:rating_dialog/rating_dialog.dart';

// import 'package:swe444/Models/request.dart';

class ViewRequestViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> _requests;
  Stream<QuerySnapshot<Map<String, dynamic>>> _currentRequests;
  AuthService auth = AuthService();

  fetchRequests() async {
    String uid = auth.getCurrentUserID();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    // print(uid + "in view model");
    var firebase = FirebaseFirestore.instance
        .collection("contributor")
        .doc(uid)
        .collection("request");
    _requests = firebase
        .where("status", isNotEqualTo: ("done"))
        //  .orderBy("date")
        .snapshots();
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get requests {
    return _requests;
  }

  Future openLocation(Map location) async {
    print("in view model openLocation ");
    print(location['geopoint'].latitude);
    final String lat = location['geopoint'].latitude.toString();
    final String lng = location['geopoint'].longitude.toString();
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  String convertDate(BuildContext context, DocumentSnapshot document) {
    String date = document['date'].toString().substring(0, 10);
    return date;
  }

  String convertTime(BuildContext context, DocumentSnapshot document) {
    String before = document['time'].toString().substring(10); //9
    String time = before.substring(0, 5);
    return time;
  }

  Future cancelRequest(String id) async {
    String uid = auth.getCurrentUserID();
    print('THE ID IS' + uid);
    FirebaseFirestore.instance
        .collection('contributor')
        .doc(uid)
        .collection("request")
        .doc(id)
        .delete();
    print('WELL DONE!!!!!!');
  }

// rating===============================================================================================================
  AuthService _authRating = AuthService();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> Rating(BuildContext context) async {
    String uid = _authRating.getCurrentUserID();
    int itrationDetecter = 0;

    QuerySnapshot query = await _firestore
        .collection("contributor")
        .doc(uid)
        .collection("request")
        .get();
    print("Docs number: ");
    print(query.size);

    query.docs.forEach((request) async {
      print(
          'LINE 335 home0.dart AND i= $itrationDetecter===========================================');
      String insName = "";
      String catFeildName = 'Category: ';
      if (request['status'] == 'pending') {
        // Change to ^DONE #########################################################################################333###############3333
        print(
            'LINE 339 home0.dart AND i= $itrationDetecter===========================================');
        // NEED change to 'DONE'++++++++++++++++++++++++++++++=====================
        if (",".allMatches(request["category"]).length >= 1) {
          catFeildName = "Categories: ";
        }
        print(
            'LINE 344 home0.dart AND i= $itrationDetecter===========================================');
        // get insName
        await _firestore
            .collection("institution")
            .doc(request["insID"])
            .get()
            .then((value) {
          insName = value.data()['name'];
          print(
              'insNAme is: $insName===========================================');
        });
        print(
            'LINE 359 home0.dart AND i= $itrationDetecter===========================================');
        // dialog  *****
        final _dialog = RatingDialog(
          initialRating: 1.0,
          starSize: 30,
          // your app's name?
          title: Text(
            'Request Rating',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(48, 126, 80, 1)),
          ),
          // encourage your user to leave a high rating?
          message: Text(
            'Title: ' +
                request["title"] +
                /* 
               '\n' +
                catFeildName +
                request["category"] +
                '\nDate: ' +
                request["date"].toString().substring(0, 11) +
                */
                '\nInstitution: ' +
                insName +
                '\n\nTap a star to set your rating.',

            //'Tap a star to set your rating.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
          // your app's logo?
          image: Image.asset(
            'assets/images/logo.png',
            width: 100,
            height: 100,
          ),
          submitButtonText: 'Submit',
          enableComment: false,
          //  commentHint: 'Set your custom comment hint',
          onCancelled: () {
            print('cancelled');
            //  continue;
          },
          onSubmitted: (response) async {
            print('rating: ${response.rating}, comment: ${response.comment}');

            // TODO: add your own logic
            // get the ins.
            String oldRates = "";
            await _firestore
                .collection("institution")
                .doc(request["insID"])
                .get()
                .then((value) async {
              oldRates = value.data()['rates'];
              print("oldRates is: $oldRates ============================");
              await _firestore
                  .collection("institution")
                  .doc(request["insID"])
                  .update({'rates': oldRates += '${response.rating},'});
              // store comment ?
              /*   await _firestore
                  .collection("institution")
                  .doc(request["insID"])
                  .collection("appointment")
                  .where("requestID", isEqualTo: request["reqID"])
                  .get()
                  .then((snapshots) => snapshots.docs.forEach((element) async {
                        await _firestore
                            .collection("appointment")
                            .doc(element.id)
                            .update({'comment': response.comment});
                      }));*/
            });
            // END get the ins.
            // store the comment in the appointment

            //END  store the comment in the appointment

            if (response.rating < 3.0) {
              // send their comments to your email or anywhere you wish
              // ask the user to contact you instead of leaving a bad review
              print(
                  'LINE 424 home0.dart AND i= $itrationDetecter===========================================');
            } else {
              //  _rateAndReviewApp();
              print(
                  'LINE 428 home0.dart AND i= $itrationDetecter===========================================');
            }
          },
        );
        print(
            'LINE 433 home0.dart AND i= $itrationDetecter===========================================');
        // show the dialog
        showDialog(
          context: context,
          barrierDismissible:
              true, // set to false if you want to force a rating
          builder: (context) => _dialog,
        );
        print(
            'LINE 442 home0.dart AND i= $itrationDetecter===========================================');
      }
      print("itration NO. :$itrationDetecter");
      itrationDetecter++;
      print(
          'LINE 447 home0.dart AND i= $itrationDetecter===========================================');
    });
    print(
        'LINE 450 home0.dart AND i= $itrationDetecter===========================================');
  }
/*
      RoundedButton(
              text: "Rate", // change size + font
              icon: Icons.star_outline_rounded,
              press: () {
                Rating(context);
              },
            ),

            */

// END  RATING ==================================================================================================================

/*
void showTopSnackBar(BuildContext context ,String title,String message) => show(
        context,
        Flushbar(
          icon: Icon(Icons.error, size: 32, color: Colors.white),
          shouldIconPulse: false,
          title: title,
          message: message, // change message
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
          borderRadius: 16,
           barBlur: 20,
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
      );*/

/*
Future show(BuildContext context, Flushbar newFlushBar) async {
    await Future.wait(flushBars.map((flushBar) => flushBar.dismiss()).toList());
    flushBars.clear();

    newFlushBar.show(context);
    flushBars.add(newFlushBar);
  }*/

} // end class

///////////////////
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:swe444/Models/request.dart';

class ViewRequestViewModel {
/* for ID*/
  var firebaseUser = FirebaseAuth.instance.currentUser;

  /* to store docs*/
  List itemsList = [];

  final CollectionReference requestList = FirebaseFirestore.instance
      .collection('contributor')
      .doc('HjwkryLRi4loaSunp9Pv')
      .collection('request');

/* To retrive requests*/
  Future getRequestList() async {
    try {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await requestList
          //  .where("status", isEqualTo: "new")
          //  .orderBy("dateCreated")
          .get();
      print('I am here line 27 vi vi');

      querySnapshot.docs.forEach((element) {
        itemsList.add(element.data());
      });

      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


}
*/

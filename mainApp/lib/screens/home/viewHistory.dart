import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mostadeem/Admin/components/social_icon.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/screens/home/viViewHistoryModel.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mostadeem/components/rounded_button.dart';

import '../../constants.dart';

class viewHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewHistoryViewModel>(
        create: (_) => ViewHistoryViewModel(),
        child: Container(height: 1200, width: 450, child: ViewHistory()));
  }
}

class ViewHistory extends StatefulWidget {
  const ViewHistory({
    Key key,
  }) : super(key: key);

  @override
  _ViewHistoryState createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  final AuthService _auth = AuthService();
  final List<Flushbar> flushBars = [];
  WebViewController controller;

  final ViewHistoryViewModel ourViewMode = ViewHistoryViewModel();

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero,
        () => setState(() {
              setup();
            }));
  }

  setup() async {
    await Provider.of<ViewHistoryViewModel>(context, listen: false)
        .fetchRequests();
  }

// rating===============================================================================================================
  AuthService _authRating = AuthService();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> Rating() async {
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
      if (request['status'] == 'done') {
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
            .doc(request["instID"])
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
                .doc(request["instID"])
                .get()
                .then((value) async {
              oldRates = value.data()['rates'];
              print("oldRates is: $oldRates ============================");
              await _firestore
                  .collection("institution")
                  .doc(request["instID"])
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

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> institutions =
        Provider.of<ViewHistoryViewModel>(context, listen: false).requests;
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: StreamBuilder(
            stream: institutions,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Loading();

              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text(
                    "You don't have any completed requests",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                );
              } else
                return //Container( height: 50, width: 50,child:
                    new ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) => buildInstitutionCard(
                      context, snapshot.data.docs[index]), //),
                );
            })
        // ),
        );
  }

  Widget buildInstitutionCard(BuildContext context, DocumentSnapshot document) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 21,
        right: 21,
        top: 18,
      ),
      child: Container(
        width: 100, // 250
        height: 170, //160
        decoration: BoxDecoration(
          /*  border: Border.all(
                 color: Colors.green[900],
                ),*/
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Material(
          color: Colors.white,
          elevation: 14.0, //14
          borderRadius: BorderRadius.circular(24.0),
          shadowColor: Color(0x802196F3),
          child: Container(
            //    child: Padding(
            //     padding: const EdgeInsets.only(right: 15.0), // 90 //15
            child: myDetailsContainer1(context, document),
          ),
        ),
      ),

      //  ),
    );
  }

  Widget myDetailsContainer1(BuildContext context, DocumentSnapshot document) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /*FIRST ROW */
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 35, bottom: 9, top: 9),
              child: Text(
                document['title'],
                style: TextStyle(
                    color: Color.fromRGBO(48, 126, 80, 1),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        /*SECOND ROW*/
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /* First icon*/
            Padding(
              padding: const EdgeInsets.only(
                left: 35,
              ),
              child: Icon(
                Icons.calendar_today_sharp,
                size: 20,
                color: Color.fromRGBO(48, 126, 80, 1),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 4,
              ),
              child: Text(
                ourViewMode.convertDate(context, document),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                ),
              ),
            ),

            /*Sconed icon*/
            Padding(
              padding: const EdgeInsets.only(
                left: 9,
              ),
              child: Icon(
                Icons.access_time,
                size: 20,
                color: Color.fromRGBO(48, 126, 80, 1),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 3,
              ),
              child: Text(
                ourViewMode.convertTime(context, document),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 3,
              ),
              child: Text(
                ourViewMode.convertTime(context, document),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 2, //left: 5, //left:18,
              ),
              child: IconButton(
                icon: const Icon(Icons.location_on),
                color: Colors.blue,
                onPressed: () =>
                    ourViewMode.openLocation(document.get("location")),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 3),
              child: Icon(
                Icons.check,
                color: Color.fromRGBO(48, 126, 80, 1),
                size: 25,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 3,
                left: 3,
              ),
              child: Text(
                document['status'],
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  //  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 9,
              ),
              child: Icon(
                Icons.account_balance,
                size: 20,
                color: Color.fromRGBO(48, 126, 80, 1),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 3,
              ),
              child: Text(
                document['instName'],
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  //  fontWeight: FontWeight.bold
                ),
              ),
            ),
            /*third icon*/
            Padding(
              padding: const EdgeInsets.only(left: 9, top: 3, right: 2),
              child: Icon(
                Icons.category,
                size: 18,
                color: Color.fromRGBO(48, 126, 80, 1),
              ),
            ),
            Expanded(
              child: Text(
                document['category'],
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
        /*THIRD ROW*/
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (document['status'] == 'done')
              Container(
                margin: const EdgeInsets.only(right: 10, bottom: 10, top: 5),
                child: SizedBox(
                  height: 30,
                  width: 90,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    color: Color.fromRGBO(48, 126, 80, 1),
                    child: Wrap(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons
                                .star_outline_rounded, // replaced with 'icon' variable==========================================
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                        Text('Rate',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ],
                    ),

                    onPressed: () {
                      Rating();
                    }, //========================================================================================
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

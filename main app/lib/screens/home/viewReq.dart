import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mostadeem/Admin/components/social_icon.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/screens/home/viViewReqModel.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewRequestViewModel>(
        create: (_) => ViewRequestViewModel(),
        child: Container(height: 1200, width: 450, child: ViewRequests()));
  }
}

class ViewRequests extends StatefulWidget {
  const ViewRequests({
    Key key,
  }) : super(key: key);

  @override
  _ViewRequestsState createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests> {
  final AuthService _auth = AuthService();
  final List<Flushbar> flushBars = [];
  WebViewController controller;

  final ViewRequestViewModel ourViewMode = ViewRequestViewModel();

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
    await Provider.of<ViewRequestViewModel>(context, listen: false)
        .fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> institutions =
        Provider.of<ViewRequestViewModel>(context, listen: false).requests;
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: StreamBuilder(
            stream: institutions,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Loading();

              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text(
                    "You don't have any\n accepted requests",
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
                top: 2, //left: 5, //left:18,
              ),
              child: IconButton(
                icon: const Icon(Icons.location_on),
                color: const Color(0xFFF57C00),
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
              padding: const EdgeInsets.only(left: 35.0, top: 3),
              child: Icon(
                Icons.check,
                color: Color.fromRGBO(48, 126, 80, 1),
                size: 20,
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
      ],
    );
  }
} //

/*
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mostadeem/Admin/viViewModel.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/screens/home/home0.dart';
import 'package:mostadeem/screens/home/viViewReqModel.dart';
import 'package:mostadeem/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/components/google_auth_api.dart';

import 'home.dart';

class ViewRequest extends StatefulWidget {
  @override
  _viewRequestState createState() => _viewRequestState();
}

class _viewRequestState extends State<ViewRequest> {
  ViewRequestViewModel obj = new ViewRequestViewModel();

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext contexts) {
    // ignore: unnecessary_new
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Requests'),
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
          onPressed: () async {
            await _auth.signOut();
          },
        ),
        toolbarHeight: 60.0,
      ),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: userRequestList.length,
          itemBuilder: (context, index) {
            return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(
                      color: Color.fromRGBO(48, 126, 80, 1), width: 1),
                ),
                elevation: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (isPendding(index))
                      ListTile(
                        leading: Icon(
                          Icons.pending_actions_rounded,
                          color: Color.fromRGBO(48, 126, 80, 1),
                          size: 40,
                        ),
                        title: Text((userRequestList[index]['category'] ?? '')),
                        subtitle: Text(userRequestList[index]['date'] ?? ''),
                      ),
                    if (!isPendding(index))
                      ListTile(
                        leading: Icon(
                          Icons.check,
                          color: Color.fromRGBO(48, 126, 80, 1),
                          size: 40,
                        ),
                        title: Text((userRequestList[index]['category'] ?? '')),
                        subtitle: Text(userRequestList[index]['date'] ?? ''),
                      ),
                    /*    if (isPendding(index))
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.only(right: 20),
                            alignment: Alignment.center),
                        onPressed: () {
                          obj.cancelRequest(index);

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => ViewRequest()),
                              (Route<dynamic> route) => false);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),*/
                  ],
                )); 
          },
        ),
      ),
    );
  }

  List userRequestList = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic res = await ViewRequestViewModel().getRequestList();

    if (res == null) {
      print('Unable to retrive');
    } else
      setState(() {
        userRequestList = res;
      });
  }

  bool isPendding(int index) {
    if (userRequestList[index]['status'] == ('pending')) return true;

    return false;
  }
}
*/

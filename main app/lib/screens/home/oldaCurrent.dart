/**********OLD CODE **********/
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mostadeem/Admin/components/social_icon.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/screens/home/viViewCurrentModel.dart';
import 'package:mostadeem/screens/home/viViewCurrentModel.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewCurrent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewCurrentViewModel>(
        create: (_) => ViewCurrentViewModel(),
        child: Container(height: 1200, width: 450, child: _ViewCurrent()));
  }
}

class _ViewCurrent extends StatefulWidget {
  const _ViewCurrent({
    Key key,
  }) : super(key: key);

  @override
  _ViewHistoryState createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<_ViewCurrent> {
  final AuthService _auth = AuthService();
  final List<Flushbar> flushBars = [];
  WebViewController controller;

  final ViewCurrentViewModel ourViewMode = ViewCurrentViewModel();

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
    await Provider.of<ViewCurrentViewModel>(context, listen: false)
        .fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> rejectedR =
        Provider.of<ViewCurrentViewModel>(context, listen: false).requests;
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: StreamBuilder(
            stream: rejectedR,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Loading();

              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text(
                    "You don't have any current requests",
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
                iconSize: 26,
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
                Icons.pending_actions_rounded,
                color: Colors.orange,
                size: 23,
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
/*THIRD ROW
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (document['status'] == 'rejected')
              Container(
                margin: const EdgeInsets.only(right: 10, bottom: 10, top: 5),
                child: SizedBox(
                  height: 30,
                  width: 90,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    color: Colors.red,
                    child: Text('Delete',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: () => ourViewMode.cancelRequest(document.id),
                  ),
                ),
              ),
          ],
        ),*/
      ],
    );
  }
}

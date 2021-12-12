/**********OLD CODE **********/
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mostadeem/Admin/components/social_icon.dart';
import 'package:mostadeem/components/advancedAlertNew.dart';
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
              setup1();
              setup2();
            }));
  }

  setup1() async {
    int countPassed = await ourViewMode.checkPassedRequests();
    if (countPassed != 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlertNew(
                icon: Icons.history,
                msgContent:
                    'There are $countPassed pending requests that have passed the date',
                btnContent: 'Ok');
          });
    }
  }

  setup2() async {
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
                    "You don't have any\n current requests",
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
//THIRD ROW
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (document['status'] == 'pending')
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
                    child: Text('Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return cancelReqCustomAlert(
                              icon: Icons.delete_outline,
                              msgContent:
                                  'Are you sure you want to cancel this request ?',
                              btn1Content: 'Undo',
                              btn2Content: 'Cancel',
                              document: document,
                            );
                          });
                    },
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

//=====delete confirmation msg===========================================
class cancelReqCustomAlert extends StatelessWidget {
  final ViewCurrentViewModel ourViewMode = ViewCurrentViewModel();
  IconData icon;
  String msgContent;
  String btn1Content;
  String btn2Content;
  DocumentSnapshot<Object> document;

  cancelReqCustomAlert({
    @required this.icon,
    @required this.msgContent,
    @required this.btn1Content,
    @required this.btn2Content,
    @required this.document,
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 120.0,
                            height: 40.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.grey),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        width: 0, color: Colors.transparent),
                                  ))),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                btn1Content,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 120.0,
                            height: 40.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        width: 0, color: Colors.transparent),
                                  ))),
                              onPressed: () async {
                                try {
                                  //    await ourViewMode.cancelRequest2(document.id);
                                  await ourViewMode.moveToHistory(document
                                      .id); //==============================
                                  Navigator.of(context).pop();
                                  showTopSnackBar(context);
                                } catch (e) {
                                  print("HEEEEEEEEREEEEEEEEEE \n$e");
                                }
                              },
                              child: Text(
                                btn2Content,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ),
                        ])
                  ],
                ),
              ),
            ),
            Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
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

final List<Flushbar> flushBars = [];

void showTopSnackBar(BuildContext context) => show(
      context,
      Flushbar(
        icon: Icon(Icons.check_outlined, size: 32, color: Colors.white),
        shouldIconPulse: false,
        title: 'Canceled',
        message:
            'You have been cancel the request successfully', // change message
        duration: Duration(seconds: 4),
        //  borderRadius: BorderRadius.circular(6),
        flushbarPosition: FlushbarPosition.TOP,
        barBlur: 20,
        backgroundColor: Colors.black.withOpacity(0.5),
      ),
    );

Future show(BuildContext context, Flushbar newFlushBar) async {
  await Future.wait(flushBars.map((flushBar) => flushBar.dismiss()).toList());
  flushBars.clear();

  newFlushBar.show(context);
  flushBars.add(newFlushBar);
}

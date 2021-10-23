import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mostadeem/Admin/viViewModel.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/screens/home/home.dart';
import 'package:mostadeem/screens/home/viViewReqModel.dart';
import 'package:mostadeem/screens/request.dart';
import 'package:mostadeem/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/components/google_auth_api.dart';

class initiateRequest extends StatefulWidget {
  @override
  _initiateRequestState createState() => _initiateRequestState();
}

class _initiateRequestState extends State<initiateRequest> {
  @override
  Widget build(BuildContext contexts) {
    // ignore: unnecessary_new
    return new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Initiate Request'),
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
        ),
        toolbarHeight: 60.0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 190, left: 15, right: 15),
        child: Column(mainAxisSize: MainAxisSize.max,
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Recycle today for a better tomorrow',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Color.fromRGBO(48, 126, 80, 1),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              /*  Icon(
                Icons.favorite_border_rounded,
                color: Color.fromRGBO(48, 126, 80, 1),
              ),*/
              Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                    height: 50,
                    width: 190,
                    child: RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      color: Color.fromRGBO(48, 126, 80, 1),
                      child: Text(
                        'Start recycling',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => requestScreen()),
                          (Route<dynamic> route) => false,
                        );
                        /*
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => requestScreen()),
                        );*/
                      },
                    ),
                  )),
            ]),
      ),
    );
  }
}

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

class ViewRequest extends StatefulWidget {
  @override
  _viewRequestState createState() => _viewRequestState();
}

class _viewRequestState extends State<ViewRequest> {
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
            // GoogleAuthApi.signOut();
          },
        ),
        toolbarHeight: 60.0,
      ),
      /*  body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              child: FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14,
                    borderRadius: BorderRadius.circular(24),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: requestDetailsContainer(context, document),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),*/
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
                        title: Text('Request'),
                        subtitle: Text(userRequestList[index]['date'] ?? ''),
                      ),
                    if (!isPendding(index))
                      ListTile(
                        leading: Icon(
                          Icons.check,
                          color: Color.fromRGBO(48, 126, 80, 1),
                          size: 40,
                        ),
                        title: Text('Request'),
                        subtitle: Text(userRequestList[index]['date'] ?? ''),
                      ),
                    if (isPendding(index))
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.only(right: 20),
                            alignment: Alignment.center),
                        onPressed: () {},
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
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
    if (userRequestList[index]['status'] == ('pendding'))
      return true;
    else
      return false;
  }
}

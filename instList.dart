import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/services/auth.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class instList extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Instituations list'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
        ),
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),
        elevation: 0.0,
        toolbarHeight: 60.0,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("institution")
              .where("status", isEqualTo: "approved")
              .orderBy("dateCreated")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return Text('SOMETHINGWRONG!');
            return myWidget(context, snapshot);
          }),
    );
  }

  Widget myWidget(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: snapshot.data.docs.length,
      itemBuilder: (context, index) {
        return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Color.fromRGBO(48, 126, 80, 1), width: 1),
            ),
            elevation: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.account_balance_rounded,
                    color: Color.fromRGBO(48, 126, 80, 1),
                    size: 35,
                  ),
                  title: Text(snapshot.data.docs[index]['name'] ?? ''),
                  subtitle: Text(snapshot.data.docs[index]['category'] ?? ''),
                ),
              ],
            ));
      },
    );
  }
}

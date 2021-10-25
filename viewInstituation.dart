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

class ViewIns extends StatefulWidget {
  @override
  _viewInsState createState() => _viewInsState();
}

class _viewInsState extends State<ViewIns> {
  @override
  Widget build(BuildContext contexts) {
    // ignore: unnecessary_new
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
        ),
        toolbarHeight: 60.0,
      ),
      body: Column(children: <Widget>[
        Text('Our instituations'),
        Container(
          height: 300,
          //   color: Colors.white,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("institution")
                  .where("status", isEqualTo: "approved")
                  .orderBy("dateCreated")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Text('SOMETHINGWRONG!');
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) =>
                      buildCard(context, snapshot.data.docs[index]),
                );
              }),
        ),
      ]),
    );
  }

  Widget buildCard(BuildContext context, DocumentSnapshot document) => Card(
      color: Colors.white,
      elevation: 14.0, //14
      shadowColor: Color(0x802196F3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(
        top: 80,
        left: 20,
      ),
      child: Container(
        width: 150,
        height: 520,
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: Text(
              document['name'],
              style: TextStyle(
                color: Color.fromRGBO(48, 126, 80, 1),
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            // padding: EdgeInsets.only(top: 50, left: 13, right: 10),
            margin: EdgeInsets.only(top: 12, left: 5, right: 10),
            child: Text(document['category'],
                style: TextStyle(
                  color: Color.fromRGBO(48, 126, 80, 1),
                  fontSize: 10.0,
                )),
          ),
          Container(
            padding: EdgeInsets.only(top: 30, left: 13, right: 10),
            child: Row(
              children: [
                /* margin: EdgeInsets.only(
                  left: 15,
                ),*/
                Container(
                  padding: EdgeInsets.only(
                    left: 5,
                  ),
                  child: SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    color: Color.fromRGBO(48, 126, 80, 1),
                    press: () => _goToTwitter(document.get("twitter")),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 6,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.phone),
                    color: Color.fromRGBO(48, 126, 80, 1),
                    onPressed: () => _goToWhatsapp(document.get("phone")),
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: const Icon(Icons.mail_outline),
                    color: Color.fromRGBO(48, 126, 80, 1),
                    tooltip: 'Send email',
                    onPressed: () => _sendingMails(document.get("email")),
                  ),
                ),
              ],
            ),
          ),
          TextButton(onPressed: () {}, child: Text('View more...')),
        ]),
      ));

  Future _sendingMails(String email) async {
    String url = 'mailto:$email'; // specify mail from snapchot
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future _goToTwitter(String account) async {
    String url = 'https://twitter.com/$account';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: true,
        enableJavaScript: true,
        enableDomStorage: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future _goToWhatsapp(String phone) async {
    String newPhone = phone.substring(1);
    String url =
        "whatsapp://send?phone=+966$newPhone"; // maybe needs to be modified to api?
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

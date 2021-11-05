import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/screens/instList.dart';
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

class HomeZero extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
        ),
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),
        elevation: 0.0,
        /* actions: <Widget>[
            IconButton(
              padding: EdgeInsets.only(right: 15),
              icon: Icon(Icons.logout , size: 25.0,
            color: Colors.white,),
            
              onPressed: () async {
                await _auth.signOut();
                GoogleAuthApi.signOut();
              },
            ),
          ],
          */
        toolbarHeight: 60.0,
      ),
      body: Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Instituations',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(48, 126, 80, 1),
                  fontWeight: FontWeight.bold,
                )),
            TextButton(
              style: TextButton.styleFrom(
                  //    padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.bottomLeft),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => instList()),
                );
              },
              child: Text(
                'See all',
                style: TextStyle(
                    color: Colors.grey, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
        Container(
          height: 180,
          //   color: Colors.white,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("institution")
                  .where("status", isEqualTo: "approved")
                  .orderBy("dateCreated")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Text('SOMETHINGWRONG!');
                return myWidget(context, snapshot);
              }),
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30, left: 50, bottom: 30),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color.fromRGBO(48, 126, 80, 1),
                  width: 2,
                ),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.card_giftcard_rounded,
                  size: 33,
                  color: Color.fromRGBO(48, 126, 80, 1),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 25, bottom: 30),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(48, 126, 80, 1),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.store,
                  size: 33,
                  color: Color.fromRGBO(48, 126, 80, 1),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 25, bottom: 30),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                //  color: Color.fromRGBO(48, 126, 80, 1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color.fromRGBO(48, 126, 80, 1),
                  width: 2,
                ),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.help,
                  size: 33,
                  color: Color.fromRGBO(48, 126, 80, 1),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.only(top: 10, left: 10),
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            gradient: LinearGradient(colors: [
              Color.fromRGBO(48, 126, 80, 1),
              Color.fromRGBO(236, 232, 202, 1)
            ]),
            color: Color.fromRGBO(48, 126, 80, 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text.rich(TextSpan(
            text: "Tips",
            style: TextStyle(color: Colors.white),
          )),
        ),
      ]),
    );
  }

  Widget myWidget(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return Scrollbar(
        isAlwaysShown: true,
        scrollbarOrientation: ScrollbarOrientation.top,
        interactive: true,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) =>
              buildCard(context, snapshot.data.docs[index]),
        ));
  }

  Widget buildCard(BuildContext context, DocumentSnapshot document) => Card(
      color: Colors.white70,
      //  elevation: 14.0, //14
      // shadowColor: Color(0x802196F3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(
        //    bottom: 80,
        left: 20,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(236, 232, 202, 0.3),
          borderRadius: BorderRadius.circular(25),
        ),
        width: 150,
        height: 320,
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: Text(
              document['name'],
              style: TextStyle(
                color: Color.fromRGBO(48, 126, 80, 1),
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            // padding: EdgeInsets.only(top: 50, left: 13, right: 10),
            margin: EdgeInsets.only(top: 20, left: 5, right: 10),
            child: Text(document['category'],
                style: TextStyle(
                  color: Color.fromRGBO(48, 126, 80, 1),
                  fontSize: 15.0,
                )),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 13, right: 10),
            child: Row(
              children: [
                /* margin: EdgeInsets.only(
                  left: 15,
                ),*/
                Container(
                  child: IconButton(
                    icon: const Icon(Icons.mail_outline),
                    color: Color.fromRGBO(48, 126, 80, 1),
                    tooltip: 'Send email',
                    onPressed: () => _sendingMails(document.get("email")),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 5,
                  ),
                  child: SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    color: Color.fromRGBO(48, 126, 80, 1),
                    press: () => _goToTwitter(document.get("twitterAccount")),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 4,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.phone),
                    color: Color.fromRGBO(48, 126, 80, 1),
                    onPressed: () => _goToWhatsapp(document.get("phone")),
                  ),
                ),
              ],
            ),
          ),
          /*   TextButton(
              onPressed: () {},
              child: Text(
                'View more...',
                style: TextStyle(
                  color: Color.fromRGBO(48, 126, 80, 1),
                  decoration: TextDecoration.underline,
                ),
              )),*/
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

//import 'dart:convert';

//import 'dart:html';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/models/emailMessage.dart';
//import 'package:flutter_svg/svg.dart'; /*?*/
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';/*?*/
//import 'package:mostadeem/Screens/background.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/services/database.dart';
import 'package:mostadeem/shared/loading.dart';
//import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'components/social_icon.dart';

class ViewInstitution extends StatefulWidget {
  @override
  _ViewInstitutionState createState() => _ViewInstitutionState();
}

class _ViewInstitutionState extends State<ViewInstitution> {
  final AuthService _auth = AuthService();
  final List<Flushbar> flushBars = [];

  WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
        ),
        /*  title: Text(
          "MOSTADEEM",
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),*/
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 15),
            icon: Icon(
              Icons.logout,
              size: 25.0,
              color: Colors.white,
            ),
            onPressed: () async {
              await _auth.signOut();
              GoogleAuthApi.signOut();
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.green[50],
            size: 30.0,
          ),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
        /*   actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person , size: 30.0,
            color: Colors.white,),
              
              label: Text(
          "Logout",
          style: TextStyle(color: Colors.white,
          ),
        ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],*/
        toolbarHeight: 80.0,
      ),
      body: Container(
        // ???????? ??????????

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),

        margin: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10), // shouldn't the bellow line be aysnc?
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("institution")
                .where("status", isEqualTo: "pending")
                .orderBy("dateCreated")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Loading();
              return //Container( height: 50, width: 50,child:
                  new ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) => buildInstitutionCard(
                    context, snapshot.data.docs[index]), //),
              );
            }),
      ),
    );
  }

  Widget buildInstitutionCard(BuildContext context, DocumentSnapshot document) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 250,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green[900],
          ),
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          shadowColor: Color(0x802196F3),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 90.0),
              child: myDetailsContainer1(context, document),
            ),
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(BuildContext context, DocumentSnapshot document) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: 13,
            left: 18,
          ),
          child: Text(
            document['name'],
            style: TextStyle(
                color: Colors.green[900],
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            margin: const EdgeInsets.all(5),
            child: ElevatedButton.icon(
              onPressed: () => _checkCR(document.get("CR"), context),
              label: Text(
                document['CR'],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              icon: Icon(Icons.confirmation_num_sharp), // or assignment
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(48, 126, 80, 1) // can be changed
                  ),
            )),
        lastRow(context, document),
      ],
    );
  }

  Widget lastRow(BuildContext context, DocumentSnapshot document) {
    return Row(
      children: <Widget>[
        contactIcons(context, document),
        SizedBox(width: 6),
        institutionStatus(context, document),
      ],
    ); //,),);
  }

  Widget contactIcons(BuildContext context, DocumentSnapshot document) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            child: IconButton(
              icon: const Icon(Icons.mail_outline),
              color: Colors.lightGreen[900],
              tooltip: 'Send email',
              onPressed: () => _sendingMails(document.get("email")),
            ),
          ),
          SizedBox(width: 5),
          Flexible(
            child: SocalIcon(
              iconSrc: "assets/icons/twitter.svg",
              color: Colors.lightGreen[900],
              press: () => _goToTwitter(document.get("twitter")),
            ),
          ),
          SizedBox(width: 6),
          Flexible(
            child: IconButton(
              icon: const Icon(Icons.phone),
              color: Colors.lightGreen[900],
              onPressed: () => _goToWhatsapp(document.get("phone")),
            ),
          ),
        ],
      ), //),
    );
  }

  Widget institutionStatus(BuildContext context, DocumentSnapshot document) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        //direction: Axis.vertical,
        //alignment: WrapAlignment.end,

        children: <Widget>[
          //  Flexible(  child:
          /* Container( width:25 , 
                child:*/
          GestureDetector(
            onTap: () {
              _showMyDialog("approve", context, document.id, document);
            },
            child: Icon(
              Icons.check,
              size: 50.0,
              color: Colors.lightGreen[600],
            ),
          ),

          GestureDetector(
            onTap: () {
              _showMyDialog("Disapprove", context, document.id, document);
            },
            child: Icon(
              Icons.clear,
              size: 50.0,
              color: Colors.red[800],
            ),
          ),

/*              IconButton(
               // padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
               iconSize: 50.0,
               icon: const Icon(Icons.check),
               color: Colors.lightGreen[600],
               onPressed: (){_showMyDialog("approve", context,document.id); },),*/ // pop up , are you sure?
//),//),
//SizedBox(width: 30),
          // Flexible(  child:
          /* Padding( padding: EdgeInsets.only(left:15),
                child:*/
          /*
              IconButton(
               // padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              iconSize: 50.0,
              icon: const Icon(Icons.clear),
              color: Colors.red[800],
              onPressed: (){ _showMyDialog("disapprove", context,document.id);},), */ // pop up , are you sure?
//),//),
        ],
      ),
    );
  }

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

  Future<void> _showMyDialog(String status, BuildContext context, String uid,
      DocumentSnapshot document) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Institution Status'),
          content: Text('Do you want to $status this intitution?'),
          actions: <Widget>[
            TextButton(
              // nothing should happen
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (status == "approve") {
                  // change status to approved, then admin would not be able to see them
                  String result = _auth.updateInstitutionStatus(status, uid);
                  if (result == 'Success approve') {
                    // show another pop up
                    print('status has changed to approved');
                    sendEmail("approveEmail", context, document);
                    showTopSnackBar(
                        context, 'Success', 'Institution has been approved');
                  } else if (result == 'Fail approve') {
                    print('could not update status, procces failed');
                    showTopSnackBar(
                        context, 'Fail', 'Approve institution failed');
                  } else {
                    print(result);
                  }
                } else {
                  // delete institution and send email to them to let them know
                  String result = _auth.updateInstitutionStatus(status, uid);
                  if (result == 'Success disapprove') {
                    // show another pop up
                    print('intitution has been deleted'); // may change it
                    sendEmail("disapproveEmail", context, document);
                    showTopSnackBar(
                        context, 'Success', 'Institution has been disapproved');
                  } else if (result == 'Fail disapprove') {
                    print('could not delete institution, procces failed');
                    showTopSnackBar(
                        context, 'Fail', 'Dispprove institution failed');
                  } else {
                    print(result);
                  }
                }

                Navigator.pop(context, 'OK');
              },
              child: const Text('Yes'),
            ),
          ],
          //),
        );
      },
    );
  }

  sendEmail(String uid, BuildContext context, DocumentSnapshot document) async {
    FirebaseFirestore.instance
        .collection('sendEmail')
        .doc(uid)
        .get()
        .then((DocumentSnapshot emailMess) async {
      final user = await GoogleAuthApi.signIn();
      print('inside sendEmail method');
      if (user == null) return;
      print('inside sendEmail method after user check');
      final email = user.email;
      final auth = await user.authentication;
      final token = auth.accessToken;
//GoogleAuthApi.signOut();

      print('Authenticated: $email');
      final smtpServer = gmailSaslXoauth2(email, token);
      final message = Message()
        ..from = Address(email, 'Mostadeem team')
        ..recipients = [document.get("email")]
        ..subject = emailMess['subject']
        ..text = '\n' +
            emailMess['text'] +
            '\n\n' +
            emailMess['details'] +
            '\n\n\n' +
            emailMess['moreInfo'];

      try {
        await send(message, smtpServer);
      } on MailerException catch (e) {
        print(e);
      }
    });
  }

  _checkCR(String CR, BuildContext context) {
    // String url='https://mc.gov.sa/ar/eservices/Pages/Commercial-data.aspx';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              'https://mc.gov.sa/ar/eservices/Pages/Commercial-data.aspx',
          onWebViewCreated: (WebViewController webController) {
            this.controller = webController;
          },
          onProgress: (url) {
            controller.evaluateJavascript(
                "document.getElementByTagName('header')[0].style.display='none'");
            controller.evaluateJavascript(
                "document.getElementByTagName('footer')[0].style.display='none'");
            controller.evaluateJavascript(
                "document.getElementById('ctl00_ctl74_g_3aefad74_14c7_474a_ac96_010ad3a5e1c1_ctl00_txtCRName').value='$CR'");
          },
        ),
      ),
    );
  }

  void showTopSnackBar(BuildContext context, String title, String message) =>
      show(
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
      );

  Future show(BuildContext context, Flushbar newFlushBar) async {
    await Future.wait(flushBars.map((flushBar) => flushBar.dismiss()).toList());
    flushBars.clear();

    newFlushBar.show(context);
    flushBars.add(newFlushBar);
  }
} // end of class

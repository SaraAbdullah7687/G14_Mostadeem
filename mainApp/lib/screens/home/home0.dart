import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mostadeem/institution/instViewProfile.dart';
import 'package:mostadeem/models/Institution.dart';
import 'package:mostadeem/screens/home/points.dart';
import 'package:mostadeem/screens/home/regulations.dart';
import 'package:mostadeem/screens/home/stores.dart';
import 'package:mostadeem/screens/request.dart';
import 'package:mostadeem/screens/viViewCategories.dart';
import '../../screens/searchName.dart';
import 'package:mostadeem/screens/searchName.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mostadeem/shared/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mostadeem/globals/global.dart' as globals;

import '../viewCategories.dart';

class HomeZero extends StatelessWidget {
  calculates(DocumentSnapshot document) {
    final institution1 = Institution.fromSnapshot(document);
    double ratesAverage = 0;
    List<String> rates = null;
    rates = institution1.rates.split(",");
    int ratesL = rates.length - 2;
    print("The length of my array is $ratesL");
    for (var i = 0; i < ratesL + 1; i++) {
      ratesAverage = ratesAverage + double.parse(rates[i]);
    }
    if (ratesL != 0) {
      ratesAverage = ratesAverage / (ratesL);
    }

    print("the average is: $ratesAverage");
    FirebaseFirestore.instance
        .collection("institution")
        .doc(document.id)
        .update({
      'ratesAvg': ratesAverage.toString(),
    });
    FirebaseFirestore.instance
        .collection("institution")
        .doc(document.id)
        .update({
      'ratesNo': ratesL,
    });
    print("${institution1.name}");
    print("${institution1.ratesNo.toString()}");
  }

  final AuthService _auth = AuthService();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    getPoints();

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
            Container(
              margin: EdgeInsets.only(left: 90),
              child: Text('Instituations',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(48, 126, 80, 1),
                    fontWeight: FontWeight.bold,
                  )),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  //    padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.bottomLeft),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchInstList()), //instList()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 40),
                child: Text(
                  'View all',
                  style: TextStyle(
                      color: Colors.grey, decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 230, bottom: 9),
              child: Text('Top rated',
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color(0xFFF57C00),
                    fontWeight: FontWeight.bold,
                  )),
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
                  .orderBy('ratesAvg', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Loading();
                return myWidget(context, snapshot);
              }),
        ),
        Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.only(bottom: 40),
                child: Row(
                  children: <Widget>[
                    /// first cat 1
                    Container(
                        margin: EdgeInsets.only(top: 30, left: 20, bottom: 30),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(48, 126, 80, 1),
                            width: 2,
                          ),
                        ),
                        child: Image.asset("assets/images/Food.png")),

                    ///second cat 2
                    Container(
                        margin: EdgeInsets.only(top: 30, left: 12, bottom: 30),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(48, 126, 80, 1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset("assets/images/Glass.png")),
                    //fourth ct 4
                    Container(
                        margin: EdgeInsets.only(top: 30, left: 12, bottom: 30),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          //  color: Color.fromRGBO(48, 126, 80, 1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(48, 126, 80, 1),
                            width: 2,
                          ),
                        ),
                        child: Image.asset("assets/images/Paper.png")),

                    ///5
                    Container(
                        margin: EdgeInsets.only(top: 30, left: 12, bottom: 30),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          //  color: Color.fromRGBO(48, 126, 80, 1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(48, 126, 80, 1),
                            width: 2,
                          ),
                        ),
                        child: Image.asset("assets/images/Batteries.png")),

                    ///6
                    Container(
                        margin: EdgeInsets.only(top: 30, left: 12, bottom: 30),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          //  color: Color.fromRGBO(48, 126, 80, 1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(48, 126, 80, 1),
                            width: 2,
                          ),
                        ),
                        child: Image.asset("assets/images/Electronics.png")),

                    ///7
                    Container(
                        margin: EdgeInsets.only(top: 30, left: 12, bottom: 30),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          //  color: Color.fromRGBO(48, 126, 80, 1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(48, 126, 80, 1),
                            width: 2,
                          ),
                        ),
                        child: Image.asset("assets/images/Nylon.png")),

                    ///8
                    Container(
                        margin: EdgeInsets.only(top: 30, left: 12, bottom: 30),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          //  color: Color.fromRGBO(48, 126, 80, 1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(48, 126, 80, 1),
                            width: 2,
                          ),
                        ),
                        child: Image.asset("assets/images/Metals.png")),
                    //10
                    Container(
                        margin: EdgeInsets.only(top: 30, left: 12, bottom: 30),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          //  color: Color.fromRGBO(48, 126, 80, 1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(48, 126, 80, 1),
                            width: 2,
                          ),
                        ),
                        child: Image.asset("assets/images/Cans.png")),
                    //11
                    Container(
                        margin: EdgeInsets.only(top: 30, left: 12, bottom: 30),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          //  color: Color.fromRGBO(48, 126, 80, 1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(48, 126, 80, 1),
                            width: 2,
                          ),
                        ),
                        child: Image.asset("assets/images/Cardboard.png")),
                    //12
                    Container(
                        margin: EdgeInsets.only(top: 30, left: 12, bottom: 30),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          //  color: Color.fromRGBO(48, 126, 80, 1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(48, 126, 80, 1),
                            width: 2,
                          ),
                        ),
                        child: Image.asset("assets/images/Clothes.png")),
                    //13
                    Container(
                        margin: EdgeInsets.only(
                            top: 30, left: 12, right: 20, bottom: 30),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          //  color: Color.fromRGBO(48, 126, 80, 1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(48, 126, 80, 1),
                            width: 2,
                          ),
                        ),
                        child: Image.asset("assets/images/Furniture.png")),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => viViewCategory()),
                );
              },
            ),
          ),
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
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data.docs.length,
      itemBuilder: (context, index) =>
          buildCard(context, snapshot.data.docs[index]),
    );
  }

  Widget buildCard(BuildContext context, DocumentSnapshot document) {
    calculates(document);
    return Card(
      color: Colors.white70,
      //  elevation: 14.0, //14
      // shadowColor: Color(0x802196F3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(
        right: 10,
        left: 14,
      ),
      child: InkWell(
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
            /*   Container(
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
          ),*/
            /*   TextButton(
              onPressed: () {},
              child: Text(
                'View more...',
                style: TextStyle(
                  color: Color.fromRGBO(48, 126, 80, 1),
                  decoration: TextDecoration.underline,
                ),
              )),*/
            /* display rating*/

            Container(
              padding: EdgeInsets.only(top: 20, left: 13, right: 10),
              child: Row(children: [
                /* margin: EdgeInsets.only(
                  left: 15,
                ),*/
                RatingBarIndicator(
                  rating: double.parse(document['ratesAvg']),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
                Text(
                  '(' + document['ratesNo'].toString() + ')',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ]),
            )
          ]),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InstViewProfile(
                UID: document.id,
              ),
            ),
          );
        },
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
}

final firestoreInstance = FirebaseFirestore.instance;

String getPoints() {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  firestoreInstance
      .collection('contributor')
      .doc(firebaseUser.uid)
      .get()
      .then((value) {
    int points = (value.data()['points']);
    globals.userPoints = points;
  });
  return globals.userPoints.toString();
}

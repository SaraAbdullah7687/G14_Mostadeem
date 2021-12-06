import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mostadeem/globals/global.dart';
import 'package:mostadeem/institution/instViewProfile.dart';
import 'package:mostadeem/models/Institution.dart';
import 'package:mostadeem/models/informationModel.dart';
import 'package:mostadeem/screens/home/points.dart';
import '../../screens/searchName.dart';
import 'package:mostadeem/screens/searchName.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mostadeem/shared/loading.dart';
import 'package:mostadeem/globals/global.dart' as globals;
import 'package:animated_text_kit/animated_text_kit.dart';
import '../viInformation.dart';
import '../viewCategories.dart';

class HomeZero extends StatelessWidget {
/*information*/
  List _allResults = [];
  List<String> infoList = ["love,Peace, live"];

  getInfo() async {
    var data = await FirebaseFirestore.instance
        .collection("admin")
        .doc("LvBjmrwtSFeGmAI0YvADjI59xmi1")
        .collection("information")
        .get();
    _allResults = data.docs;
    for (var infoSnapshot in _allResults) {
      var info = Information.fromSnapshot(infoSnapshot).description;
      print("The informations is " + info);
      infoList.add(infoSnapshot);
      print("The lentgh of information is ${_allResults.length}");
    }
  }

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
    getInfo();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => points(),
                  ),
                );
              },
              icon: Icon(Icons.card_giftcard),
              color: Colors.white,
            )
          ],
          centerTitle: true,
          title: Text('Home'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(18),
            ),
          ),
          backgroundColor: Color.fromRGBO(48, 126, 80, 1),
          elevation: 0.0,
          toolbarHeight: 60.0,
        ),
        body: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5, bottom: 9, top: 15, left: 70),
                child: Text('Top rated instituations',
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color(0xFFF57C00),
                      fontWeight: FontWeight.bold,
                    )),
              ),
              TextButton(
                style: TextButton.styleFrom(alignment: Alignment.bottomLeft),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchInstList()), //instList()),
                  );
                },
                child: Container(
                  //    margin: EdgeInsets.only(left: 10),
                  child: Text(
                    'View all',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
          Scrollbar(
              isAlwaysShown: true,
              controller: _scrollController,
              child: Container(
                margin: EdgeInsets.only(bottom: 60),
                padding: EdgeInsets.only(bottom: 10),
                height: 170,
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
              )),

          /**********CATOGIRES*******/
          Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.only(bottom: 40),
                child: Row(
                  children: <Widget>[
                    /// first cat 1
                    Container(
                      margin: EdgeInsets.only(left: 20, bottom: 30),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFFF57C00),
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        child: Image.asset("assets/images/Food.png"),
                        onTap: () {
                          cat = "food";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCatList()),
                          );
                        },
                      ),
                    ),

                    ///second cat 2
                    Container(
                      margin: EdgeInsets.only(left: 12, bottom: 30),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFF57C00),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        child: Image.asset("assets/images/Glass.png"),
                        onTap: () {
                          cat = "glass";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCatList()),
                          );
                        },
                      ),
                    ),
                    //fourth ct 4
                    Container(
                      margin: EdgeInsets.only(left: 12, bottom: 30),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        //  color: Color.fromRGBO(48, 126, 80, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFFF57C00),
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        child: Image.asset("assets/images/Paper.png"),
                        onTap: () {
                          cat = "paper";

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCatList()),
                          );
                        },
                      ),
                    ),

                    ///5
                    Container(
                      margin: EdgeInsets.only(left: 12, bottom: 30),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        //  color: Color.fromRGBO(48, 126, 80, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFFF57C00),
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        child: Image.asset("assets/images/Batteries.png"),
                        onTap: () {
                          cat = "batteries";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCatList()),
                          );
                        },
                      ),
                    ),

                    ///6
                    Container(
                      margin: EdgeInsets.only(left: 12, bottom: 30),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        //  color: Color.fromRGBO(48, 126, 80, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFFF57C00),
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        child: Image.asset("assets/images/Electronics.png"),
                        onTap: () {
                          cat = "electronics";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCatList()),
                          );
                        },
                      ),
                    ),

                    ///7
                    Container(
                      margin: EdgeInsets.only(left: 12, bottom: 30),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        //  color: Color.fromRGBO(48, 126, 80, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFFF57C00),
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        child: Image.asset("assets/images/Nylon.png"),
                        onTap: () {
                          cat = "nylon";

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCatList()),
                          );
                        },
                      ),
                    ),

                    ///8
                    Container(
                      margin: EdgeInsets.only(left: 12, bottom: 30),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        //  color: Color.fromRGBO(48, 126, 80, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFFF57C00),
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        child: Image.asset("assets/images/Metals.png"),
                        onTap: () {
                          cat = "metals";

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCatList()),
                          );
                        },
                      ),
                    ),
                    //10
                    Container(
                      margin: EdgeInsets.only(left: 12, bottom: 30),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        //  color: Color.fromRGBO(48, 126, 80, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFFF57C00),
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        child: Image.asset("assets/images/Cans.png"),
                        onTap: () {
                          cat = "cans";

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCatList()),
                          );
                        },
                      ),
                    ),
                    //11
                    Container(
                      margin: EdgeInsets.only(left: 12, bottom: 30),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        //  color: Color.fromRGBO(48, 126, 80, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFFF57C00),
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        child: Image.asset("assets/images/Cardboard.png"),
                        onTap: () {
                          cat = "cardboard";

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCatList()),
                          );
                        },
                      ),
                    ),
                    //12
                    Container(
                      margin: EdgeInsets.only(left: 12, bottom: 30),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        //  color: Color.fromRGBO(48, 126, 80, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFFF57C00),
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        child: Image.asset("assets/images/Clothes.png"),
                        onTap: () {
                          cat = "clothes";

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCatList()),
                          );
                        },
                      ),
                    ),
                    //13
                    Container(
                      margin: EdgeInsets.only(left: 12, right: 20, bottom: 30),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        //  color: Color.fromRGBO(48, 126, 80, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFFF57C00),
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        child: Image.asset("assets/images/Plastic.png"),
                        onTap: () {
                          cat = "plastic";

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCatList()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /******TIPS************/
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.only(left: 10),
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
              child: Row(children: <Widget>[intiateWidget1()])
              /* AnimatedTextKit(
                pause: Duration(microseconds: 1000),
                animatedTexts: [
                  TyperAnimatedText(infoList[0]),
                  TyperAnimatedText(_allResults.length.toString())
                ]),*/
              ),
        ]));
  }

  Widget intiateWidget1() {
    for (var i = 0; i < infoList.length; i++) {
      return AnimatedTextKit(
        pause: Duration(microseconds: 100000),
        animatedTexts: [
          TyperAnimatedText(infoList[i]),
        ],
        isRepeatingAnimation: true,
      );
    }
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
            Container(
              padding: EdgeInsets.only(top: 20, left: 13, right: 10),
              child: Row(children: [
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

/*NOUF'S PART*/
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
}

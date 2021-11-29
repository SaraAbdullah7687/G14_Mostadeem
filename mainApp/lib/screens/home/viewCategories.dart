import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/models/Institution.dart';
import 'package:mostadeem/screens/inst_card.dart';
import 'package:mostadeem/screens/viViewInstModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class SearchCategory extends StatelessWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List cat = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // .where("category".contains("plastic"))
              .orderBy('ratesAvg', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            print(snapshot.data.docs.length);
            if (!snapshot.hasData) return Text("zg"); //Loading();
            return myWidget(context, snapshot);
          }),
    );
  }
}

Widget myWidget(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  return ListView.builder(
    // scrollDirection: Axis.horizontal,
    itemCount: snapshot.data.docs.length,
    itemBuilder: (context, index) =>
        buildInstCard(context, snapshot.data.docs[index]),
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:mostadeem/models/Institution.dart';

Widget buildInstCard(BuildContext context, DocumentSnapshot document) {
  final institution = Institution.fromSnapshot(document);
  double ratesAverage = 0;
  List<String> rates = null;
  rates = institution.rates.split(",");
  int ratesL = rates.length - 1;
  print("The length of my array is $ratesL");
  for (var i = 0; i < ratesL; i++) {
    ratesAverage = ratesAverage + double.parse(rates[i]);
  }
  ratesAverage = ratesAverage / (ratesL);
  print("the average is: $ratesAverage");
  FirebaseFirestore.instance.collection("institution").doc(document.id).update({
    'ratesAvg': ratesAverage,
  });
  return new Container(
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        //  side:
        //     BorderSide(color: Color.fromRGBO(48, 126, 80, 1), width: 1),
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
            title: Text(
              institution.name ?? '',
              style: TextStyle(
                fontSize: 18.0,
                color: Color.fromRGBO(48, 126, 80, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
            //
            subtitle: RatingBarIndicator(
              rating: ratesAverage,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
              direction: Axis.horizontal,
            ),
          ),
        ],
      ),
    ),
  );
}

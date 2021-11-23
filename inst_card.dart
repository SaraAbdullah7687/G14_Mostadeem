import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mostadeem/institution/instViewProfile.dart';
import 'package:mostadeem/models/Institution.dart';

import 'home/home0.dart';

Widget buildInstCard(BuildContext context, DocumentSnapshot document) {
  final HomeZero obj = new HomeZero();
  final institution = Institution.fromSnapshot(document);
  /*to send id to modhi*/
  /* void _goProfile(BuildContext context, String thisID) async {
    // AFNAN
    //Navigator.of(context).push(
    //  Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InstViewProfile(
          // Calendar
          UID: thisID,
        ),
      ),
    );
  }*/
  obj.calculates(document);
  return InkWell(
    child: new Container(
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
              subtitle: Row(
                children: [
                  RatingBarIndicator(
                    rating: double.parse(institution.ratesAvg),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  Text(
                    '(${institution.ratesNo.toString()})',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 95),
                    child: IconButton(
                        icon: const Icon(Icons.arrow_forward_rounded),
                        color: const Color(0xFFF57C00),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InstViewProfile(
                                UID: institution.id,
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InstViewProfile(
            UID: institution.id,
          ),
        ),
      );
    },
  );
}

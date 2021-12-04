import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/models/Institution.dart';
import 'package:mostadeem/screens/inst_card.dart';
import 'package:mostadeem/screens/viViewInstModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mostadeem/shared/loading.dart';
import 'package:provider/provider.dart';

class ViewInformation extends StatelessWidget {
  List information = [];
  final CollectionReference infoList = FirebaseFirestore.instance
      .collection("admin")
      .doc("LvBjmrwtSFeGmAI0YvADjI59xmi1")
      .collection("information");

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future getInfo() async {
    /*TRY*/
    try {
      await infoList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          information.add(element.data);
        });
      });
    }
    /*CATCH*/
    catch (e) {}
  }
}

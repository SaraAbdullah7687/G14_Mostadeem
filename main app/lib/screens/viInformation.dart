import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/globals/global.dart';
import 'package:mostadeem/models/Institution.dart';
import 'package:mostadeem/screens/inst_card.dart';
import 'package:mostadeem/screens/viViewInstModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class viewInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class ViewInfoList extends StatefulWidget {
  const ViewInfoList({
    Key key,
  }) : super(key: key);

  @override
  _ViewInfoList createState() => _ViewInfoList();
}

class _ViewInfoList extends State<ViewInfoList> {
  List _allResults = [];
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  /*TO GET INSTITUATIONS*/
  getInfo() async {
    var data = await FirebaseFirestore.instance
        .collection("admin")
        .doc("LvBjmrwtSFeGmAI0YvADjI59xmi1")
        .collection("information")
        .get();
    setState(() {
      _allResults = data.docs;
    });
    if (data.docs.length == 0) {
      return Center(
        child: Text(
          "There is no onformation",
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
      );
    }
    return "complet";
  }

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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _resultsList.length,
                itemBuilder: (BuildContext context, int index) {
                  AnimatedTextKit(
                      pause: Duration(microseconds: 10000000),
                      animatedTexts: [TyperAnimatedText(_resultsList[index])]);
                }),
          ),
        ],
      ),
    );
  }
}

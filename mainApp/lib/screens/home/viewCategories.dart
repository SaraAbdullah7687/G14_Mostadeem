import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/globals/global.dart';
import 'package:mostadeem/models/Institution.dart';
import 'package:mostadeem/screens/inst_card.dart';
import 'package:mostadeem/screens/viViewInstModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class viewCat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewInstViewModel>(
        create: (_) => ViewInstViewModel(),
        child: Container(height: 1200, width: 450, child: ViewCatList()));
  }
}

class ViewCatList extends StatefulWidget {
  const ViewCatList({
    Key key,
  }) : super(key: key);

  @override
  _ViewCatList createState() => _ViewCatList();
}

class _ViewCatList extends State<ViewCatList> {
  List _allResults = [];
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    getInsts();
  }

  searchResultsList() {
    var showResults = [];
    for (var instSnapshot in _allResults) {
      var categories =
          Institution.fromSnapshot(instSnapshot).categories.toLowerCase();
      print(categories);
      if (categories.contains(cat)) {
        showResults.add(instSnapshot);
      }
    }

    setState(() {
      _resultsList = showResults;
    });
  }

  /*TO GET INSTITUATIONS*/
  getInsts() async {
    var data = await FirebaseFirestore.instance
        .collection("institution")
        .where("status", isEqualTo: "approved")
        .orderBy('ratesAvg', descending: true)
        .get();
    setState(() {
      _allResults = data.docs;
    });
    if (data.docs.length == 0) {
      return Center(
        child: Text(
          "There is no istituations",
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
      );
    }
    searchResultsList();
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
          if (_resultsList.isEmpty)
            Container(
                margin: EdgeInsets.only(top: 200, left: 20, right: 20),
                child: Text(
                  "Sorry there is no instituation with ${cat} categoty",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                )),
          Expanded(
            child: ListView.builder(
              itemCount: _resultsList.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildInstCard(context, _resultsList[index]),
            ),
          ),
        ],
      ),
    );
  }
}

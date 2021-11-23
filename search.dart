import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/models/Institution.dart';
import 'package:mostadeem/screens/inst_card.dart';
import 'package:mostadeem/screens/viViewInstModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class searchInst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewInstViewModel>(
        create: (_) => ViewInstViewModel(),
        child: Container(height: 1200, width: 450, child: SearchInstList()));
  }
}

class SearchInstList extends StatefulWidget {
  const SearchInstList({
    Key key,
  }) : super(key: key);

  @override
  _SearchInstList createState() => _SearchInstList();
}

class _SearchInstList extends State<SearchInstList> {
  TextEditingController _searchController = TextEditingController();
  Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    getInsts();
    // showTopSnackBar(context,"Welcome #name", "Good to have you in Mostadeem",Icons.check_circle_outline_outlined,);
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangedDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getInsts();
  }

  _onSearchChanged() {
    print(_searchController.text);
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var instSnapshot in _allResults) {
        var name = Institution.fromSnapshot(instSnapshot).name.toLowerCase();
        print(name);
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(instSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }

    setState(() {
      _resultsList = showResults;
    });
  }

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
          Form(
            child: TextField(
              controller: _searchController,
              maxLength: 15,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by name',
              ),
            ),
          ),
          if (_resultsList.isEmpty)
            Container(
                child: Text(
              "No results for ${_searchController.text}",
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

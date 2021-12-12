import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mostadeem/institution/instViewProfile.dart';
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
  }

  Widget buildInstCard(BuildContext context, DocumentSnapshot document) {
    calculates(document);
    //final HomeZero obj = new HomeZero();
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
                      '(',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    Icon(
                      Icons.person,
                      size: 15,
                      color: Colors.grey,
                    ),
                    Text(
                      '${institution.ratesNo.toString()})',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 80),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mostadeem/Admin/viViewModel.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/models/Institution.dart';
import 'package:mostadeem/screens/inst_card.dart';
import 'package:mostadeem/screens/search.dart';
import 'package:mostadeem/screens/viViewInstModel.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mostadeem/Admin/components/social_icon.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/screens/home/viViewReqModel.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mostadeem/screens/inst_card.dart';

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
        .orderBy('ratesAvg', descending: true)
        .where("status", isEqualTo: "approved")
        .get();
    setState(() {
      _allResults = data.docs;
    });
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
          TextField(
            controller: _searchController,
            decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
          ),
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

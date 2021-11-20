

import 'package:flutter/material.dart';
import 'package:inst_app/institution/currentRequests.dart';
import 'package:inst_app/institution/requestsHistory.dart';
import 'package:inst_app/institution/viewRequests.dart';
import 'package:inst_app/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class InstHome extends StatefulWidget {
  @override
  _InstHomeState createState() => _InstHomeState();
}

class _InstHomeState extends State<InstHome> {
final AuthService _auth = AuthService();
final keyOne = GlobalKey();
final keyTwo = GlobalKey();
final keyThree = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SharedPreferences preferences;

    displayShowcase() async {
      preferences = await SharedPreferences.getInstance();
      bool showcaseVisibilityStatus = preferences.getBool("showShowcase");

      if (showcaseVisibilityStatus == null) {
        preferences.setBool("showShowcase", false).then((bool success) {
          if (success)
            print("Successfull in writing showshoexase");
          else
            print("some bloody problem occured");
        });

        return true;
      }

      return false;
    }

    displayShowcase().then((status) {
      if (status) {
        ShowCaseWidget.of(context).startShowCase([
        keyOne,
        keyTwo,
        keyThree,
        ]);
      }
    });

    return DefaultTabController(
      length:3,
      child: Scaffold(
      //  backgroundColor: Colors.white,
        appBar: AppBar(
         /* centerTitle: true,
          title: Text('Req'),
          titleSpacing:1.5,*/
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(18),
        ),
      ),
          backgroundColor: Color.fromRGBO(48, 126, 80, 1),
          elevation: 0.0,
          toolbarHeight:30.0, //was 50 
          bottom:TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelColor:Color.fromRGBO(48, 126, 80, 1), 
            unselectedLabelColor:Colors.grey,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomLeft:Radius.circular(1),bottomRight:Radius.circular(1), ),
            color:Colors.grey[50],
            ),
            //indicatorWeight:3,
            tabs: [
              Tab(child: Align(alignment: Alignment.center, child: Text('New'),)),
              Tab(child: Align(alignment: Alignment.center, child: Text('Accepted'),)),
              Tab(child: Align(alignment: Alignment.center, child: Text('History'),)),

            ],
          ),
          ),
          body: TabBarView(children: [
            reqestsView(),
            currentRequestsView(),
            requestsHistory() // to be updated to MY appointments
          ],),
      ),
    );
  }
}
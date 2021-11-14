

import 'package:flutter/material.dart';
import 'package:mostadeem/institution/currentRequests.dart';
import 'package:mostadeem/institution/requestsHistory.dart';
import 'package:mostadeem/institution/viewRequests.dart';
import 'package:mostadeem/services/auth.dart';

class InstHome extends StatefulWidget {
  @override
  _InstHomeState createState() => _InstHomeState();
}

class _InstHomeState extends State<InstHome> {
final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
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
          toolbarHeight:50.0, //was 80 
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
            currentRequestsView(), // to be updated to MY appointments
            requestsHistory(),
          ],),
      ),
    );
  }
}
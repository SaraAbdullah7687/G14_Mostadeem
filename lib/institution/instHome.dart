

import 'package:flutter/material.dart';
import 'package:mostadeem/components/customShowCaseWidget.dart';
import 'package:mostadeem/institution/currentRequests.dart';
import 'package:mostadeem/institution/requestsHistory.dart';
import 'package:mostadeem/institution/viewRequests.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:showcaseview/showcaseview.dart';
//import 'package:showcaseview/showcase_widget.dart';

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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_)=> ShowCaseWidget.of(context).startShowCase([
        keyOne,
        keyTwo,
        keyThree,
      ])
    );
  }

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
            unselectedLabelColor:Colors.grey[350],
            indicator: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomLeft:Radius.circular(1),bottomRight:Radius.circular(1), ),
            color:Colors.grey[50],
            ),
            //indicatorWeight:3,
            tabs: [
              CustomShowCaseWidget(
                globalKey: keyOne,
                title:"New Requests:",
                description: "Here where you find your new requests",
                padding: EdgeInsets.all(12),
                child:
                 Tab(child: Align(alignment: Alignment.center, child: Text('New'),))),

              CustomShowCaseWidget(
                globalKey: keyTwo,
                title:"Accepted Requests:",
                description: "When you accept a request it will be come to this tab",
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child:Tab(child: Align(alignment: Alignment.center, child: Text('Accepted'),)),),

              CustomShowCaseWidget(
                globalKey: keyThree,
                title:"History of Requests:",
                description: "After completing the accepted requests, \nit will come to this tab",
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child:Tab(child: Align(alignment: Alignment.center, child: Text('History'),)),),
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
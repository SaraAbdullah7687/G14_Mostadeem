//import 'package:mustadeem/screens/home/brew_list.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//import 'package:mostadeem/Admin/viewins.dart';
import 'package:mostadeem/institution/instHome.dart';
import 'package:mostadeem/institution/instProfile.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mostadeem/institution/instHome.dart';
import 'package:mostadeem/institution/instProfile.dart';


class StartInst extends StatefulWidget {

  @override
  _StartInstState createState() => _StartInstState();
}

class _StartInstState extends State<StartInst> {
  final AuthService _auth = AuthService();

final screens=[ // indexes Sensitive
  InstHome(),
  InstProfile(),
];
int index =0;
final items =<Widget>[
Icon(Icons.home, size:30),
Icon(Icons.person, size:30),
];

  @override
 Widget build(BuildContext context) {

    return Scaffold(
   extendBody: true, // for nav bar , can be deleted
   body: screens[index],
  bottomNavigationBar:
  Theme(
    data: Theme.of(context).copyWith(
      iconTheme: IconThemeData(color: Colors.white),
    ) ,
    child: CurvedNavigationBar(
      color: Color.fromRGBO(48, 126, 80, 1),
     // buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.transparent,
      height:60 , // decreced nav height
      items: items,
  index: index,
  animationDuration:Duration(microseconds: 5000) ,
  onTap:(index)=> setState(()=> this.index=index) ,
    ),
  ) ,
    );
  
  }
}
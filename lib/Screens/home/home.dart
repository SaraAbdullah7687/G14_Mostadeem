import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mostadeem/Admin/viewInstitution.dart';
import 'package:mostadeem/Screens/home/home0.dart';
import 'package:mostadeem/Screens/home/profile.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// add package at yaml
class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

final screens=[ // indexes Sensitive
  HomeZero(),
  //requestScreen(); // for request
  ViewInstitution(), // for testing delete it 
  Profile(),
 
];

int index =0;

final items =<Widget>[
Icon(Icons.home, size:30),
Icon(Icons.add, size:30),
Icon(Icons.person, size:30),
];

  @override
 Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
       /* appBar: AppBar(
          backgroundColor: Color.fromRGBO(103, 145, 61, 1),
          centerTitle: true,
          title: const Text('MOSTADEEM'),
        ),*/
        /*
         appBar: AppBar(

           shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(18),
      ),
    ),
      /*  title: Text(
          "MOSTADEEM",
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),*/
        
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),//Color.fromRGBO(103, 145, 61, 1),
        elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person , size: 30.0,
            color: Colors.white,),
              label: Text(
          "Logout",
          style: TextStyle(color: Colors.white,
          ),
        ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
          toolbarHeight:80.0,
        ),
*/

        //  backgroundColor: Colors.white10,
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


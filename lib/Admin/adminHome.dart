
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mostadeem/Admin/Add/info.dart';
import 'package:mostadeem/Admin/Add/startAdd.dart';
import 'package:mostadeem/Admin/viewins.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
 const AdminHome({Key key, this.feedback,
 }) : super(key: key);

  final Function feedback;
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
final screens=[ // indexes Sensitive
  institutionView(), // this is the home
  StartAdd(),
];
int index =0;
final items =<Widget>[
Icon(Icons.home, size:30),
Icon(Icons.add, size:30),
];
@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        widget.feedback.call();
      },
    );
  }
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
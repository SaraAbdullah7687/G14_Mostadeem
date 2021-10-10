//import 'package:mustadeem/screens/home/brew_list.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mostadeem/Admin/viewInstitution.dart';
import 'package:mostadeem/Admin/viewins.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addAdvices.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final AuthService _auth = AuthService();

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    AdminHome(),
    institutionView(),
    Text('Advices'),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [
    // indexes Sensitive
    //AdminHome(), // no need
    institutionView(), // this is the home
    AddAdvices(),
    //ViewAdvices(),
  ];
  int index = 0;
  final items = <Widget>[
    Icon(Icons.home, size: 30),
    Icon(Icons.add, size: 30),
//Icon(Icons.info, size:30),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true, // for nav bar , can be deleted
      /*      appBar: AppBar(
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
            IconButton(
              padding: EdgeInsets.only(right: 15),
              icon: Icon(Icons.logout , size: 25.0,
            color: Colors.white,),
            
              onPressed: () async {
                await _auth.signOut();
                GoogleAuthApi.signOut();
              },
            ),
          ],
          toolbarHeight:80.0,
        ),
*/
/*        //  backgroundColor: Colors.white10,
        body: Stack(
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: size.width,
                  height: 80,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(size.width, 80),
                        painter: BNBCustomPainter(),
                      ),
                      Center(
                        heightFactor: 0.6,
                        child: FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: Color.fromRGBO(48, 126, 80, 1),//Color.fromRGBO(103, 145, 61, 1),
                          child: Icon(Icons.add_circle),
                          elevation: 0.1,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 30, bottom: 20),
                        width: size.width,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.house_rounded,
                                  color: Color.fromRGBO(48, 126, 80, 1),
                                  size: 50,
                                ),
                                onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return institutionView();//ViewInstitution(); // the general signup screen from nouf
                      },
                    ),
                  );}),
                            IconButton(
                                icon: Icon(
                                  Icons.person_rounded,
                                  color: Color.fromRGBO(48, 126, 80, 1),
                                  size: 50,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ));
  */
      /* bottomNavigationBar: BottomNavigationBar(
      backgroundColor: Color.fromRGBO(48, 126, 80, 1),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              'Home',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
            ),
            title: Text(
              'Info',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text(
              'Profile',
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
  */
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        child: CurvedNavigationBar(
          color: Color.fromRGBO(48, 126, 80, 1),
          // buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          height: 60, // decreced nav height
          items: items,
          index: index,
          animationDuration: Duration(microseconds: 5000),
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromRGBO(236, 232, 201, 0.7)
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    // canvas.drawShadow(path, Colors.grey, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

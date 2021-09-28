//import 'package:mustadeem/screens/home/brew_list.dart';
import 'package:test_project/Admin/viewInstitution.dart';
import 'package:test_project/services/auth.dart';
import 'package:test_project/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override

/*
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Text('MOSTADEEM'),
          backgroundColor: Colors.blue[900],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
       // body: BrewList(),
      ),
    );
  }
*/


 Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
       /* appBar: AppBar(
          backgroundColor: Color.fromRGBO(103, 145, 61, 1),
          centerTitle: true,
          title: const Text('MOSTADEEM'),
        ),*/
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
        
        backgroundColor: Color.fromRGBO(103, 145, 61, 1),
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


        //  backgroundColor: Colors.white10,
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
                          backgroundColor: Color.fromRGBO(103, 145, 61, 1),
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
                                  color: Color.fromRGBO(103, 145, 61, 1),
                                  size: 50,
                                ),
                                onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ViewInstitution(); // the general signup screen from nouf
                      },
                    ),
                  );}),
                            IconButton(
                                icon: Icon(
                                  Icons.person_rounded,
                                  color: Color.fromRGBO(103, 145, 61, 1),
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
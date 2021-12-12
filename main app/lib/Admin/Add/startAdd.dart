import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/Admin/Add/info.dart';
import 'package:mostadeem/services/auth.dart';

import 'addStore.dart';

class StartAdd extends StatelessWidget {
  const StartAdd({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add",
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
        ),
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 15),
            icon: Icon(
              Icons.logout,
              size: 25.0,
              color: Colors.white,
            ),
            onPressed: () async {
              await AuthService().signOut();
            },
          ),
        ],
        toolbarHeight: 60.0, // was 80
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildCard1(context),
            buildCard2(context),
          ],
        ),
      ),
    );
  }

  Widget buildCard1(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Info()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: 450, // 250
          height: 150, //200
          decoration: BoxDecoration(
            /*  border: Border.all(
                   color: Colors.green[900],
                  ),*/
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Material(
            color: Colors.white,
            elevation: 14.0, //14
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0x802196F3),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0), // 90
                child: myDetailsContainer1(
                  context,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(BuildContext context) {
    return Row(
      children: [
        imageWidget("assets/images/zeroWaste.png", "1"),
        textWidget("Add information"),
      ],
    );
  }

  Widget buildCard2(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddStore()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: 450, // 250
          height: 150, //200
          decoration: BoxDecoration(
            /*  border: Border.all(
                   color: Colors.green[900],
                  ),*/
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Material(
            color: Colors.white,
            elevation: 14.0, //14
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0x802196F3),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0), // 90
                child: myDetailsContainer2(
                  context,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer2(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Row(
        children: [
          imageWidget("assets/images/store.png", "2"),
          textWidget("Add stores"),
        ],
      ),
    );
  }

  Widget imageWidget(String image, String cardNum) {
    return ClipOval(
        child: cardNum == "1"
            ? Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              )
            : // not padding but margin!!
            Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                ),
              ));
    // );
  }

  Widget textWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w400,
          color: Colors.orange[700],
        ),
      ),
    );
  }
}

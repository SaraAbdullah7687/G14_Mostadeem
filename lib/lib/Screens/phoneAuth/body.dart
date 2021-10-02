import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:test_project/Screens/phoneAuth/background.dart';
import 'package:test_project/Screens/phoneAuth/constants.dart';
import 'package:test_project/main.dart';

import 'background.dart';

class Body extends StatelessWidget {
  const Body({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    //This size provides us with total height and width of our screen
    // ignore: sized_box_for_whitespace, prefer_const_constructors
    return firstBackground(
      // ignore: prefer_const_literals_to_create_immutables
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         
         const SizedBox(height: 16),
         

          
        ]
        ),
        );
  }
}
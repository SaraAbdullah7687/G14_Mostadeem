// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:inst_registration/background.dart';
import 'package:inst_registration/constants.dart';
import 'package:inst_registration/main.dart';

import 'background.dart';

class Body extends StatelessWidget {
  const Body({ Key? key }) : super(key: key);

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
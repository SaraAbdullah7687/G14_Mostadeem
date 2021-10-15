import 'package:flutter/material.dart';
import 'package:test_project/Screens/phoneAuth/body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(body: Body(),);
  }
}
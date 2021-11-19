import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/constants.dart';
//import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomShowCaseWidget extends StatelessWidget {
final Widget child;
final String title;
final String description;
final GlobalKey globalKey;
final EdgeInsets padding;

const CustomShowCaseWidget({

@required this.child,
@required this.title,
@required this.description,
@required this.globalKey,
this.padding,
});

  @override
  Widget build(BuildContext context) => Showcase(
  key:globalKey,
  showcaseBackgroundColor: Colors.orange,
  contentPadding: padding,
  title: title,
  overlayPadding:EdgeInsets.all(2),
  titleTextStyle: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
  description: description,
  descTextStyle: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 13,
  ),
  child: child,
  );



}
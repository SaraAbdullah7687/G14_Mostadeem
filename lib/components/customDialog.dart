

import 'package:flutter/material.dart';
import 'package:mostadeem/constants.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final IconData icon;
  final Function press;
  Widget content;

  CustomDialog({
    @required this.title,
    this.description,
    this.content,
    @required this.buttonText,
    @required this.press,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(padding1),
      ),      
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

dialogContent(BuildContext context) {
  return Stack(
    children: <Widget>[
      card(context),//...bottom card part,
      //...top circlular image part,
    ],
  );
}

Widget card(BuildContext context){
  return Container(
  padding: EdgeInsets.only(
    top: avatarRadius1 + padding1,
    bottom: padding1,
    left: padding1,
    right: padding1,
  ),
  margin: EdgeInsets.only(top: avatarRadius1),
  decoration: new BoxDecoration(
    color: Colors.white,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(padding1),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10.0,
        offset: const Offset(0.0, 10.0),
      ),
    ],
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min, // To make the card compact
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: kPrimaryColor, // added 
        ),
      ),
      SizedBox(height: 16.0),
      /*Text(
        description,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.0,
          color: kPrimaryColor
        ),
      ),*/
      content,
      SizedBox(height: 24.0),
      Align(
        alignment: Alignment.bottomRight,
        child: FlatButton(
          onPressed: press,
          child: Text(buttonText),
          color: Colors.blue,
        ),
      ),
    ],
  ),
);
}

}

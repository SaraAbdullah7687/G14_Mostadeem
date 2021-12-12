import 'package:flutter/material.dart';
import 'package:mostadeem/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor, // Colors.green[100], kPrimaryLightColor
       
  /*   border: Border.all(
      color: Colors.grey,
      width: 2,
    ),
       
        borderRadius: BorderRadius.circular(29),*/
      ),
      child: child,
    );
  }
}

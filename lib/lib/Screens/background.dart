import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key, 
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(             // add riyadh landmarks in this file
        alignment: Alignment.center,
        children: <Widget>[

          Positioned(
          top:0,
          width:size.width,
          child: Image.asset('assets/images/main_top.png'),),

          
          Positioned(
            bottom:0,
            width:size.width,
            child: Image.asset('assets/images/main_bottom.png'),),
         
          child,
        ],
      ),
    );
  }
}

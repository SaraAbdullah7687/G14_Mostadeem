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
    return Scaffold(
backgroundColor: Colors.white, 
    //resizeToAvoidBottomInset: false,
    body: SingleChildScrollView(
    child: Container(
      width: double.infinity,
      height: size.height,
      child: Stack(             // add riyadh landmarks in this file
        alignment: Alignment.center,
        children: <Widget>[

          Positioned(
          top:0,
          width:size.width,
          child: Image.asset('assets/images/main_top.png'),),

             AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Colors.green[50]),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),

          Positioned(
            bottom:0,
            width:size.width,
            child: Image.asset('assets/images/main_bottom.png'),),
         
          child,
        ],
      ),
    ),
    ),
    );
  }
}

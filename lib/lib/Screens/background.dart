// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:mostadeem_app/constants.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    Color c = const Color(0xFF467c54);
    return Container(
      height:size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[Positioned(
          
          child: Image.asset('assets/images/main_top.png'),),
          Positioned(
            bottom:0,
            width:size.width,
            child: Image.asset('assets/images/main_bottom.png'),),
            Positioned(
            left:0,
            top: 190,
            width:size.width,
            child: Image.asset('assets/images/logo.png'),),
            
          Positioned(
          left: 60,
          top:550,
          width: 300,
          height: 50,
          child: ElevatedButton(
          child: Text('Login',
          style: TextStyle(fontSize: 20)
          ),
          onPressed: () {},
           
            style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(83, 122, 88, 1),
            shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
            
            ),
          ),),

           ),
           
          Positioned(
          left: 60,
          top:620,
          width: 300,
          height: 50,
          child: ElevatedButton(
          child: Text('Register',
          style: TextStyle(fontSize: 20, color: Colors.black)
          ),
          onPressed: () {},
           
            style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(231, 226, 204, 1),
            shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
            
            ),
          ),),
          ),] 
        
    ));
  }
}
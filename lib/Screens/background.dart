// ignore: unused_import
// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:mostadeem_app/constants.dart';
import 'package:mostadeem_app/otp.dart';

// ignore: must_be_immutable
class firstBackground extends StatefulWidget {
 

  final Widget child;
  const firstBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<firstBackground> createState() => _BackgroundState();
}

class _BackgroundState extends State<firstBackground> {
  TextEditingController _controller = TextEditingController();
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
            
            
          Container(
          margin: EdgeInsets.only(top:450, left: 55),
          width: 300,
          height: 50,
          child: ElevatedButton(
          child: Text('Next',
          style: TextStyle(fontSize: 20)
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>OTPScreen(_controller.text))
            );
          },
           
            style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(83, 122, 88, 1),
            shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
            
            ),
          ),),

           ),

           Positioned(
           left: 70,
           top: 100,
           child: Text(
            'Phone Authentication', 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),)
           ),
              
           Container(
           alignment: Alignment.center,
           child: TextField(
            
            decoration: InputDecoration(hintText: 'Phone number',
            prefix: Padding(
            padding:EdgeInsets.all(4),
            child: Text("+966"),
            ), 
            ),maxLength: 9, keyboardType: TextInputType.number,controller: _controller,
            )   ),
          ] 
        
    ));
  }
}

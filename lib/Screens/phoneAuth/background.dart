import 'package:flutter/material.dart';
import 'package:test_project/Screens/phoneAuth/constants.dart';
import 'package:test_project/Screens/phoneAuth/otp.dart';

// ignore: must_be_immutable
class firstBackground extends StatefulWidget {

  final Widget child;
  
  const firstBackground({
    Key key,
    this.child,
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
            
            
            Positioned(
            width: 150,
            top: 100,
            left: 110,
            child: Image.asset('assets/images/message.png'),),
            

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
           left: 80,
           top: 250,
           child: Text(
            'Verify Your Number', 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),)
           ),
           Positioned(
           left: 100,
           top: 290,
           child: Text(
            'Please enter your mobile number to \nreceive One Time Password', 
            style: TextStyle( fontSize: 12),)
           ),
              
           Positioned(
             top: 350,
             width: size.width,
            /* margin: EdgeInsets.only(top: 95),
           alignment: Alignment.center,*/
           child: TextField(
            decoration: InputDecoration(hintText: '5XXXXXXXX',
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(10.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide()),
            prefix: Padding(
            padding:EdgeInsets.all(4),
            child: Text("+966"),
            ), 
            ),maxLength: 9, keyboardType: TextInputType.number,controller: _controller,
)  ),
          ] 
        
    ));
  }
}
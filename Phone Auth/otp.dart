// ignore: unused_import
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inst_registration/home.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPScreen extends StatefulWidget {
  final String phone; 
  OTPScreen(this.phone);

  //const OTPScreen({ Key? key }) : super(key: key);
  

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode = "";
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(220,220,220, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
    );
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return 
    
    
    
    Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      body: Column (children: [
        
        Container(
      
        child: Image.asset(
          'assets/images/main_top.png',
          width: size.width,
        )),

       
        Container(
        margin: EdgeInsets.only(top: 20),
        child: Image.asset(
          'assets/images/sms.png',
          width: 100,
        )),
      
        Container(
          margin: EdgeInsets.only(top: 40),
          child: Center(child: Text('Verifying +966-${widget.phone}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
         ),
       
       ),
        
         
        ),
        Container(
           margin: EdgeInsets.only(top: 20),
           child: Text(
            'One Time Password has been sent to your mobile \nnumber. Please verify.', 
            style: TextStyle( fontSize: 12),)
           ),
         
        Padding(
        padding: const EdgeInsets.all(30.0),
        child: PinPut(
        fieldsCount: 6,
        eachFieldMargin: EdgeInsets.only(top:10),
        textStyle: const TextStyle(fontSize: 25.0, color: Colors.grey),
        eachFieldWidth: 40.0,
        eachFieldHeight: 55.0,
        focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        submittedFieldDecoration: pinPutDecoration,
        selectedFieldDecoration: pinPutDecoration,
        followingFieldDecoration: pinPutDecoration,
        pinAnimationType: PinAnimationType.fade,
        onSubmit: (pin) async {
          try {
          await FirebaseAuth.instance.signInWithCredential(
            PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: pin))
              .then((value) async{
                if (value.user !=null){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Home()),
                 (route) => false);
                }
              });
        
          } catch(e){
            FocusScope.of(context).unfocus();
            _scaffoldkey.currentState!.showSnackBar(SnackBar(content: Text('invalid OTP')));
          }
        }),


        ),
         
       Padding (padding: const EdgeInsets.all(0),
       child: Container(
       margin: EdgeInsets.only(top: 94),
        child: Image.asset(
          'assets/images/main_bottom.png',
        
          width: size.width,
          
        )),
        ), 
       
      ],
      ),
                      
        );
   
  }

  _verifyPhone()async{
    await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: '+966${widget.phone}',
    verificationCompleted: (PhoneAuthCredential credential) async{
      await FirebaseAuth.instance
      .signInWithCredential(credential)
      .then((value) async {
        if (value.user !=null){
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Home()),
                 (route) => false);
        }
      });
    },
    verificationFailed: (FirebaseAuthException e) {
      print(e.message);
    },


      codeSent: (String verificationID, int? resendToken) {
        setState(() {
        _verificationCode = verificationID;

      });
      },

    codeAutoRetrievalTimeout: (String verificationID){
      setState(() {
        _verificationCode = verificationID;

      });},

    timeout: Duration(seconds: 60));

  }
  @override 
  void initState(){
  super.initState();
  _verifyPhone();
  }
}
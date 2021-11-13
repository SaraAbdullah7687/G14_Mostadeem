import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/globals/global.dart' as globals;
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mostadeem/screens/home/home.dart';
import 'package:mostadeem/screens/home/viewNewQR.dart';
import 'package:mostadeem/screens/home/viewQR.dart';



String code='';




class redeem extends StatefulWidget {

  
  const redeem({ Key key }) : super(key: key);

  @override
  _redeemState createState() => _redeemState();
}

class _redeemState extends State<redeem> {

String sar;
double sarNum=0;
double amount= globals.userPoints/5;
  var firebaseUser =  FirebaseAuth.instance.currentUser;



  Widget buildSAR() => TextFormField(
  cursorColor: Color.fromRGBO(48, 126, 80, 1),
      
       keyboardType: TextInputType.number,controller: _controller,


       validator: (value){

     if(value==null){
      return 'Required';
    } 
    
    else if (_isNumeric(value) == false)
    return "Please enter a number";
    else if (amount<double.parse(_controller.text))
    return "You only have "+amount.toString()+' SAR';
     else return null;
  },



      decoration: InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 15),
        prefixIcon: Padding(
         padding: EdgeInsets.all(0.0),
         child: Icon(
          Icons.money,
           color: Color.fromRGBO(48, 126, 80, 1)),
            ), 
        labelText: 'Saudi Riyals',
        labelStyle: TextStyle(
          color: 
        Color.fromRGBO(48, 126, 80, 1)),
        border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(15)
        ),
        focusedBorder: OutlineInputBorder(
       borderSide: const BorderSide(color: Color.fromRGBO(48, 126, 80, 1)),
       borderRadius: BorderRadius.circular(15.0),

        ),
      ),
      onChanged: (value) => setState(() => sar = value)
);
      
    

    bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }




final firestoreInstance = FirebaseFirestore.instance;


Widget buildCreateQr(BuildContext context) {

return ElevatedButton(
      
           child: Text('Get QR Code',
          style: TextStyle(fontSize: 20, color: Colors.white)
          ),
          onPressed: () async{
          code=generateRandomString(10);

          if(formKey.currentState.validate()){
          sarNum= double.parse(sar);



            try{


              firestoreInstance.collection("code").add({
              "amount":double.parse(sar),
              "code": code,
              "dateRedeemed":globals.todayDate,
              "status":'valid',
              'uid':firebaseUser.uid,

            

            });
            int usedPoints= (sarNum*5.ceil()).toInt();
            FirebaseFirestore.instance.collection('contributor').doc(FirebaseAuth.instance.currentUser.uid).update({
            'points': globals.userPoints-usedPoints

            });

            getPoints();



            Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>viewNewQR(code: code, status: 'valid', dateCreated: globals.todayDate, amount: double.parse(sar),)));
            

            getPoints();




            





          } catch(e){
            print(e);
          }



          }},




          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            primary: Color.fromRGBO(48, 126, 80, 1),
            shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
            
            ),),);}













    TextEditingController _controller = TextEditingController();

    final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
String today = DateFormat('dd-MM-yyy').format(now);
  globals.todayDate=today;

    return 
    
Scaffold(
               body:SingleChildScrollView(


            


      child: 
      Container(
        height:300,
       child:Form(
      autovalidateMode: AutovalidateMode.always,
      key: formKey,
      child: Stack(
      children: [

        Container(

          margin: EdgeInsets.all(20),

        child: Text('Enter the amount of SAR you want to use',
        style: TextStyle(
        color: Color.fromRGBO(48, 126, 80, 1),
        fontWeight: FontWeight.bold,
        fontSize: 18
        ),
        
        )
        ),


        



        Container(
        margin: EdgeInsets.only(left:20, top: 60),


        child: Text('Please note that the QR code can be used only once,\nso specify your need of SAR precisely',
        style: TextStyle(
        color: Colors.red,
        fontSize: 14
        ),
        
        )
        ),

        Container(
          margin: EdgeInsets.only(top: 120, left:20, right:20),

          child: buildSAR(),
        ),

        Container(
          margin: EdgeInsets.only(top: 200, left:110, right:20),

          child: buildCreateQr(context),
        )



        
      ],)
)





      )));


      
    
  }
}
String generateRandomString(int len) {
    var r = Random();
    String randomString =String.fromCharCodes(List.generate(len, (index)=> r.nextInt(33) + 89));
      return randomString;
    }



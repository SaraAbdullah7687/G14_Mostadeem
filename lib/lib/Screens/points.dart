
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/globals/global.dart';
import 'package:mostadeem/screens/home/home.dart';
import 'package:mostadeem/screens/home/qr.dart';
import 'package:mostadeem/screens/home/redeem.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/globals/global.dart' as globals;


class points extends StatefulWidget {
  @override
  State<points> createState() => _pointsState();
}

class _pointsState extends State<points> {
  final AuthService _auth = AuthService();
  





  @override
  Widget build(BuildContext context) {
     getPoints();



    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(

          
          
        centerTitle: true,

        title: const Text('My Rewards', style: TextStyle( color: Color.fromRGBO(48, 126, 80, 1))),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: Icon(Icons.arrow_back , size: 35.0,
         color: Color.fromRGBO(48, 126, 80, 1),),
         onPressed: ()  {
           getPoints();
                Navigator.pushAndRemoveUntil(
                   context, MaterialPageRoute(builder: (context) => Home()),
                   (route) => false);
                
              },);} ),

         
          
        toolbarHeight: 70.0,
      ),
      
        body: Column(
          children: <Widget>[
            // construct the profile details widget here
            Center(

        child: Container(

          child: Column(
          children: <Widget>[
          
          Container(
          margin: EdgeInsets.only(top:0),
          height: 180,

          child: Stack(children: [
          
          Container(
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage(
              'assets/images/confetti.png'),
          fit: BoxFit.fill,
          ),)

          ),
          
          Positioned(
          
          top:30,
          left: 130,
          child: Text('Your Points',
          style: TextStyle(
          backgroundColor: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          ),
          textAlign: TextAlign.center,
          ),),
          
          Positioned(
          top:50,
          left: 118,  
          child: 
          Container(
          margin: EdgeInsets.only(top:5),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromRGBO(48, 126, 80, 1),
          ),
          child: FittedBox(
          fit: BoxFit.contain,

          
          
          child: Text(getPoints(), 
          
          
          
          style: TextStyle(
          color: Colors.white,
            
          
          fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          ),),
          
          


            height: 50,
            width: 110,
            
          ),
          ),




          Positioned(
          top:110,
          left: 87,  
          child: 
          Container(
          margin: EdgeInsets.only(top:5),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromRGBO(48, 126, 80, 0.3),
          ),

          
          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[






          Text("Equivalent to "+(userPoints/5).toString()+" SAR", // Right it in the regulations 
          
          
          
          style: TextStyle(
          fontSize: 14,
          color: Color.fromRGBO(48, 126, 80, 1),
            
          
          fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          ),]),
          
            height: 30,
            width: 180,
            
          ),),


          ],),



          ),
         
          
          ]),





        ),
          
        ),
          

          // the tab bar with two items
            SizedBox(
              
              height: 50,
              child: AppBar(
                
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          elevation: 0.0,
          toolbarHeight:30.0, //was 50 
          bottom:TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Color.fromRGBO(48, 126, 80, 1),
            labelColor:Color.fromRGBO(48, 126, 80, 1), 
            unselectedLabelColor: Colors.grey,
            
                  tabs: [
                    Tab(
                      child: Text("Redeem Points", 
                     style: TextStyle(
                    fontSize: 13,
                 fontWeight: FontWeight.bold,
                 ),
                    ),),
                    Tab(
                      child: Text("Valid QR codes", 
                     style: TextStyle(
                    fontSize: 13,
                 fontWeight: FontWeight.bold,
                 ),
                      ),
                    ),

                    Tab(
                      child: Text("Invalid QR codes", 
                     style: TextStyle(
                    fontSize: 13,
                 fontWeight: FontWeight.bold,
                 ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [

                  redeem(),

                   qrCodes(),

                   InvalidQRCodes()

                   

                
                ],
              ),
            ),

                  
                  
           ] ),
      ),
    );
  }
}
final firestoreInstance = FirebaseFirestore.instance;


String getPoints(){
   
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("contributor").doc(firebaseUser.uid).get().then((value){
      int points =(value.data()['points']);
      globals.userPoints=points;
      }) ;
      return userPoints.toString();
      ;}

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inst_app/Screens/authenticate/logIn.dart';
import 'package:inst_app/Screens/changePass.dart';
import 'package:inst_app/Screens/editProfile.dart';
import 'package:inst_app/Screens/home0.dart';
import 'package:inst_app/Screens/profile.dart';
import 'package:inst_app/institution/instHome.dart';
import 'package:inst_app/main.dart';
import 'package:inst_app/Screens/authenticate/registerScreen.dart';
import 'package:inst_app/services/auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:inst_app/services/globals.dart' as globals;

import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

class Home extends StatefulWidget {
  const Home({ Key key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


    final AuthService _auth = AuthService();
    

  final screens = [
    
    // indexes Sensitive
ShowCaseWidget(
    builder:Builder (builder: (_)=> InstHome(),),),
    profile(),
  ];
 
  int index = 0;

  final items = <Widget>[
    Icon(Icons.home, size: 30),
    Icon(Icons.person, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
     getName();
     getEmail();
     getPhone();
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        child: CurvedNavigationBar(
          color: Color.fromRGBO(48, 126, 80, 1),
          // buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          height: 60, // decreced nav height
          items: items,
          index: index,
          animationDuration: Duration(microseconds: 5000),
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}




final firestoreInstance = FirebaseFirestore.instance;


String getName(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;

    firestoreInstance.collection("contributor").doc(firebaseUser.uid).get().then((value){
      String name =(value.data()['name']);
      globals.userName=name;
      }) 
      ;
      
      return globals.userName;

      } 
String getEmail(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;

    firestoreInstance.collection("contributor").doc(firebaseUser.uid).get().then((value){
      String email =(value.data()['email']);
      globals.userEmail=email;
      }) 
      ;
      
      return globals.userEmail;

      } 

      

 void getPhone(){
   
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("contributor").doc(firebaseUser.uid).get().then((value){
      String phone =(value.data()['phone']);
      globals.userPhone=phone;
      }) 
      ;}  
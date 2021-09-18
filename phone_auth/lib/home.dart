import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem_app/Screens/background.dart';
import 'package:mostadeem_app/main.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
     title: Text('Home'),
     actions: [
      IconButton(
        icon: Icon(Icons.logout),
        onPressed: () async {

          // LOGOUT 
          
          /*await FirebaseAuth.instance.signOut();
          Navigator.pushAndRemoveUntil(
            
            context, MaterialPageRoute(builder: (context) => firstBackground()),
             (route) => false);*/
        },
        )

     ],

    ),
     
     body: Center(child: Text(uid),

    )
      
    );
  }
  @override
  void initState(){

    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }
}
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inst_trial/Screens/authenticate/logIn.dart';
import 'package:inst_trial/Screens/editProfile.dart';
import 'package:inst_trial/main.dart';
import 'package:inst_trial/Screens/authenticate/registerScreen.dart';
import 'package:inst_trial/services/auth.dart';

import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({ Key key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid='';
  @override
  Widget build(BuildContext context) {

 final AuthService _auth = AuthService();
    
    return Scaffold(
    appBar: AppBar(
      centerTitle: true,
   title: Image.asset('assets/images/appBarLogo.png', fit: BoxFit.cover, 
   height: 55,
   width: 55,),
     actions: [
      
        
        
        IconButton(
        icon: Icon(Icons.person),
        onPressed: (){Navigator.of(context).push(
                 MaterialPageRoute(builder: (context)=>editProfile(),));
                 },)

     ],
     leading: IconButton(
        icon: Icon(Icons.logout),
        onPressed: () async {
          await AuthService().signOut();
          
          Navigator.pushAndRemoveUntil(
            
            context, MaterialPageRoute(builder: (context) => logIn()),
             (route) => false);}),
        

shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20))),

  
  backgroundColor: Color.fromRGBO(48, 126, 80, 1),
  ),
    
     
     body: Center(child: Text('Institution Home'),

    )
      
    );
  }
  @override
  void initState(){

    super.initState();
    uid = FirebaseAuth.instance.currentUser.uid;
  }
}

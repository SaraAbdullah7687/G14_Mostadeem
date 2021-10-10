import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inst_trial/Screens/authenticate/logIn.dart';
import 'package:inst_trial/constants.dart';
import 'package:inst_trial/Screens/home.dart';
import 'package:inst_trial/Screens/authenticate/registerScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inst_trial/models/instModel.dart';
import 'package:inst_trial/services/auth.dart';
import 'package:inst_trial/Screens/wraper.dart';
import 'package:provider/provider.dart';

import 'models/userMu.dart';



Future<void> main() async { 
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(); // important
runApp(MyApp());
}


class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp(); //add it for future builder
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     
     return 
   StreamProvider<UserMu>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
        home: logIn(),//Wrapper(),
      ),
    );

  }


    
     
      
      
      
  
  }



getStatus(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("institution").doc(firebaseUser.uid).get().then((value){
      print(value.data());
    });
  }

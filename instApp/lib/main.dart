import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inst_app/Screens/authenticate/logIn.dart';
import 'package:inst_app/Screens/profile.dart';




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
   MaterialApp(
       debugShowCheckedModeBanner: false,
        home: logIn(),
      );
    

  }


    
     
      
      
      
  
  }


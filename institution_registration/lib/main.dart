import 'package:flutter/material.dart';
import 'package:inst_registration/constants.dart';
import 'package:inst_registration/reg.dart';
import 'package:inst_registration/registerScreen.dart';
void main() async{
 
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
    
      debugShowCheckedModeBanner: false,
      title: 'Mostadeem',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      
      // ignore: prefer_const_constructors
      home:  regScreen(),
      
      );
      
      
  
  }
}


import 'package:flutter/material.dart';
import 'package:mostadeem_app/Screens/Welcome/welcome_screen.dart';
import 'package:mostadeem_app/constants.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
      home:  WelcomeScreen(),
    );
  }
}


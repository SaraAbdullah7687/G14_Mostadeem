//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:test_project/Screens/Login/login_screen.dart';
//import 'package:test_project/Screens/Welcome/welcome_screen.dart';
//import 'package:test_project/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_project/models/userMu.dart';
import 'package:test_project/services/auth.dart';
import 'package:provider/provider.dart';

import 'Admin/viewInstitution.dart';
import 'Screens/wrapper.dart';
//import 'Screens/wrapper.dart';
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
        home: Wrapper(),//Wrapper(),//Wrapper(), LoginScreen, ViewInstitution
      ),
    );
   /* MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mustadeem',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white, // if i make it white the textFormFields becomes purple || Colors.green[100]
      ),
      home: LoginScreen(),
      /*home:FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot){
          if (snapshot.hasError){
            print('you have an error! ${snapshot.error.toString()}');
            return Text('something went wrong!');
          } else if (snapshot.hasData){
            return LoginScreen();
          }else {
            return Center( child: CircularProgressIndicator(),);
          }
        },
      )*/
      // WelcomeScreen(),//home: WelcomeScreen(), was just like this 
    );*/
    
  }
}

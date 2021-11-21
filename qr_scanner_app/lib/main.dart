import 'package:flutter/material.dart';
import 'package:qr_scanner_app/ScannerPage.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main()async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(); 
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp =
      Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScannerPage(),
    );
  } //add it for future builder{


}



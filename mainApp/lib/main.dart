import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mostadeem/models/userMu.dart';
import 'package:mostadeem/screens/home/home.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:provider/provider.dart';
import 'Screens/wrapper.dart';
import 'package:mostadeem/services/localNotific.dart';
import 'package:mostadeem/services/secondNotific.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // important

  // SARA Notification (local one)
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  // SARA Notification (global one)
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: false);

// app is closed, but still running in the background.
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

// app is fully terminated.
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    await createLocalNotification(message: message.data);
  });

// app is open and running in the foreground.
  FirebaseMessaging.onMessageOpenedApp.listen((message) async {
    await createLocalNotification(message: message.data);
  });

  initializeLocalNotification();
  AwesomeNotifications().actionStream.listen((receivedNotification) {
    Get.to(Home());
  });

  FirebaseMessaging.instance.getToken().then((token) {
    print(token);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp =
      Firebase.initializeApp(); //add it for future builder
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserMu>.value(
      value: AuthService().user,
      initialData: null,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(), //Wrapper(),//Wrapper(), LoginScreen, ViewInstitution
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

/*
class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
       print("works");
      return HomePage();
    }
    return LoginModhi();
  }
}*/
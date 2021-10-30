



import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/services/auth.dart';

class HomeZero extends StatefulWidget {
  @override
  _HomeZeroState createState() => _HomeZeroState();
}

class _HomeZeroState extends State<HomeZero> {
final AuthService _auth = AuthService();

final List<Flushbar> flushBars = [];
/*
@override
void initState(){
    super.initState();
    showTopSnackBar(context,"Welcome #name", "Good to have you in Mostadeem",);

  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

           shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(18),
      ),
    ),
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),
        elevation: 0.0,
       /* actions: <Widget>[
            IconButton(
              padding: EdgeInsets.only(right: 15),
              icon: Icon(Icons.logout , size: 25.0,
            color: Colors.white,),
            
              onPressed: () async {
                await _auth.signOut();
                GoogleAuthApi.signOut();
              },
            ),
          ],
          */
          toolbarHeight:60.0,
        ),
        
      body: 
          Center(
            child: Text(
              'Home',
              style: TextStyle(fontSize: 40, color: Color.fromRGBO(48, 126, 80, 1),),
            ),
          ),
        
      
    );
  }

 void showTopSnackBar(BuildContext context, String title, String message) => show(
        context,
        Flushbar(
          icon: Icon(Icons.check_circle_outline_outlined, size: 32, color: Colors.white),
          shouldIconPulse: false,
          title: title,
          message: message,
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          //margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
          borderRadius: BorderRadius.circular(6),
           barBlur: 20,
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
      );

      Future show(BuildContext context, Flushbar newFlushBar) async {
    await Future.wait(flushBars.map((flushBar) => flushBar.dismiss()).toList());
    flushBars.clear();

    newFlushBar.show(context);
    flushBars.add(newFlushBar);
  }


  
}
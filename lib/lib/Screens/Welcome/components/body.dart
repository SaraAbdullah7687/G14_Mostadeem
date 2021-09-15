import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Screens/Welcome/components/background.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
           // SizedBox(height: size.height * 0.05),
           /* Positioned(
            left:0,
            top: 190,
            width:size.width,
            child: Image.asset('assets/images/logo.png'),),*/
           /* SvgPicture.asset(
              "assets/icons/chat.svg", // change it to mostadeem
              height: size.height * 0.45,
            ),*/
             AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Colors.green[900]),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),

             SizedBox(
             height: 250, // change the number to make the logo bigger     
           // width:size.width,
             child: Image.asset("assets/images/logo.png",
              fit: BoxFit.contain,)),
SizedBox(height: size.height * 0.05),
            Text(
              "SIGN UP AS",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05), // for what?
            RoundedButton(
              text: "Contirbutor", // change size + font
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen(); // reg form contirbutor
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Institution",
              color: Color(0XFFEDE7CD),
              textColor: Colors.green[900], // Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen(); // reg form Institution
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
// must add back button or allredy have an account
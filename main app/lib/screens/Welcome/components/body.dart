import 'package:flutter/material.dart';
import 'package:mostadeem/Screens/authenticate/bodyLogin.dart';
import 'package:mostadeem/Screens/authenticate/bodySignUp.dart';
//import 'package:mostadeem/Screens/Login/login_screen.dart';
import 'package:mostadeem/Screens/Signup/signup_screen.dart';
import 'package:mostadeem/components/rounded_button.dart';
import 'package:mostadeem/constants.dart';
import 'package:mostadeem/Screens/Welcome/components/background.dart';
//import '../../background.dart';
//import 'package:flutter_svg/svg.dart';

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
        /* AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Colors.green[900]),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),*/

        //SizedBox(height: size.height * 0.03),
            SizedBox(
             height: 200, // change the number to make the logo bigger     
           // width:size.width,
             child: Image.asset("assets/images/logo.png",
              fit: BoxFit.contain,)),
SizedBox(height: size.height * 0.05),
           
            Text(
              "SIGN UP AS",
              style: TextStyle( color: Colors.green[900],
              fontSize: 27,
                fontWeight: FontWeight.w600),
            ),
            SizedBox(height: size.height * 0.03), // for what?

            RoundedButton(
              text: "Contirbutor", // change size + font
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BodySignUp(); // SignUpScreen() origenal reg form contirbutor
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Institution",
              color: Color(0XFFEDE7CD), //Color(0xFF1B5E20)
              textColor: Color(0xFF1B5E20), // Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BodyLogin();//LoginScreen // reg form Institution was SignUpScreen
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
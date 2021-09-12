import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
//import 'package:flutter_auth/Screens/Signup/components/or_divider.dart';
//import 'package:flutter_auth/Screens/Signup/components/social_icon.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(// i added form 
       child: Form( // make the form scrollable
         autovalidateMode: AutovalidateMode.always, // added it
         child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           /* Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),*/
            SizedBox(height: size.height * 0.03),
            
           /* SvgPicture.asset(
              "assets/icons/signup.svg", //change to mustadeem
              height: size.height * 0.35,
            ),*/
/*
            Positioned(
            left:0,
            top: 190,
            width:size.width,
            child: Image.asset('assets/images/logo.png'),),*/

            RoundedInputField( // must be textFormField not input 
              hintText: "Name", // change icon 
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Email",
              errorTextForValidation: "Not a valid email",
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Phone",
              icon:Icons.phone,
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGN UP",
              press: () {}, // specify action
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck( // must make it clear , add padding or smth
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
           // OrDivider(),
           /* Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )*/
          ],
        ),
       ),
      ),
    );
  }
}

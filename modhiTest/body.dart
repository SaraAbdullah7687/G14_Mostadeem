import 'package:flutter/material.dart';
import 'package:mustadeem/Screens/background.dart';
import 'package:mustadeem/Screens/Signup/signup_screen.dart';
import 'package:mustadeem/Screens/Welcome/welcome_screen.dart';
import 'package:mustadeem/components/already_have_an_account_acheck.dart';
import 'package:mustadeem/components/rounded_button.dart';
import 'package:mustadeem/components/rounded_input_field.dart';
import 'package:mustadeem/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mustadeem/constants.dart';
import 'package:mustadeem/components/text_field_container.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
Map<String, String> _authData = { // can use variables instead of map 
    'email': '',
    'password': '',
  }; // added it 
  TextEditingController _emailController = TextEditingController(); //add it in rounded input class
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // added it
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
     //  padding: EdgeInsets.all(50.0), // this is why the fields looks smaller
       child: Form( // added it
       key: _formKey, // added it
         autovalidateMode: AutovalidateMode.always, // added it
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg", // change it to mustadeem
              height: size.height * 0.35,
            ),*/

            // add mostadeem logo
/*
 SizedBox(height: size.height * 0.05),
            Positioned(
            left:0,
            top: 190,
            width:size.width,
            child: Image.asset('assets/images/logo.png'),),
            */

            SizedBox(height: size.height * 0.03),

TextFieldContainer(
      child: TextFormField( 
        keyboardType: TextInputType.emailAddress, 
        controller: _emailController, 
        cursorColor: kPrimaryColor,
        textInputAction: TextInputAction.next, // added it
       // keyboardType: TextInputType.number, //for phone there's one for email

        decoration: InputDecoration(
          prefixIcon: Icon( Icons.mail, color: kPrimaryColor,
          ),
          hintText: "Email",
       //  border: InputBorder.none,
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(15.0),
          ),
          borderSide: new BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        ),
 /*validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },*/
         onSaved: (value) {
                    _authData['email'] = value;
                  },
      validator: MultiValidator([
      RequiredValidator(errorText: "Required"),
      EmailValidator(errorText: "Not a valid email"), // WRONG don't generlize all fields as email
      ]
      ),
      ),
    ),
    
            /*RoundedInputField(
              hintText: "Email",
              icon: Icons.mail, 
              errorTextForValidation: "Not a valid email",// added it
              textController: _emailController,
              onSaved: (value) {},
            ),*/
            
            RoundedPasswordField(
              controller: _passwordController,
              onSaved: (value) {
                    _authData['password'] = value;
                  }, // change it to onSaved
            ),
            
            RoundedButton(
              text: "LOGIN modhi",
              press: () { 
                 if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();
              },
            ),


            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WelcomeScreen(); // the general signup screen from nouf
                    },
                  ),
                );
              },
            ),
          ],
        ),
        ), // form
      ),
      ),
    );
  }
}

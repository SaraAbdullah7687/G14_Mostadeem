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
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth_service.dart';
import 'package:provider/provider.dart';


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
  // firebase 
  final _auth = FirebaseAuth.instance; // delete it 

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
         
         SizedBox(height: size.height * 0.03),
            SizedBox(
             height: 200, // change the number to make the logo bigger     
           // width:size.width,
             child: Image.asset("assets/images/logo.png",
              fit: BoxFit.contain,)),
 
            SizedBox(height: size.height * 0.03),

TextFieldContainer(
      child: TextFormField( 
        autofocus: false,
        keyboardType: TextInputType.emailAddress, 
        controller: _emailController, 
        cursorColor: kPrimaryColor,
        textInputAction: TextInputAction.next, // added it
       // keyboardType: TextInputType.number, //for phone there's one for email

        decoration: InputDecoration(
          prefixIcon: Icon( Icons.mail, color: kPrimaryColor,
          ),
          hintText: "Email",
          // contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15), // make it smaller
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
           // or _emailController.text = value!;
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
                // or  _passwordController.text = value!;
                    _authData['password'] = value;
                  }, // change it to onSaved
            //textInputAction: TextInputAction.done,
            ),
            
            RoundedButton(
              text: "LOG IN",
              press: () { 

                /* context.read<AuthenticationService>().signIn(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  );*/


               // signIn(_emailController.text, _passwordController.text);
                
                 if (!_formKey.currentState.validate()) {
                   print("validation doesn't works");// delete it 
                      return;
                    }
              print("validation works"); // delete it 
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

  // login function
  /*
  void signIn(String email, String password) async {
    //if (_formKey.currentState!.validate()) {
      if (_formKey.currentState.validate()){
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e.message); //e.!message
      });
    }
  }*/
}


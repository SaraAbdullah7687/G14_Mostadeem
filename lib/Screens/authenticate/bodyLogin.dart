import 'dart:io';



import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mostadeem/Screens/Login/components/resetPassword.dart';
import 'package:mostadeem/Screens/background.dart';
import 'package:mostadeem/components/advanceAlert.dart';
import 'package:mostadeem/components/already_have_an_account_acheck.dart';
import 'package:mostadeem/components/rounded_button.dart';
import 'package:mostadeem/components/rounded_password_field.dart';
import 'package:mostadeem/components/text_field_container.dart';
import 'package:mostadeem/globals/global.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/shared/loading.dart';
import '../../constants.dart';
import 'package:mostadeem/screens/home/home.dart';

class BodyLogin extends StatefulWidget {
  final Function toggleView; 

 const BodyLogin({
    Key key, 
    this.toggleView,
  }) : super(key: key);

  @override
  _BodyLoginState createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  
  final AuthService _auth = AuthService();
  bool loading = false;
  String error = '';
final List<Flushbar> flushBars = []; //   راجعيها
Map<String, String> _authData = { // can use variables instead of map 
    'email': '',
    'password': '',
  }; // added it 
  TextEditingController _emailController = TextEditingController(); //add it in rounded input class
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // added it
  // firebase 
  //final _auth = FirebaseAuth.instance; // delete it 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ()=> FocusManager.instance.primaryFocus.unfocus(),
      child: Scaffold(
        appBar: AppBar(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(18),
        ),
      ),
          backgroundColor: Color.fromRGBO(48, 126, 80, 1),
          elevation: 4.0,
            toolbarHeight:80.0,
          
          ),
    
        body: loading ? Loading(): 
        Background(
          child: SingleChildScrollView(
            child: Container(
            //  height: MediaQuery.of(context).size.height,
       // width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(24),
         //  padding: EdgeInsets.all(50.0), // this is why the fields looks smaller
       
           child: Form( // added it
           key: _formKey, // added it
             autovalidateMode: AutovalidateMode.always, // added it
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
    //SizedBox(height: size.height * 0.03),
    
           //  SizedBox(height: size.height * 0.03),
               SizedBox(
                 height: 250, // change the number to make the logo bigger     
                width:size.width,
                 child: Image.asset("assets/images/logo.png",
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,)),
     
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
                      onChanged: (val) {
                      setState(() => _authData['email'] = val);
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
                  controllerPw: _passwordController,
                  isSignUp: false,
                  onSaved: (value) {
                    // or  _passwordController.text = value!;
                        _authData['password'] = value;
                      }, // change it to onSaved
                //textInputAction: TextInputAction.done,
                onChanged: (val) {
                      setState(() => _authData['password'] = val);
                    },
    
                    press: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ResetPassword(); // the general signup screen from nouf
                        },
                      ),
                    );
                    }
                
                ),
                
                RoundedButton(
                  text: "Sign in",
                  press: () async{ 
                  if(_formKey.currentState.validate()){
                        //setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(_authData['email'].trim(), _authData['password']); // see the bookclub
                        
                        if(result == null) {
                          print("req returend null");
                          error = 'Please supply a valid email';
                         /* setState(() {
                            loading = false;
                          });*/
                        }else if(result == "No-user-found")
                        {print("No user found in if");
                      /*  setState(() {
                            loading = false;
                          });*/
                          showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AdvanceCustomAlert(
                        icon: Icons.cancel_outlined,
                        msgTitle: 'Invalid\n',
                        msgContent: 'Email or password incorrect',
                        btnContent: 'Ok',
                      );
                    });
                          //showTopSnackBar(context);
    
                          } else if(result == "Wrong-password")
                        {print("Wrong passwordin if");
                       /* setState(() {
                            loading = false;
                          });*/
                          showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AdvanceCustomAlert(
                        icon: Icons.cancel_outlined,
                        msgTitle: 'Invalid\n',
                        msgContent: 'Email or password incorrect',
                        btnContent: 'Ok',
                      );
                    });
                         // showTopSnackBar(context);
    
                          } 
                        else {print("req is not null");
                     /* Navigator.pushReplacement(context,
                  MaterialPageRoute(
                    builder: (context) => Home(
                      feedback: () {
                        _auth.showTopSnackBar(context,"Welcome", "Good to have you in Mostadeem",Icons.check_circle_outline_outlined,);
                      },
                    ),
                  ),
                );*/
                        }
                    }//
                  },
                ),
    
    
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: true,
                  press: () {
                  widget.toggleView();
                    
                  },
                ),
              ],
            ),
            ), // form
          ),
          ),
        ),
      ),
    );
  
  }
      
}


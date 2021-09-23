
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:test_project/Screens/Login/login_screen.dart';
import 'package:test_project/Screens/Welcome/welcome_screen.dart';
import 'package:test_project/Screens/background.dart';
//import 'package:flutter_auth/Screens/Signup/components/or_divider.dart';
//import 'package:flutter_auth/Screens/Signup/components/social_icon.dart';
import 'package:test_project/components/already_have_an_account_acheck.dart';
import 'package:test_project/components/rounded_button.dart';
import 'package:test_project/components/rounded_input_field.dart';
import 'package:test_project/components/rounded_password_field.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:test_project/components/text_field_container.dart';
import 'package:test_project/services/auth.dart';
import 'package:test_project/shared/loading.dart';
import '../../constants.dart';
import 'package:test_project/Screens/authenticate/authenticate.dart';

class BodySignUp extends StatefulWidget {
    final Function toggleView; 

 const BodySignUp({
    Key key, 
    this.toggleView,
  }) : super(key: key);
  


  @override
  _BodySignUpState createState() => _BodySignUpState();
}

class _BodySignUpState extends State<BodySignUp> {
  final AuthService _auth = AuthService();
  String error = '';
  bool loading = false;
String _email = '';
  String _password = '';

final List<Flushbar> flushBars = [];
Map<String, String> _authData = { // can use variables instead of map 
    'name': '',
    'email': '',
    'password': '',
  }; // added it 

  TextEditingController _emailController = TextEditingController(); //add it in rounded input class
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // added it
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: loading ? Loading() : 
      Background(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 40.0), // edit it 
       //  padding: EdgeInsets.all(50.0), // this is why the fields looks smaller
         child: Form( // added it
         key: _formKey, // added it
           autovalidateMode: AutovalidateMode.always, // added it
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
           SizedBox(height: size.height * 0.03),
        /* AppBar(
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Register'),
              onPressed: () => widget.toggleView(),
            ), 
         
          ],
        ),*/
           
           SizedBox(height: size.height * 0.03),
              SizedBox(
               height: 200, // change the number to make the logo bigger     
             // width:size.width,
               child: Image.asset("assets/images/logo.png",
                fit: BoxFit.contain,)),
 
              SizedBox(height: size.height * 0.01),

TextFieldContainer(
        child: TextFormField( 
          //autofocus: false,
          cursorColor: kPrimaryColor,
          textInputAction: TextInputAction.next, // added it
          decoration: InputDecoration(
          prefixIcon: Icon( Icons.person, color: kPrimaryColor, ),
          hintText: "Name",
         // contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15), // make it smaller
          border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
          const Radius.circular(15.0),),
          borderSide: new BorderSide(
          color: Colors.black,
          width: 1.0,),
          ),
          ),
 /*validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                      return null;
                    },*/
          validator: RequiredValidator(errorText: "Required"),
          onSaved: (value) {
          // or _emailController.text = value!;
          _authData['name'] = value; },

          onChanged: (val) {
                    setState(() => _authData['name'] = val);
                  },
        ),
      ),

TextFieldContainer(
        child: TextFormField( 
          //autofocus: false,
          keyboardType: TextInputType.emailAddress, 
          controller: _emailController, 
          cursorColor: kPrimaryColor,
          textInputAction: TextInputAction.next, // added it
          decoration: InputDecoration(
          prefixIcon: Icon( Icons.mail, color: kPrimaryColor, ),
          hintText: "Email",
         // contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15), // make it smaller
          border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
          const Radius.circular(15.0),),
          borderSide: new BorderSide(
          color: Colors.black,
          width: 1.0,),
          ),
          ),
 /*validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                      return null;
                    },*/
          validator: MultiValidator([
          RequiredValidator(errorText: "Required"),
          EmailValidator(errorText: "Not a valid email"),]),
          onSaved: (value) {
          // _emailController.text = value!;
          _email=value; // choose one of them 
          _authData['email'] = value; },

           onChanged: (val) {
                    setState(() => _authData['email'] = val);
                  },
        ),
      ),
      
              RoundedPasswordField(
                controller: _passwordController,
                onSaved: (value) {
                  // or  _passwordController.text = value!;
                  _password=value;
                      _authData['password'] = value;
                    }, // change it to onSaved
              //textInputAction: TextInputAction.done,
              onChanged: (val) {
                    setState(() => _authData['password'] = val);
                  },
              ),
              
              RoundedButton(
                text: "SIGNUP",
                press: () async{ 
                   if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      print("validate form,sending signup req"); // maybe beacuse it's dunamic?
                      dynamic result = await _auth.registerWithEmailAndPassword(_authData['email'].trim(), _authData['password'], _authData['name'].trim());
                      
                      if(result == null) {
                        print("req returend null");
                        error = 'Please supply a valid email';
                        setState(() {
                          loading = false;
                        });
                      }else if(result == "email exists")
                      {print("email exists in if");
                      setState(() {
                          loading = false;
                        });
                        showTopSnackBar(context);

                        } 
                      else{print("req is not null");}
                   
                    } 
                   /*if (!_formKey.currentState.validate()) {
                     print("validation doesn't works");// delete it 
                        return;
                      }
print("validation works"); // delete it 
                      _formKey.currentState.save();*/
                },
              ),


              SizedBox(height: size.height * 0.03),
             AlreadyHaveAnAccountCheck( // must make it clear , add padding or smth
                login: false,
                press: () {
                 // widget.toggleView();
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
            ],
          ),
          ), // form
        ),
        ),
      ),
    );
  
  
  
  } // works but shows an error in the console
       void showTopSnackBar(BuildContext context) => show(
        context,
        Flushbar(
          icon: Icon(Icons.error, size: 32, color: Colors.white),
          shouldIconPulse: false,
          title: 'INVALID',
          message: 'invalid email or password', // change message
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
          borderRadius: 16,
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

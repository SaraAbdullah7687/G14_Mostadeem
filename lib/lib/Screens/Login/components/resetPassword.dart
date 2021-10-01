
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:test_project/Screens/authenticate/bodyLogin.dart';
import 'package:test_project/Screens/background.dart';
import 'package:test_project/components/rounded_button.dart';
import 'package:test_project/components/text_field_container.dart';
import 'package:test_project/services/auth.dart';
import 'package:test_project/shared/loading.dart';

import '../../../constants.dart';


class ResetPassword extends StatefulWidget {


 const ResetPassword({
    Key key, 
  }) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  
  final AuthService _auth = AuthService();
  bool loading = false;
  String error = '';
final List<Flushbar> flushBars = []; //   راجعيها
Map<String, String> _authData = { // can use variables instead of map 
    'email': '',
    'password': '',
  }; // added it 
  TextEditingController _emailController = TextEditingController(); //add it in rounded input class
  //TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // added it
  // firebase 
  //final _auth = FirebaseAuth.instance; // delete it 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(18),
      ),
    ),
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),
        elevation: 0.0,
         leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Colors.green[50], size: 30.0,),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
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
            mainAxisAlignment: MainAxisAlignment.start,
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
          textInputAction: TextInputAction.done,

          decoration: InputDecoration(
            prefixIcon: Icon( Icons.mail, color: kPrimaryColor,
            ),
            hintText: "Email",
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
           onSaved: (value) {
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
              
              
              RoundedButton(
                text: "RESET",
                press: () async{ 
                if(_formKey.currentState.validate()){
                      setState(() => loading = true);
   
                      _auth.resetPassword(_authData['email']);
                        setState(() { 
                          loading = false;
                        });
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BodyLogin(); // the general signup screen from nouf
                      },
                    ),
                  );
                  showTopSnackBar(context);
                      
                    }
                },
              ),


              SizedBox(height: size.height * 0.03),
            ],
          ),
          ), // form
        ),
        ),
      ),
    );
  
  }
// works but shows an error in the console
       void showTopSnackBar(BuildContext context) => show(
        context,
        Flushbar(
          icon: Icon(Icons.error, size: 32, color: Colors.white),
          shouldIconPulse: false,
          title: 'Success',
          message: 'A reset password message has been sent to your email', // change message
          duration: Duration(seconds: 5),
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


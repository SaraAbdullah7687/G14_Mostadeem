
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mostadeem/Screens/authenticate/bodyLogin.dart'; 
import 'package:mostadeem/Screens/Login/components/backgroundReset.dart';
import 'package:mostadeem/components/advanceAlert.dart';
import 'package:mostadeem/components/rounded_button.dart';
import 'package:mostadeem/components/text_field_container.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/shared/loading.dart';
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
            //margin: EdgeInsets.all(24),
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
                text: "Reset",
                press: () async{ 
                if(_formKey.currentState.validate()){
                      setState(() => loading = true);
   
                     dynamic result= await _auth.resetPassword(_authData['email'].trim());
                        
if(result == "pass"){
  setState(() { 
                          loading = false;
                        });
                    /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BodyLogin(); 
                      },
                    ),
                  );*/
                  Navigator.of(context).pop();
                  showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AdvanceCustomAlert(
                      icon: Icons.email,
                      msgTitle: 'Check your email\n',
                      msgContent: 'A link has been sent to your email\n',
                      btnContent: 'Ok',
                    );
                  });
                //  showTopSnackBar(context, "Success","A reset password message has been sent to your email",);
                   }

                 else if(result=="fail"){ setState(() { 
                          loading = false;
                        });
                        showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AdvanceCustomAlert(
                      icon: Icons.cancel_outlined,
                        msgTitle: 'Invalid\n',
                        msgContent: 'This email has not been registered\n',
                        btnContent: 'Ok',
                    );
                  });
                  // showTopSnackBar(context, "Fail", "please make sure you entered the correct email");
                 }
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

}



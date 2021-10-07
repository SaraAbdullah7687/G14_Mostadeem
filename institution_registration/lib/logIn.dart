import 'dart:core';



//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inst_registration/Screens/home.dart';
import 'package:inst_registration/Screens/registerScreen.dart';
import 'package:inst_registration/services/auth.dart';
import 'package:inst_registration/services/popUp.dart';
import 'package:inst_registration/toOTP.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';







class logIn extends StatefulWidget {
  

  @override
  _logIn createState() => _logIn();
}

class _logIn extends State<logIn> {

 final AuthService _auth = AuthService();



  TextEditingController _emailController = TextEditingController(); //add it in rounded input class
  TextEditingController _passwordController = TextEditingController();










    Widget buildEmail() => TextFormField(
     
    cursorColor: Color.fromRGBO(48, 126, 80, 1),
    decoration: InputDecoration(
        
        prefixIcon: Padding(
         padding: EdgeInsets.all(0.0),
         child: Icon(
          Icons.email,
           color: Color.fromRGBO(48, 126, 80, 1)),
            ), 
        labelText: 'Email',
        
       border: OutlineInputBorder(
       borderRadius: BorderRadius.circular(15.0),
        ),
        labelStyle: TextStyle(
	      color: Color.fromRGBO(48, 126, 80, 1),
         ),
        focusedBorder:OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromRGBO(48, 126, 80, 1), width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
        ),
      ),
       controller: _emailController, 

      onChanged: (value) => setState(() => email = value),
      validator: MultiValidator([
  RequiredValidator(errorText: "Required"),
  EmailValidator(errorText: "Enter a valid email"),
])
    );





      bool _isHidden = true;




  Widget buildPassword() => TextFormField(
    
    
  cursorColor: Color.fromRGBO(48, 126, 80, 1),

      validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  },
      decoration: InputDecoration(
        suffix: InkWell(
         onTap: _togglePasswordView,
        child: Icon(Icons.visibility,
        color: Color.fromRGBO(48, 126, 80, 1)),),
        prefixIcon: Padding(
         padding: EdgeInsets.all(0.0),
         child: Icon(
          Icons.lock,
           color: Color.fromRGBO(48, 126, 80, 1)),
            ), 
        labelText: 'Password',
        border: OutlineInputBorder(
       borderRadius: BorderRadius.circular(15.0),
        ),
        labelStyle: TextStyle(
	      color: Color.fromRGBO(48, 126, 80, 1),
         ),
        focusedBorder:OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromRGBO(48, 126, 80, 1), width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      controller: _passwordController,
      onChanged: (value) => setState(() => password = value),
      obscureText: _isHidden,
    );
    
 

    
    
void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });}

 


Widget buildLogo()=> Container(
  

height: 120,
margin: EdgeInsets.all(20),
  child: Image.asset('assets/images/logo.png', width: 150,),
);



Widget buildBackground(BuildContext context){ 
   
   Size size = MediaQuery.of(context).size; 
   return Container(
       alignment: Alignment.center,
      child: Positioned(
          bottom: 0,
          child: Image.asset('assets/images/main_bottom.png'), width:size.width,
),
);

}

Widget buildText(BuildContext context)=> Container(
      margin: EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
             "Don’t have an Account ? ",
            style: TextStyle(color: Color.fromRGBO(48, 126, 80, 1)),
          ),
          GestureDetector(
            onTap: ()=>Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>regScreen(),)),
            child: Text(
               "Sign Up" ,
              style: TextStyle(
                color: Color.fromRGBO(48, 126, 80, 1),
                fontWeight: FontWeight.bold,
             ),
            ),
          )
        ],

      ));



    

     




  

    Widget buildNext() => ElevatedButton(
           child: Text('Log In',
          style: TextStyle(fontSize: 20, color: Colors.white)
          ),
          onPressed: () async{
         String Email = _emailController.text.trim();
         String Pass = _passwordController.text.trim();
         

     
          if(formKey.currentState!.validate());

          
            //Navigator.push(
          //  context,
          // MaterialPageRoute(builder: (context) => WelcomeScreen()),
          // );
           

          /*print("validate form,sending signup req"); // maybe beacuse it's dunamic?
                    dynamic result = await _auth.registerWithEmailAndPassword(_authData['email'].trim(), _authData['password'], _authData['name'].trim());
                    print("req sent");
                    if(result == null) {
                      print("req returend null");
                      error = 'Please supply a valid email';
                      setState(() {
                        loading = false;
                      });
                    }else {print("req is not null");} 
*/
         /*Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => firstBackground(child: Scaffold())));
*/
          
          },
          
           
            style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            primary: Color.fromRGBO(48, 126, 80, 1),
            shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
            
            ),
  
       ));






  
  
    final formKey = GlobalKey<FormState>();
  

    String email = '';
    String password = '';
 


  @override
  Widget build(BuildContext context) => Scaffold(
     backgroundColor: Colors.white, 
    appBar: AppBar(
      centerTitle: true,

      title:  Text('Institution Log In'),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20))),

  
  backgroundColor: Color.fromRGBO(48, 126, 80, 1),
  ),



    body: Form(
      autovalidateMode: AutovalidateMode.always,
      key: formKey,
      child: ListView(
      padding: EdgeInsets.all(16),
      children: [
        buildLogo(),
        buildEmail(),
        const SizedBox(height: 32),
        buildPassword(),
        const SizedBox(height: 32),
        buildText(context),
        const SizedBox(height: 25),
        buildNext(),
        buildBackground(context)
      ],
      ),
    ),
      );
    


    

  }



 



 
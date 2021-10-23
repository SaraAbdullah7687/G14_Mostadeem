import 'dart:core';



//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inst_trial/Screens/home.dart';
import 'package:inst_trial/Screens/authenticate/registerScreen.dart';
import 'package:inst_trial/services/auth.dart';
import 'package:inst_trial/services/popUp.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:inst_trial/services/globals.dart' as globals;







class forgotPass extends StatefulWidget {
  

 
  @override
  _forgotPass createState() => _forgotPass();
}

class _forgotPass extends State<forgotPass> {

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
   


  TextEditingController _emailController = TextEditingController(); //add it in rounded input class
  TextEditingController _passwordController = TextEditingController();




final fb = FirebaseDatabase.instance;







    Widget buildEmail() => TextFormField(
     
    cursorColor: Color.fromRGBO(48, 126, 80, 1),
    decoration: InputDecoration(
               contentPadding: const EdgeInsets.symmetric(vertical: 15),

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


 


Widget buildLogo()=> Container(
  

height: 180,
margin: EdgeInsets.all(20),
  child: Image.asset('assets/images/lock.png', width: 150,),
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
        child:
          Text(
             "Please enter your email to get a reset password link",
            style: TextStyle(color: Color.fromRGBO(48, 126, 80, 1),
            fontSize: 15,
            fontWeight: FontWeight.bold),
          ),
          
        
            

            
            
      );
        

      



    

     



  

    Widget buildNext() => ElevatedButton(
           child: Text('Get link',
          style: TextStyle(fontSize: 20, color: Colors.white)
          ),

              onPressed: () async{
         String Email = _emailController.text.trim();
         

     
          if(formKey.currentState.validate());{

/////////////////////////
           
           try{
                
            await _firebaseAuth.sendPasswordResetEmail(email: Email);
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



               
                

                 
                
                  
                 
                }// change to wrapper
           

               catch (signUpError){
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
               }
               
                 }
                 



                    
         

          }
          
   
          
           
           , style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            primary: Color.fromRGBO(48, 126, 80, 1),
            shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
            
            ),
  
       ));




     
   


  
  
    final formKey = GlobalKey<FormState>();
  

   
 

  @override
  Widget build(BuildContext context) => Scaffold(

     backgroundColor: Colors.white, 
     appBar: AppBar(
     centerTitle: true,

      title:  Text('Reset Password'),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20))),

  
  backgroundColor: Color.fromRGBO(48, 126, 80, 1),
  ),



    body: 
    
     Form(
      autovalidateMode: AutovalidateMode.always,
      key: formKey,
      child: ListView(
      padding: EdgeInsets.all(16),
      children: [
        buildLogo(),
        buildText(context),
        const SizedBox(height: 20),
        buildEmail(),
        const SizedBox(height: 50),
        buildNext(),
        const SizedBox(height: 20),
        buildBackground(context)
        
      ],
      ),
    ));}
   
    

 String email = '';
    String password = '';
                 bool approved=false;



 



 

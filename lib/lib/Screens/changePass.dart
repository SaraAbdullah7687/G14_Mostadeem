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







class changePass extends StatefulWidget {
  


  @override
  _changePass createState() => _changePass();
}

class _changePass extends State<changePass> {

 final AuthService _auth = AuthService();



  TextEditingController _newPass = TextEditingController(); //add it in rounded input class
  TextEditingController _passwordController = TextEditingController();

bool checkValidCurrentPassword=true;


final fb = FirebaseDatabase.instance;







    


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
       contentPadding: const EdgeInsets.symmetric(vertical: 15),
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
        labelText: 'Current Password',
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
  

height: 100,
margin: EdgeInsets.all(10),
  child: Image.asset('assets/images/lock.png', width: 70,),
);










  Widget buildNewPassword() => Column(
    children: [
          
          Container(
            margin: EdgeInsets.only(bottom: 6),
            child: TextFormField(
  cursorColor: Color.fromRGBO(48, 126, 80, 1),

      validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  },
      decoration: InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 15),
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
        labelText: 'New Password',
        labelStyle: TextStyle(
          color: 
        Color.fromRGBO(48, 126, 80, 1)),
        border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(15)
        ),
        focusedBorder: OutlineInputBorder(
       borderSide: const BorderSide(color: Color.fromRGBO(48, 126, 80, 1)),
       borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      controller: _newPass,
      onChanged: (value) => setState(() => password = value),
      obscureText: _isHidden,
    )),
    



    new FlutterPwValidator(
    controller: _newPass,
    minLength: 8,
    uppercaseCharCount: 1,
    numericCharCount: 1,
    specialCharCount: 1,
    width: 400,
    height: 150,
    onSuccess: (){pass=true;},/// do something
)





    ]);

bool pass=false;




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
            child: Text(
               "Sign Up" ,
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color.fromRGBO(48, 126, 80, 1),
                fontWeight: FontWeight.bold,
             ),
            ),
            onTap: (){
              Navigator.of(context).push(
             MaterialPageRoute(builder: (context)=>regScreen(),));
            //widget.toggleView();
            }
            

            
            
      )
        ],

      ));



    

     



  

    Widget buildNext() => ElevatedButton(
           child: Text('Update Password',
          style: TextStyle(fontSize: 20, color: Colors.white)
          ),

              onPressed: () async{
                




          
          if(formKey.currentState.validate())
          if (pass==true){
          
           
           try{
                

               var firebaseUser =  FirebaseAuth.instance.currentUser;
           UserCredential authResult = await firebaseUser.reauthenticateWithCredential(
       EmailAuthProvider.credential(
         email:firebaseUser.email,
       password: password,
  ),
);


         print(authResult);
                

                 
                
                  
                 
                }

               catch (signUpError){
                 print (signUpError);
               showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AdvanceCustomAlert(
                        icon: Icons.cancel_outlined,
                        msgTitle: 'Incorrect',
                        msgContent: 'The current password is incorrect',
                        btnContent: 'Ok',
                      );

                    });
               }
               
                 }

              
                else
                {showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AdvanceCustomAlert(
                        icon: Icons.lock,
                        msgTitle: 'Weak Password\n',
                        msgContent: 'Please follow the given criteria for the new password',
                        btnContent: 'Ok',
                      );

                    });}


                 



                    
         

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

      title:  Text('Change Password'),
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
        const SizedBox(height: 20),
        buildPassword(),
        const SizedBox(height: 20),
        buildNewPassword(),
        const SizedBox(height: 20),
        buildText(context),
        const SizedBox(height: 20),
        buildNext(),
        
      ],
      ),
    ));}
   
    

 String email = '';
    String password = '';
                 bool approved=false;



 


Widget getUser(BuildContext context) {
  return new StreamBuilder(
      stream: FirebaseFirestore.instance.collection("institution").where("email", isEqualTo: email).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        int index=snapshot.data.docs.length;

        var userDocument = snapshot.data.docs[index];
        print (userDocument['status']);
        return new Text(userDocument['status']);
      }
  );
}
String mess='';


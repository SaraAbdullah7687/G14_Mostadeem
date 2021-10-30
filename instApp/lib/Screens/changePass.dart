import 'dart:core';



//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inst_app/Screens/forgotPass.dart';
import 'package:inst_app/Screens/home.dart';
import 'package:inst_app/Screens/authenticate/registerScreen.dart';
import 'package:inst_app/Screens/profile.dart';
import 'package:inst_app/services/auth.dart';
import 'package:inst_app/services/popUp.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:inst_app/services/globals.dart' as globals;







class changePass extends StatefulWidget {
  


  @override
  _changePass createState() => _changePass();
}

class _changePass extends State<changePass> {

 final AuthService _auth = AuthService();



  TextEditingController _newPass = TextEditingController(); //add it in rounded input class
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

bool checkValidCurrentPassword=true;


final fb = FirebaseDatabase.instance;







    


bool _isHidden = true;
bool _isHidden1 = true;
bool _isHidden2 = true;





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




    
 Widget buildConfirmPassword() => TextFormField(
    
    
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
         onTap: _togglePasswordView1,
        child: Icon(Icons.visibility,
        color: Color.fromRGBO(48, 126, 80, 1)),),
        prefixIcon: Padding(
         padding: EdgeInsets.all(0.0),
         child: Icon(
          Icons.lock,
           color: Color.fromRGBO(48, 126, 80, 1)),
            ), 
        labelText: 'Confirm Password',
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
      controller: _confirmPasswordController,
      onChanged: (value) => setState(() => confirmPass = value),
      obscureText: _isHidden1,
    );
    

    
void _togglePasswordView1() {
    setState(() {
      _isHidden1 = !_isHidden1;
    });}

void _togglePasswordView2() {
    setState(() {
      _isHidden2 = !_isHidden2;
    });}


void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });}

 












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
         onTap: _togglePasswordView2,
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
      onChanged: (value) async {
              setState(() {
                newPassword=value;
                pass=false;

              });
              }, 
      obscureText: _isHidden2,
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

bool pass=true;




Widget buildText(BuildContext context)=> Container(
      child: Row(
        children: <Widget>[
          Align(alignment: Alignment.topRight,),
          GestureDetector(
            child: Text(
               "Forgot Password?" ,
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color.fromRGBO(48, 126, 80, 1),
                fontWeight: FontWeight.bold,
             ),
            ),
            onTap: (){
              Navigator.of(context).push(
             MaterialPageRoute(builder: (context)=>forgotPass(),));
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
          if (authResult==null){showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AdvanceCustomAlert(
                        icon: Icons.cancel_outlined,
                        msgTitle: 'Incorrect\n',
                        msgContent: 'The current password is incorrect\n',
                        btnContent: 'Ok',
                      );

                    });}



          if(newPassword==confirmPass){
            if (newPassword==password){
              showDialog(context: context, builder: (BuildContext context){
               return AdvanceCustomAlert(icon: Icons.password, msgTitle: 'Passwords are the same\n', 
               msgContent: 'The new password is the same as the current password', btnContent: 'Ok');
              });
             }

             else{
            firebaseUser.updatePassword(newPassword).then((_){
            print("Successfully changed password");
             });
             Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>profile(),));
              showDialog(context: context, builder: (BuildContext context){
               return AdvanceCustomAlert(icon: Icons.check, msgTitle: 'Success\n', 
               msgContent: 'Your password has been changed successfully\n', btnContent: 'Ok');
              });}
          }
          else {
              showDialog(context: context, builder: (BuildContext context){
               return AdvanceCustomAlert(icon: Icons.cancel_outlined, msgTitle: 'Passwords does not match\n', 
               msgContent: 'New password and confirm password does not match', btnContent: 'Ok');
              });


          }
  

           print(authResult);

                

                 
                
                  
                 
                }

               catch (signUpError){
                 print (signUpError);
               showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AdvanceCustomAlert(
                        icon: Icons.cancel_outlined,
                        msgTitle: 'Incorrect\n',
                        msgContent: 'The current password is incorrect\n',
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
        buildPassword(),
        const SizedBox(height: 10),
        buildText(context),
        const SizedBox(height: 10),
        buildNewPassword(),
        const SizedBox(height: 20),
        buildConfirmPassword(),
        const SizedBox(height: 70),
        buildNext(),
        
      ],
      ),
    ));}
   
    

 String email = '';
    String password = '';
    String newPassword='';
    String confirmPass='';



 


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


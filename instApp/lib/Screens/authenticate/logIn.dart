import 'dart:core';



//import 'dart:js';
import 'package:another_flushbar/flushbar.dart';

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
//import 'package:inst_app/institution/start.dart';
import 'package:inst_app/services/auth.dart';
import 'package:inst_app/services/globals.dart';
import 'package:inst_app/services/popUp.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:inst_app/services/globals.dart' as globals;
import 'package:inst_app/components/advancedAlertNew.dart';







class logIn extends StatefulWidget {
  
final Function toggleView; 

 const logIn({
    Key key, 
    this.toggleView,
  }) : super(key: key);

  @override
  _logIn createState() => _logIn();
}

class _logIn extends State<logIn> {

 final AuthService _auth = AuthService();



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
  

height: 150,
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
      margin: EdgeInsets.only(top:10),
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
           child: Text('Log In',
          style: TextStyle(fontSize: 20, color: Colors.white)
          ),

              onPressed: () async{
         String Email = _emailController.text.trim();
         String Pass = _passwordController.text.trim();
         

     
          if(formKey.currentState.validate());{
/////////////////////////
           
           try{
                
                dynamic result = await _auth.signInWithEmailAndPassword(Email, Pass); 
                 getName();

               
                getStatus(context);
                

                 
                
                  
                 
                }// change to wrapper
           

               catch (signUpError){
               showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AdvanceCustomAlertNew(
                        icon: Icons.cancel_outlined,
                        msgContent: 'Email or password incorrect',
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


Widget buildForgetPass(BuildContext context)=> Container(
  
      child: Row(
       mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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



     
   


  
  
    final formKey = GlobalKey<FormState>();
  

   
 

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



    body: 
    
     Form(
      autovalidateMode: AutovalidateMode.always,
      key: formKey,
      child: ListView(
      padding: EdgeInsets.all(16),
      children: [
        buildLogo(),
        buildEmail(),
        const SizedBox(height: 20),
        buildPassword(),
        const SizedBox(height: 10),
        buildForgetPass(context),
        const SizedBox(height: 20),
        buildNext(),
        buildText(context),
        const SizedBox(height: 20),
        buildBackground(context)
        
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

Widget getStatus(BuildContext context) {
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("institution").doc(firebaseUser.uid).get().then((value){
      print(value.data()['status']);

      String status=value.data()['status'];
      bool pending =(status=='pending');

      if (status=='pending'){
        AuthService().signOut();
        showDialog(context: context, builder: (BuildContext context){
               return AdvanceCustomAlertNew(icon: Icons.lock_clock , 
               msgContent: 'Your account is pending, please wait for approval', btnContent: 'Ok');
    
                 }  );}             

                 if (status=='approved'){
                getName();
                getEmail();
                getPhone();
                getTwitter();
                getCategory();
                getAllCategory();

                 
                 //showTopSnackBar(context);





                var snack=SnackBar(
                  
                  
                  content:Container(child: Text('Welcome '+globals.userName),
                  height:20,
                 )
                  );
                //ScaffoldMessenger.of(context).showSnackBar(snack);
               
                 showTopSnackBar(context);
                // ScaffoldMessenger.of(context).showSnackBar(snack2);



                 setState()=> approved= true; mess="Welcome"; 




                 Navigator.pushAndRemoveUntil(
                   context, MaterialPageRoute(builder: (context) => Home()),
                   (route) => false);            

                 
                 }

                if (status=='disapproved'){
               AuthService().signOut();
               showDialog(context: context, builder: (BuildContext context){
               return AdvanceCustomAlertNew(icon: Icons.cancel_outlined , 
               msgContent: 'Your account has beed disapproved, please contact Sara@gmail.com for more information', btnContent: 'Ok');
    
    });
    

     }} );}

final firestoreInstance = FirebaseFirestore.instance;

 void getName(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;

    firestoreInstance.collection("institution").doc(firebaseUser.uid).get().then((value){
      String name =(value.data()['name']);
      //print (name);
      globals.userName=name;
      }) ;
      }


      void getPhone(){
   
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("institution").doc(firebaseUser.uid).get().then((value){
      String phone =(value.data()['phone']);
      globals.userPhone=phone;
      }) 
      ;}  


      void getTwitter(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("institution").doc(firebaseUser.uid).get().then((value){
      String twitter=(value.data()['twitterAccount']);
      globals.userTwitter=twitter;

      //return value.data()['twitterAccount'];
      }) 
      ;}  

      void getCategory(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("institution").doc(firebaseUser.uid).get().then((value){
      String categ=(value.data()['category']);
      globals.userCateg=categ;
      }) 
      ;} 

String getEmail(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;

    firestoreInstance.collection("institution").doc(firebaseUser.uid).get().then((value){
      String email =(value.data()['email']);
      globals.userEmail=email;
      }) 
      ;
      
      return globals.userEmail;

      } 

      void getAllCategory(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("categories").doc('L7mUO6CHjYAPI6rXG2Pz').get().then((value){
      print (value.data());
      }) 
      ;} 







final List<Flushbar> flushBars = [];


      void showTopSnackBar(BuildContext context) => show(
        context,
        Flushbar(
          icon: Icon(Icons.check_outlined, size: 32, color: Colors.white),
          shouldIconPulse: false,
          title: 'Welcome '+userName,
          message: 'Good to have you in Mostadeem', // change message
          duration: Duration(seconds: 4),
          borderRadius: BorderRadius.circular(6),
          flushbarPosition: FlushbarPosition.TOP,
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

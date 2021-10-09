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
            child: Text(
               "Sign Up" ,
              style: TextStyle(
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
                getStatus(context);
                 bool appr=approved;
                if(appr)
                 Navigator.of(context).push(
                 MaterialPageRoute(builder: (context)=>Home(),));

                 
                
                  
                 
                }// change to wrapper
           

               catch (signUpError){
               showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AdvanceCustomAlert(
                        icon: Icons.error,
                        msgTitle: 'INVALID',
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










Widget isPending(BuildContext context){
   
showDialog(context: context, builder: (BuildContext context){
               return AdvanceCustomAlert(icon: Icons.lock_clock, msgTitle: "Pending", 
               msgContent: "Your account is being revised, Please wait for approval", btnContent: 'Ok');
                 });   
                 }




void disapproved(){
  showDialog(context: context, builder: (BuildContext context){
               return AdvanceCustomAlert(icon: Icons.lock_clock, msgTitle: "Disapproved", 
               msgContent: "Account disapproved. Contact sara@gmail.com for more information", btnContent: 'Ok');
                 });   
                  }




     
   


  
  
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
        const SizedBox(height: 20),
        buildText(context),
        const SizedBox(height: 20),
        buildNext(),
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

Widget getStatus(BuildContext context){
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("institution").doc(firebaseUser.uid).get().then((value){
      print(value.data()['status']);

      String status=value.data()['status'];
      bool pending =(status=='pending');

      if (status=='pending'){
                var snack=SnackBar(content: Text('Account pending, please wait for approval'));
                ScaffoldMessenger.of(context).showSnackBar(snack);  }               

                 if (status=='approved'){
                var snack=SnackBar(content: Text('Hello'));
                ScaffoldMessenger.of(context).showSnackBar(snack);

                 setState()=> approved= true; mess="hello"; 
                 Navigator.of(context).push(
                 MaterialPageRoute(builder: (context)=>Home(),));
                 
                 }

                if (status=='disapproved'){
                var snack=SnackBar(content: Text('Account disapproved. Contact sara@gmail.com'));
                ScaffoldMessenger.of(context).showSnackBar(snack);

                 }
    
    });
    

  }

 

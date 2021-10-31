import 'dart:core';



//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inst_app/Screens/changePass.dart';
import 'package:inst_app/Screens/editProfile.dart';
import 'package:inst_app/Screens/home.dart';
import 'package:inst_app/Screens/authenticate/logIn.dart';
import 'package:inst_app/components/social_icon.dart';
import 'package:inst_app/services/auth.dart';
import 'package:inst_app/services/popUp.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:inst_app/services/globals.dart' as globals;



class profile extends StatefulWidget {
  const profile({ Key key }) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  String uid='';
   final AuthService _auth = AuthService();

  @override

  Widget build(BuildContext context) {
              getName();
              getEmail();
              getPhone();
              getTwitter();
              getCategory();
    
    return Scaffold(
      
    appBar: AppBar(
     centerTitle: true,

      title:  Text('Profile'),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20))),

  
  backgroundColor: Color.fromRGBO(48, 126, 80, 1),),
      
    body: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[

                  Container(
                       height: 245,
                       margin: EdgeInsets.only(top:20, bottom: 10, left: 20, right: 20),
                       alignment: Alignment.topCenter,
                       decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.all(Radius.circular(20)),
                       boxShadow: [
                       BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),)]

                    ),
                    
                    child:Stack(
                          children: <Widget>[
                           ListTile(

                           title: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                             Row (

                              children: <Widget>[
                               
                             Icon(Icons.person,
                             color: Color.fromRGBO(48, 126, 80, 1),),


                           Padding(
                           padding: EdgeInsets.fromLTRB(35, 15, 20, 20),
                           child: 
                           
                           Text(globals.userName,
                           style: TextStyle(fontSize: 20))),  

                             ]),




                             TextButton.icon(
                            icon: Icon(Icons.edit_outlined, color: Color.fromRGBO(48, 126, 80, 1), size: 28),
                            label: Text('Edit Profile', style: TextStyle( color: Color.fromRGBO(48, 126, 80, 1),)),
                            style:  ButtonStyle(
                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Color.fromRGBO(48, 126, 80, 1)),),),),
                            onPressed: () {Navigator.of(context).push(
                       MaterialPageRoute(builder: (context)=>editProfile(),));}
                            )





                           
                  
                                 ]
                                 
                                 
                                 )


                             
                                        
                    ),

                     Row (

                              children: <Widget>[
                               Padding(
                           padding: EdgeInsets.fromLTRB(15, 65, 20, 20),
                           child: 
                             Icon(Icons.mail,
                             color: Color.fromRGBO(48, 126, 80, 1),),),


                           Padding(
                           padding: EdgeInsets.fromLTRB(15, 65, 20, 20),
                           child: 
                           
                           Text(globals.userEmail,
                           style: TextStyle(fontSize: 20))), 
                           
                           
                            

                             ]),
                  Row (

                              children: <Widget>[
                               Padding(
                           padding: EdgeInsets.fromLTRB(15, 110, 20, 20),
                           child: 
                             Icon(Icons.phone,
                             color: Color.fromRGBO(48, 126, 80, 1),)),


                           Padding(
                           padding: EdgeInsets.fromLTRB(15, 105, 20, 20),
                           child: 
                           
                           Text(globals.userPhone,
                           style: TextStyle(fontSize: 20))),  

                             ]),



                     Row (

                              children: <Widget>[
                               Padding(
                           padding: EdgeInsets.fromLTRB(15, 155, 20, 20),
                           child: 
                           SocialIcon(
                           iconSrc: "assets/icons/twitter.svg",
                           color: Color.fromRGBO(48, 126, 80, 1),
                           ),),


                           Padding(
                           padding: EdgeInsets.fromLTRB(15, 155, 20, 20),
                           child: 
                           
                           Text(globals.userTwitter,
                           style: TextStyle(fontSize: 20))),  

                             ]),

                            Row (

                              children: <Widget>[
                               Padding(
                           padding: EdgeInsets.fromLTRB(15, 200, 20, 20),
                           child: 
                             Icon(Icons.category,
                             color: Color.fromRGBO(48, 126, 80, 1),),),


                           Padding(
                           padding: EdgeInsets.fromLTRB(15, 200, 20, 20),
                           child: 
                           
                           Text(globals.userCateg,
                           style: TextStyle(fontSize: 20))), 
                           
                           
                            

                             ]),



                            

                  



                            
                    
                    ]
                    
                    
                    )
                    
                    ), 
                    
                    
                    ]
                    ),

                    InkWell(
                      child: Container(
                        child: ListTile(
                           title: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: <Widget>[

                             Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 20, 20),
                                child: Icon(Icons.lock,
                               color: Colors.white,
                                size: 28,),
                             ),

                           Padding(
                           padding: EdgeInsets.fromLTRB(0, 15, 20, 15),
                           child: Text('Change Password',
                           style: TextStyle(fontSize: 22, color: Colors.white))),
                             ]
                           )                 
                           ),
                       
                       height: 60,
                       margin: EdgeInsets.only(top:15, bottom: 20, left: 20, right: 20),
                       alignment: Alignment.topCenter,
                       decoration: BoxDecoration(
                       color: Color.fromRGBO(48, 126, 80, 1),
                       borderRadius: BorderRadius.all(Radius.circular(20)),
                       boxShadow: [
                       BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),)]

                    ),
                      ),
                      onTap: (){Navigator.of(context).push(
                       MaterialPageRoute(builder: (context)=>changePass(),));},  //Reset Password
                    ),



                    InkWell(
                      child: Container(
                        child: ListTile(
                           title: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: <Widget>[

                             Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                                child: Icon(Icons.logout_outlined,
                               color: Colors.white,
                                size: 28,),
                             ),

                           Padding(
                           padding: EdgeInsets.fromLTRB(0, 10, 20, 20),
                           child: Text('Logout',
                           style: TextStyle(fontSize: 22, color: Colors.white))),
                             ]
                           )                 
                           ),
                       
                       height: 60,
                       margin: EdgeInsets.only(top:0, bottom: 30, left: 20, right: 20),
                       alignment: Alignment.topCenter,
                       decoration: BoxDecoration(
                       color: Color.fromRGBO(48, 126, 80, 1),
                       borderRadius: BorderRadius.all(Radius.circular(20)),
                       boxShadow: [
                       BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),)]

                    ),
                      ),
                      onTap: 
                      () async {
                     await AuthService().signOut();
                   Navigator.pushAndRemoveUntil(
                   context, MaterialPageRoute(builder: (context) => logIn()),
                   (route) => false);} //Logout
                    ),


                   InkWell(
                      child: Container(
                        child: ListTile(
                           title: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: <Widget>[

                             Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 20, 20),
                                child: Icon(Icons.delete_forever,
                               color: Colors.red.shade700,
                                size: 28,),
                             ),

                           Padding(
                           padding: EdgeInsets.fromLTRB(0, 10, 20, 20),
                           child: Text('Delete Account',
                           style: TextStyle(fontSize: 22,
                           color: Colors.red.shade700,
                          ))),
                             ]
                           )                 
                           ),
                       
                       height: 60,
                       margin: EdgeInsets.only(top:0, bottom: 30, left: 20, right: 20),
                       alignment: Alignment.topCenter,
                       decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.all(Radius.circular(20)),
                       boxShadow: [
                       BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),)]

                    ),
                      ),
                      onTap: (){},  //Delete account
                    ),


                    





                    ]),
                    ),
                    ),   
                    

                    



                    );
                    }
           
  

}

final firestoreInstance = FirebaseFirestore.instance;

String getName(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;

    firestoreInstance.collection("institution").doc(firebaseUser.uid).get().then((value){
      String name =(value.data()['name']);
      globals.userName=name;
      }) 
      ;
      
      return globals.userName;

      } 


String getEmail(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;

    firestoreInstance.collection("institution").doc(firebaseUser.uid).get().then((value){
      String email =(value.data()['email']);
      globals.userEmail=email;
      }) 
      ;
      
      return globals.userEmail;

      } 



 void getTwitter(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("institution").doc(firebaseUser.uid).get().then((value){
      String twitter=(value.data()['twitterAccount']);
      globals.userTwitter=twitter;

      //return value.data()['twitterAccount'];
      }) 
      ;}  

  void getPhone(){
   
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("institution").doc(firebaseUser.uid).get().then((value){
      String phone =(value.data()['phone']);
      globals.userPhone=phone;
      }) 
      ;}  

      void getCategory(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("institution").doc(firebaseUser.uid).get().then((value){
      String categ=(value.data()['category']);
      globals.userCateg=categ;
      }) ;
      
      if (globals.userCateg.contains('Paper'))
      isSelected[0]=true;
      else
      isSelected[0]=false;
      if (globals.userCateg.contains('Cardboard'))
      isSelected[1]=true;
      else
      isSelected[1]=false;
      if (globals.userCateg.contains('Glass'))
      isSelected[2]=true;
      else
      isSelected[2]=false;
      if (globals.userCateg.contains('Plastic'))
      isSelected[3]=true;
      else
      isSelected[3]=false;
      if (globals.userCateg.contains('Metals'))
      isSelected[4]=true;
      else
      isSelected[4]=false;
      if (globals.userCateg.contains('Electronics'))
      isSelected[5]=true;
      else
      isSelected[5]=false;
      if (globals.userCateg.contains('Nylon'))
      isSelected[6]=true;
      else
      isSelected[6]=false;
      if (globals.userCateg.contains('Cans'))
      isSelected[7]=true;
      else
      isSelected[7]=false;
      if (globals.userCateg.contains('Batteries'))
      isSelected[8]=true;
      else
      isSelected[8]=false;
      if (globals.userCateg.contains('Furniture'))
      isSelected[9]=true;
      else
      isSelected[9]=false;
      if (globals.userCateg.contains('Clothes'))
      isSelected[10]=true;
      else
      isSelected[10]=false;
      if (globals.userCateg.contains('Food'))
      isSelected[11]=true;
      else
      isSelected[11]=false;
      print (isSelected);
      

      ;} 


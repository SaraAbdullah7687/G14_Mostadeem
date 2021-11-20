import 'dart:core';



//import 'dart:js';
import 'package:another_flushbar/flushbar.dart';

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
                           
                           Text(getName(),
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
                       margin: EdgeInsets.only(top:0, bottom: 15, left: 20, right: 20),
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

                        showDialog(context: context, builder: (BuildContext context){

            
            return logOutCustomAlert(icon: Icons.logout_outlined, msgContent: 'Are you sure you want to log out\n', btn1Content: 'cancel', btn2Content: 'Log out');});
                     } //Logout
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
                       border: Border.all(color: Colors.red.shade700, width: 2),

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
                      onTap: ()async {



                        showDialog(context: context, builder: (BuildContext context){

            
            return deleteAlert(icon: Icons.delete_forever, msgContent: 'Are you sure you want to delete your account', btn1Content: 'cancel', btn2Content: 'Delete');});



                     

                   
                      
                      },  //Delete account
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

class logOutCustomAlert extends StatelessWidget  {

  IconData icon;
  String msgContent;
  String btn1Content;
  String btn2Content;




logOutCustomAlert({
    @required this.icon,
    @required this.msgContent,
    @required this.btn1Content,
    @required this.btn2Content,


  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                           color: Colors.transparent


                          ),
            height: 180,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  
                  Text(msgContent, style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
                  SizedBox(height: 14),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  SizedBox(
  width: 120.0,
  height: 40.0,
  child:
                  ElevatedButton(
                    
                    

                    

                    style: ButtonStyle(
                      
                      backgroundColor: MaterialStateProperty.all(Colors.orange[700]),


                      
                      

                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                            side: BorderSide(width: 0, color: Colors.transparent),

                        

                      ))
                    ),
                    
                    
                    
                    onPressed: () {
                    Navigator.of(context).pop();
                  },
                    child: Text(btn1Content, style: TextStyle(fontSize:17, color: Colors.white),),
                  ),),


                  SizedBox(
  width: 120.0,
  height: 40.0,
  child:
                  ElevatedButton(
                    
                    

                    

                    style: ButtonStyle(
                      
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(48, 126, 80, 1)),


                      
                      

                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                            side: BorderSide(width: 0, color: Colors.transparent),

                        

                      ))
                    ),
                    
                    
                    
                    onPressed: () async{
                                        try{

                                          await AuthService().signOut();
                   Navigator.pushAndRemoveUntil(
                   context, MaterialPageRoute(builder: (context) => logIn()),
                   (route) => false);

                   showTopSnackBar(context);

                                          


              

            



            



            





          } catch(e){
            print(e);
          }
                  },
                    child: Text(btn2Content, style: TextStyle(fontSize:15, color: Colors.white),),
                  ),),

                ])
                ],
              ),
            ),
          ),
          Positioned(
            top: -60,
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(48, 126, 80, 1),
              radius: 60,
              child: Icon(icon, color: Colors.white, size: 50,),
            )
          ),
        ],
      )
    );
  }
}




final List<Flushbar> flushBars = [];


      void showTopSnackBar(BuildContext context) => show(
        context,
        Flushbar(
          icon: Icon(Icons.check_outlined, size: 32, color: Colors.white),
          shouldIconPulse: false,
          title: 'Logged out',
          message: 'You have been logged out successfully', // change message
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




  class deleteAlert extends StatelessWidget  {

  IconData icon;
  String msgContent;
  String btn1Content;
  String btn2Content;




deleteAlert({
    @required this.icon,
    @required this.msgContent,
    @required this.btn1Content,
    @required this.btn2Content,


  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                           color: Colors.transparent


                          ),
            height: 180,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  
                  Text(msgContent, style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
                  SizedBox(height: 14),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  SizedBox(
  width: 120.0,
  height: 40.0,
  child:
                  ElevatedButton(
                    
                    

                    

                    style: ButtonStyle(
                      
                      backgroundColor: MaterialStateProperty.all(Colors.grey),


                      
                      

                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                            side: BorderSide(width: 0, color: Colors.transparent),

                        

                      ))
                    ),
                    
                    
                    
                    onPressed: () {
                    Navigator.of(context).pop();
                  },
                    child: Text(btn1Content, style: TextStyle(fontSize:17, color: Colors.white),),
                  ),),


                  SizedBox(
  width: 120.0,
  height: 40.0,
  child:
                  ElevatedButton(
                    
                    

                    

                    style: ButtonStyle(
                      
                      backgroundColor: MaterialStateProperty.all(Colors.red.shade700),


                      
                      

                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                            side: BorderSide(width: 0, color: Colors.transparent),

                        

                      ))
                    ),
                    
                    
                    
                    onPressed: () async{

                      
                                      try{
 

        FirebaseFirestore.instance
        .collection('institution')
        .doc(FirebaseAuth.instance.currentUser.uid) 
        .collection('appointment')
        .where(('status'), isEqualTo: ('accepted'))
        .get()
        .then((snapshot) {

      if (snapshot.docs.isNotEmpty) {

        print('there are documents found');


                                      Navigator.of(context).pop();

                                      cannotDeleteBar(context);

        }

                                    else if (snapshot.docs.isEmpty) {
                                      FirebaseFirestore.instance.collection('institution').doc(FirebaseAuth.instance.currentUser.uid).get().then((doc) {
                                         if (doc.exists) {
                                           
                                    doc.reference.delete();
                                     AuthService().deleteUser();

                                          

                     Navigator.pushAndRemoveUntil(
                   context, MaterialPageRoute(builder: (context) => logIn()),
                   (route) => false);
                      deleteBar(context);

                                    }});

                                      
                                    }

        }











                              
                            





                                          


                                    
                        );

                                          




                                          


              

            



            


                                      }
            




                    
           catch(e){
            print(e);
          }
                  },
                    child: Text(btn2Content, style: TextStyle(fontSize:15, color: Colors.white),),
                  ),),

                ])
                ],
              ),
            ),
          ),
          Positioned(
            top: -60,
            child: CircleAvatar(
              backgroundColor: Colors.red.shade700,
              radius: 60,
              child: Icon(icon, color: Colors.white, size: 50,),
            )
          ),
        ],
      )
    );
  }
}



void deleteBar(BuildContext context) => show(
        context,
        Flushbar(
          icon: Icon(Icons.delete_forever, size: 32, color: Colors.red.shade700),
          shouldIconPulse: false,
          title: 'Deleted',
          message: 'Your Account has been deleted successfully', // change message
          duration: Duration(seconds: 4),
          borderRadius: BorderRadius.circular(6),
          flushbarPosition: FlushbarPosition.TOP,
           barBlur: 20,
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
      );

void cannotDeleteBar(BuildContext context) => show(
        context,
        Flushbar(
          icon: Icon(Icons.cancel_outlined, size: 32, color: Colors.red.shade700),
          shouldIconPulse: false,
          title: 'Finish your requests first',
          message: 'You cannot delete your account when you have unfinished requests', // change message
          duration: Duration(seconds: 4),
          borderRadius: BorderRadius.circular(6),
          flushbarPosition: FlushbarPosition.TOP,
           barBlur: 20,
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
      );


          

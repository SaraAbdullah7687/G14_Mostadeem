import 'dart:core';



//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inst_app/Screens/home.dart';
import 'package:inst_app/Screens/authenticate/logIn.dart';
import 'package:inst_app/Screens/profile.dart';
import 'package:inst_app/components/advancedAlertNew.dart';
import 'package:inst_app/components/social_icon.dart';
//import 'package:inst_app/institution/start.dart';
import 'package:inst_app/services/auth.dart';
import 'package:inst_app/services/popUp.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:inst_app/services/globals.dart' as globals;










class editProfile extends StatefulWidget {

  

  @override
  _editProfile createState() => _editProfile();

}

class _editProfile extends State<editProfile> {

 final AuthService _auth = AuthService();



  TextEditingController _controller = TextEditingController();
  TextEditingController _emailController = TextEditingController(); //add it in rounded input class
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _twitterController = TextEditingController();
  TextEditingController _nameController = TextEditingController();


  String message='';

static final RegExp nameRegExp = RegExp('[a-zA-Z]'); 

// Name .....................................

  Widget buildName(){
    String un=getName();

      //print (name);
     return TextFormField(


   initialValue: globals.userName,

  cursorColor: Color.fromRGBO(48, 126, 80, 1),
   maxLength: 15,
    validator: (value) => value.isEmpty 
    ? 'Required'
    : (nameRegExp.hasMatch(value) 
        ? null 
        : 'Enter a Valid Name'),

  
      decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
        prefixIcon: Padding(
         padding: EdgeInsets.all(0.0),
         child: Icon(
          Icons.person,
           color: Color.fromRGBO(48, 126, 80, 1)),
            ), 

        labelText: 'Name',

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
      
      onChanged: (value) => setState(() => name = value),
    );}



// Email .....................................

Widget buildEmail() => TextFormField(
     initialValue: globals.userEmail,

     
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

      onChanged: (value) => setState(() => email = value),
      validator: MultiValidator([
  RequiredValidator(errorText: "Required"),
  EmailValidator(errorText: "Enter a valid email"),
])
    );





   




   




// Phone  .....................................


  Widget buildPhone() => TextFormField(
    initialValue: globals.userPhone,
     cursorColor: Color.fromRGBO(48, 126, 80, 1),
    maxLength:10,
    decoration: InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 15),    
        prefixIcon: Padding(
         padding: EdgeInsets.all(0.0),
         child: Icon(
          Icons.phone,
           color: Color.fromRGBO(48, 126, 80, 1)),
            ), 
        labelText: 'Phone',
        hintText:'05xxxxxxxx',
        
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

      onChanged: (value) => setState(() => phone = value),
      keyboardType: TextInputType.number,
      validator: (value){

     if(value==null){
      return 'Required';
    } 
    String pattern =
       "(05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Invalid phone number';
   
     else return null;
  }


  );

    




// Twitter .....................................

     Widget buildSocialM() => TextFormField(
    initialValue: globals.userTwitter ,    
      cursorColor: Color.fromRGBO(48, 126, 80, 1),
  
      decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
        prefixIcon: Padding(
         padding: EdgeInsets.all(12.0),
         child: SocialIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  color: Color.fromRGBO(48, 126, 80, 1),
                ),
            ), 
        labelText: 'Twitter Account',
        hintText: "@XXXX",
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
      onChanged: (value) => setState(() => twitter = value),
        validator: (value) {
    if(value==null){
      return 'Required';
    } 
    String pattern =
       "@[A-Za-z0-9_]{1,15}";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Invalid Twitter Account';
        }
    );




     





// Title .....................................

    Widget buildTitle() => Container(
       
       child: Text(
            'Accepted Categories\n', 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
    );




// Categories .....................................

Container buildAllCategories(){

   return Container (child: DemoToggleButtons());
}
    




    

  
 


 


// Category message .....................................

 Widget categValid() => SizedBox(
       height: 17,
       child: Text(

        message, style: TextStyle (color: Colors.red, fontSize: 14 )
       )
       
    );


  
  
    final formKey = GlobalKey<FormState>();
  

    String name = globals.userName;
    String twitter = globals.userTwitter;
    String phone=globals.userPhone;

  @override
  Widget build(BuildContext context) { 
      getCategory();
return Scaffold(
     backgroundColor: Colors.white, 
     appBar: AppBar(
     centerTitle: true,
      title:  Text('Edit Profile'),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
     bottom: Radius.circular(20))),

  leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: (){
      Navigator.pop(context);
        
    },),

  backgroundColor: Color.fromRGBO(48, 126, 80, 1),
  ),



    body: Form(
      autovalidateMode: AutovalidateMode.always,
      key: formKey,
      child: ListView(
      padding: EdgeInsets.all(16),
      children: [
        
        buildName(),
        const SizedBox(height: 16),
        buildEmail(),
        const SizedBox(height: 16),
        buildPhone(),
        const SizedBox(height: 16),
        buildSocialM(),
        const SizedBox(height: 16),
        buildTitle(),
        categValid(),
        const SizedBox(height: 12),
        buildAllCategories(),
        ListTile(

          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
            
            ElevatedButton(
      
           child: Text('Cancel',
          style: TextStyle(fontSize: 20, color: Colors.grey[100])
          ),
          onPressed: () {Navigator.of(context).pop(
              MaterialPageRoute(builder: (context)=>Home(),));},
            style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            primary: Colors.grey,
            shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
            
            ),
          
           
            
  
            ),
                  ),
                  ElevatedButton(
      
           child: Text('Save',
          style: TextStyle(fontSize: 20, color: Colors.white)
          ),
          onPressed: () async{
         
         bool check=hasSelected();

          var firebaseUser =  FirebaseAuth.instance.currentUser;
          


          if(formKey.currentState.validate())
          if(hasSelected())

          {
            if (firebaseUser.email==email.trim()){
            print('emails the same has been checked');
           

            

              try{
              FirebaseFirestore.instance.collection('institution').doc(FirebaseAuth.instance.currentUser.uid).update({'name': name,'phone': phone, 'twitterAccount':twitter, 'category':categ});
              print ('update should be okay');
              getName();
              getEmail();
              getPhone();
              getTwitter();
              getCategory();
              Navigator.pushAndRemoveUntil(
                   context, MaterialPageRoute(builder: (context) => Home()),
                   (route) => false); 
              showDialog(context: context, builder: (BuildContext context){
               return AdvanceCustomAlertNew(icon: Icons.check, 
               msgContent: 'Your profile has been updated successfuly', btnContent: 'Ok');
               
              }
              );
              }   
              
               catch (e){
               Navigator.of(context).pop(
              MaterialPageRoute(builder: (context)=>Home(),));

               Navigator.pop(context);
               showDialog(context: context, builder: (BuildContext context){
               return AdvanceCustomAlertNew(icon: Icons.cancel, 
               msgContent: 'An error occured while updating your profile, please try again later', btnContent: 'Ok');
 


              
            



               
               }
               
               
               
               
               );}

               

              
                            
                        
               }


               if (firebaseUser.email!=email.trim()){
                print('emails are not the same');

            





          


           

            


              
              updateEmail(context);



              

               

              
                            
                        
               }
              
              


              

               

              
                            
                        
                }
               

               
                  else
              {
              setState(() => message = 'Please Select at least one category');     
                    return;}
            
          
          },
            style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            primary: Color.fromRGBO(48, 126, 80, 1),
            shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
            
            ),
          
           
            
  
            ),
          
                  ),
          
             ],
          ),
        )

      ],
      ),
    ),
      );}
    


    

  }


@override
Widget build(BuildContext context){
getCategory();
Size size=MediaQuery.of(context).size;
return GestureDetector(
  onTap: ()=> FocusManager.instance.primaryFocus.unfocus(),
  child: Scaffold());


}
    
final firestoreInstance = FirebaseFirestore.instance;





List<bool> isSelected = [false, false, false, false, false, false,false, false, false, false, false, false]; 
String categ ='';
List<String> categories = ['Paper', 'Cardboard', 'Glass', 'Plastic', 'Metals', 'Electronics','Nylon', 'Cans', 'Batteries', 'Furniture', 'Clothes', 'Food']; // retrirve from database

  

class DemoToggleButtons extends StatefulWidget {
  
  @override
  _DemoToggleButtonsState createState() => _DemoToggleButtonsState();
}

class _DemoToggleButtonsState extends State<DemoToggleButtons> {
  //set the initial state of each button whether it is selected or not

  @override
  Widget build(BuildContext context) {



    //wrap the GridView wiget in an Ink wiget and set the width and height, 
    //otherwise the GridView widget will fill up all the space of its parent widget
    return  Container(
      height: 275,
      width: double.infinity,
      child: Ink(
      width: 380,
      height: 60, 
      color: Colors.white,
      child: GridView.count(
        primary: true,
        padding: const EdgeInsets.only(left: 10, right: 10),
        
        crossAxisCount: 4, //set the number of buttons in a row
        crossAxisSpacing: 10, //set the spacing between the buttons
        mainAxisSpacing: 8, 
        childAspectRatio: 1, //set the width-to-height ratio of the button, 
                             //>1 is a horizontal rectangle
        children: List.generate(isSelected.length, (index) {
          //using Inkwell widget to create a button
          return InkWell( 
              splashColor: Colors.grey, //the default splashColor is grey
              onTap: () {
                //set the toggle logic
                setState(() { 
                  for (int indexBtn = 0;
                      indexBtn < isSelected.length;
                      indexBtn++) {
                    if (indexBtn == index) {
                       isSelected[index]=!isSelected[index];

                  }
                }});
              },
              child: Ink(
                decoration: BoxDecoration(
               //set the background color of the button when it is selected/ not selected
                  color: isSelected[index] ? Color.fromRGBO(48, 126, 80, 0.7) : Colors.white, 
                  // here is where we set the rounded corner
                  borderRadius: BorderRadius.circular(8), 
                  //don't forget to set the border, 
                  //otherwise there will be no rounded corner
                  border: Border.all(color: Colors.grey), 
                ),
                child:  Image.asset("assets/images/"+categories[index]+'.png')
                    //set the color of the icon when it is selected/ not selected
                    
              ));
        }),
      ),
      
    )
    
    );
  
    
  }}




  bool hasSelected(){

  bool check=false;

 for (int i=0; i<isSelected.length; i++){
   check = check||isSelected[i];
 }
 if (check){
 print ('has selected');

 int selectedItems = 0; 
 categ ='';





 for (int i=0; i<isSelected.length; i++){
    if (isSelected[i]==true)
    categ+=categories[i]+', ';
 }
 categ = categ.substring(0,categ.length-2); // To remove the last comma
 print (categ); // Just to check
 }

 else
 print ('did not select');


  return check;
}




 String getName(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;

    firestoreInstance.collection("institution").doc(firebaseUser.uid).get().then((value){
      String name =(value.data()['name']);
      globals.userName=name;
      }) 
      ;
      
      return globals.userName;

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

      String getEmail(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;

    firestoreInstance.collection("institution").doc(firebaseUser.uid).get().then((value){
      String email =(value.data()['email']);
      globals.userEmail=email;
      }) 
      ;
      
      return globals.userEmail;

      } 


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

void updateEmail(BuildContext context)async {



  
            var firebaseUser =  FirebaseAuth.instance.currentUser;

String name = globals.userName;
    String twitter = globals.userTwitter;
    String phone=globals.userPhone;

  try{
                
           await firebaseUser.updateEmail(email);


           try{
              FirebaseFirestore.instance.collection('institution').doc(FirebaseAuth.instance.currentUser.uid).update({'name': name,'phone': phone, 'twitterAccount':twitter, 'category':categ, 'email':email});
              print ('update should be okay');
              getName();
              getEmail();
              getPhone();
              getTwitter();
              getCategory();
              Navigator.pushAndRemoveUntil(
                   context, MaterialPageRoute(builder: (context) => Home()),
                   (route) => false); 
              showDialog(context: context, builder: (BuildContext context){
               return AdvanceCustomAlertNew(icon: Icons.check, 
               msgContent: 'Your profile has been updated successfuly', btnContent: 'Ok');
               
              }
              );
              }   
              
               catch (e){
               Navigator.of(context).pop(
              MaterialPageRoute(builder: (context)=>Home(),));

               Navigator.pop(context);
               showDialog(context: context, builder: (BuildContext context){
               return AdvanceCustomAlertNew(icon: Icons.cancel,
               msgContent: 'An error occured while updating your profile, please try again later', btnContent: 'Ok');
 


              
            



               
               }
               
               
               
               
               );}
           

            }
              catch (e) {
                print('down');
              showDialog(context: context, builder: (BuildContext context){
               return AdvanceCustomAlertNew(icon: Icons.cancel, 
               msgContent: 'The entered email is already in use\n', btnContent: 'Ok');
               
              }
              ); 
}




}
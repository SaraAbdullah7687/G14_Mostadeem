import 'dart:core';



//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inst_registration/Screens/home.dart';
import 'package:inst_registration/Screens/logIn.dart';
import 'package:inst_registration/services/auth.dart';
import 'package:inst_registration/services/popUp.dart';
import 'package:inst_registration/toOTP.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';









class regScreen extends StatefulWidget {
  

  @override
  _regScreenState createState() => _regScreenState();
}

class _regScreenState extends State<regScreen> {

 final AuthService _auth = AuthService();



var isSelected = [false,false,false,false,false,false,false,false,false,false,false,false]; 
  TextEditingController _controller = TextEditingController();
  TextEditingController _emailController = TextEditingController(); //add it in rounded input class
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _twitterController = TextEditingController();
  TextEditingController _nameController = TextEditingController();


  String message='';




// Name .....................................

  Widget buildName() => TextFormField(
  cursorColor: Color.fromRGBO(48, 126, 80, 1),
   maxLength: 15,
    controller: _nameController,
    validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  },
      decoration: InputDecoration(
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
    );



// Email .....................................


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
       controller: _emailController, 

      onChanged: (value) => setState(() => email = value),
      validator: MultiValidator([
  RequiredValidator(errorText: "Required"),
  EmailValidator(errorText: "Enter a valid email"),
])
    );





// Password .....................................


    bool _isHidden = true;

  Widget buildPassword() => Column(
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
      controller: _passwordController,
      onChanged: (value) => setState(() => password = value),
      obscureText: _isHidden,
    )),
    
    new FlutterPwValidator(
    controller: _passwordController,
    minLength: 8,
    uppercaseCharCount: 1,
    numericCharCount: 1,
    specialCharCount: 1,
    width: 400,
    height: 150,
    onSuccess: (){},/// do something
)

    ]);
    
void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });}




// Phone  .....................................


  Widget buildPhone() => TextFormField(
     cursorColor: Color.fromRGBO(48, 126, 80, 1),
    maxLength:10,
    decoration: InputDecoration(
        
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
       controller: _phoneController, 

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
    else if(value.length <10 || value.length>10)
    return 'Invalid phone number';
     else return null;
  }


  );

    




// Twitter .....................................

     Widget buildSocialM() => TextFormField(
       controller: _twitterController,
     
      cursorColor: Color.fromRGBO(48, 126, 80, 1),
  
      decoration: InputDecoration(
        prefixIcon: Padding(
         padding: EdgeInsets.all(0.0),
         child: Icon(
          Icons.link,
           color: Color.fromRGBO(48, 126, 80, 1)),
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









// CR .....................................


    Widget buildCR() => TextFormField(
  cursorColor: Color.fromRGBO(48, 126, 80, 1),

      maxLength: 10,
      
       keyboardType: TextInputType.number,controller: _controller,
      validator: (value) {

      if (value == null || value.isEmpty) {

      return 'Required';
    }
     else if (value.length<10)
    return 'Commercial record length should be 10';
    else return null;
  },
      decoration: InputDecoration(
        prefixIcon: Padding(
         padding: EdgeInsets.all(0.0),
         child: Icon(
          Icons.verified,
           color: Color.fromRGBO(48, 126, 80, 1)),
            ), 
        labelText: 'Commercial Record',
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
      onChanged: (value) => setState(() => cr = value),
      
    );







// Titlw .....................................

    Widget buildTitle() => Container(
       
       child: Text(
            'Accepted Categories\n', 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
    );




// Categories .....................................

Container buildAllCategories(){

   return Container (child: DemoToggleButtons());
}
    




    

     




  
// Button .....................................

    Widget buildNext(BuildContext context) => ElevatedButton(
      
           child: Text('Sign Up',
          style: TextStyle(fontSize: 20, color: Colors.white)
          ),
          onPressed: () async{
         String Email = _emailController.text.trim();
         String Pass = _passwordController.text.trim();
         
         bool check=hasSelected();

         final snackBar=SnackBar(content: Text('You already registered, please log in'));



          if(formKey.currentState!.validate())
          if(hasSelected())

          {
              try{
              dynamic result=  await _auth.registerInstitution(Email, Pass, phone, name, twitter, cr, categ );
              Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>Home(),));}    //change to wrapper
              
               catch (signUpError){
               if(signUpError is PlatformException) 
               if(signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE')

               Navigator.of(context).pop(
              MaterialPageRoute(builder: (context)=>logIn(),));

               Navigator.pop(context);
               showDialog(context: context, builder: (BuildContext context){
               return AdvanceCustomAlert(icon: Icons.check, msgTitle: 'Please log in', 
               msgContent: 'You have already registered', btnContent: 'Ok');
 


              
            



               }
               
               
               
               
               
               );

              
                            
                        
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
          
                  );


 


// Category message .....................................

 Widget categValid() => SizedBox(
       height: 17,
       child: Text(

        message, style: TextStyle (color: Colors.red, fontSize: 14 )
       )
    );


  
  
    final formKey = GlobalKey<FormState>();
  

    String name = '';
    String email = '';
    String password = '';
    String twitter = '';
    String cr = '';
    String phone='phone';

  @override
  Widget build(BuildContext context) => Scaffold(
     backgroundColor: Colors.white, 
     appBar: AppBar(
     centerTitle: true,
      title:  Text('Institution Registration'),
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
        const SizedBox(height: 32),
        buildPhone(),
        const SizedBox(height: 32),
        buildSocialM(),
        const SizedBox(height: 32),
        buildCR(),
        const SizedBox(height: 32),
        buildPassword(),
        const SizedBox(height: 32),
        buildTitle(),
        categValid(),
        buildAllCategories(),
        buildNext(context),
      ],
      ),
    ),
      );
    


    

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
  List<IconData> iconList = [Icons.ac_unit, Icons.call, Icons.cake, Icons.mic_external_off, Icons.cake, Icons.dangerous, Icons.safety_divider,Icons.ac_unit,Icons.qr_code,Icons.face,Icons.e_mobiledata,Icons.h_mobiledata];

  @override
  Widget build(BuildContext context) {





    //wrap the GridView wiget in an Ink wiget and set the width and height, 
    //otherwise the GridView widget will fill up all the space of its parent widget
    return  Container(
      height: 300,
      width: double.infinity,
      child: Ink(
      width: 380,
      height: 60, 
      color: Colors.white,
      child: GridView.count(
        primary: true,
        padding: const EdgeInsets.all(20),
        
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




 

import 'dart:core';



//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inst_registration/home.dart';
import 'package:inst_registration/services/auth.dart';
import 'package:inst_registration/services/popUp.dart';
import 'package:inst_registration/toOTP.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:encrypt/encrypt.dart';







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
  


    Color _color = Colors.white;





  Widget buildName() => TextFormField(
    validator: (value) {
    if (value == null || value.isEmpty) {
      return 'required';
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
        border: OutlineInputBorder(
       borderRadius: BorderRadius.circular(15.0),

        ),
      ),
      onChanged: (value) => setState(() => name = value),
    );





    Widget buildEmail() => TextFormField(
     

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
      validator: (value) {
    if (value == null || value.isEmpty) {
      return 'required';
    }
    return null;
  },
      decoration: InputDecoration(
        suffix: InkWell(
         onTap: _togglePasswordView,
        child: Icon(Icons.visibility),),
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
      ),
      controller: _passwordController,
      onChanged: (value) => setState(() => password = value),
      obscureText: true,
    );
    
void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });}

  /*  FlutterPwValidator({
    controller: _passwordController,
    minLength: 6,
    uppercaseCharCount: 2,
    numericCharCount: 3,
    specialCharCount: 1,
    width: 400,
    height: 150,
    onSuccess: buildPassword()}
)*/





     Widget buildSocialM() => TextFormField(
       validator: (value) {
    if (value == null || value.isEmpty) {
      return 'required';
    }
    return null;
  },
  
      decoration: InputDecoration(
        prefixIcon: Padding(
         padding: EdgeInsets.all(0.0),
         child: Icon(
          Icons.link,
           color: Color.fromRGBO(48, 126, 80, 1)),
            ), 
        labelText: 'Twitter Account',
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),

        ),
      ),
      onChanged: (value) => setState(() => twitter = value),
      
    );











    Widget buildCR() => TextFormField(

      maxLength: 10,
      
       keyboardType: TextInputType.number,controller: _controller,
      validator: (value) {

      if (value == null || value.isEmpty) {

      return 'required';
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
        border: OutlineInputBorder(
       borderRadius: BorderRadius.circular(15.0),

        ),
      ),
      onChanged: (value) => setState(() => cr = value),
      
    );








    Widget buildTitle() => Container(
       
       child: Text(
            'Accepted Categories\n', 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
    );





Container buildAllCategories(){

   return Container (child: DemoToggleButtons());
}
    




    

     




  

    Widget buildNext() => ElevatedButton(
           child: Text('Next',
          style: TextStyle(fontSize: 20, color: Colors.white)
          ),
          onPressed: () async{
         String Email = _emailController.text.trim();
         String Pass = _passwordController.text.trim();
         
         bool check=hasSelected();

          if (!check){


            showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AdvanceCustomAlert(
                              icon: Icons.error,
                              msgTitle: 'Error',
                              msgContent: 'Please select at least 1 category.',
                              btnContent: 'Ok',
                            );
                          });

          }
          
          if(formKey.currentState!.validate())
          {
          dynamic result=  await _auth.registerInstitution(Email, Pass, phone, name, twitter, cr, categ );
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>Home(),));}
          else
          return;
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
            primary: Color.fromRGBO(48, 126, 80, 1),
            shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
            
            ),
  
       ));







 




  
    Widget buildSpace() => Container(
       
       child: Text(
            '\n', )
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
      title:  Text('Institution Registration'),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20))),

  leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.black),
    onPressed: (){},),

  backgroundColor: Color.fromRGBO(48, 126, 80, 1),
  ),



    body: Form(
      autovalidate: true,
      key: formKey,
      child: ListView(
      padding: EdgeInsets.all(16),
      children: [
        
        buildName(),
        const SizedBox(height: 16),
        buildEmail(),
        const SizedBox(height: 32),
        buildPassword(),
        const SizedBox(height: 32),
        buildSocialM(),
        const SizedBox(height: 32),
        buildCR(),
        const SizedBox(height: 32),
        buildTitle(),
        buildAllCategories(),
        buildNext(),
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




 

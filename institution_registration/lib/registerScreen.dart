import 'dart:core';
//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:inst_registration/services/auth.dart';
import 'package:inst_registration/toOTP.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';





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
      onChanged: (value) => setState(() => socialM = value),
      
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
      onChanged: (value) => setState(() => CR = value),
      
    );








    Widget buildTitle() => Container(
       
       child: Text(
            'Accepted Categories\n', 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
    );


Column buildAllCategories(){
  return Column(
    children:[ 
      Row (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
      buildSingleCateg('assets/images/grey_paper.png', 'Paper',0),
      buildSingleCateg('assets/images/grey_cardboard.png', 'Cardboard',1),
      buildSingleCateg('assets/images/grey_glass.png', 'Glass',2),
      buildSingleCateg('assets/images/grey_plastic.png', 'Plastic',3),


    ],),
    SizedBox(height: 20),
    Row (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
        buildSingleCateg('assets/images/grey_metal.png', 'Metals',4),
      buildSingleCateg('assets/images/grey_electronic.png', 'Electronics',5),
      buildSingleCateg('assets/images/grey_nylon.png', 'Nylon',6),
      buildSingleCateg('assets/images/grey_can.png', 'Cans',7),

    ],),
     SizedBox(height: 20),
    Row (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
     
      buildSingleCateg('assets/images/grey_battery.png', 'Batteries',8),
      buildSingleCateg('assets/images/grey_sofa.png', 'Furniture',9),
      buildSingleCateg('assets/images/grey_clothes.png', 'Clothes',10),
      buildSingleCateg('assets/images/grey_pizza.png', 'Food',11),

    ],),
   
    ]);
}
    




    

     Container buildSingleCateg(String IconName, String category, int index) {
       return Container(
         child: Column(
          
           children:[
             InkWell(
             child: Container(
                

               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
               decoration: BoxDecoration(
               border: Border.all(color: Colors.grey),
               
               borderRadius: BorderRadius.circular(10),
               ),
               child: Image.asset(IconName, width: 60,)
             ),onTap: () {
               print('s');
               _color=Colors.red; 
               })

             ]
         )
       );
       
     }





  

    Widget buildNext() => ElevatedButton(
           child: Text('Next',
          style: TextStyle(fontSize: 20, color: Colors.white)
          ),
          onPressed: () async{
         String Email = _emailController.text.trim();
         String Pass = _passwordController.text.trim();


          if(formKey.currentState!.validate()){
          dynamic result=  await _auth.createUserWithEmailAndPassword(Email, Pass);}
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
    String socialM = '';
    String CR = '';

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
        buildSpace(),
        buildNext(),
      ],
      ),
    ),
      );
    


    

  }



    
  

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:inst_registration/CheckBoxState.dart';


class regScreen extends StatefulWidget {
  const regScreen({ Key? key }) : super(key: key);

  @override
  _regScreenState createState() => _regScreenState();
}

class _regScreenState extends State<regScreen> {
  
  bool value = false;

  final notifications =[
    CheckBoxState(title: 'Plastic'),
    CheckBoxState(title: 'Paper'),
    CheckBoxState(title: 'Furniture'),
  ];

  
  
    final formKey = GlobalKey<FormState>();
  

    String name = '';
    String email = '';
    String password = '';
    String socialM = '';
    String CR = '';

  @override
  Widget build(BuildContext context) =>Scaffold(

     

    body: Form(
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
        buildSingleCateg(),
        buildSingleCateg(),
        buildSingleCateg(),
        buildSingleCateg(),
        buildNext(),
      ],
      ),
    ),
    );
    Widget buildName() => TextFormField(
      decoration: InputDecoration(
        prefixIcon: Padding(
         padding: EdgeInsets.all(0.0),
         child: Icon(
          Icons.person,
           color: Color.fromRGBO(83, 122, 88, 1)),
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
           color: Color.fromRGBO(83, 122, 88, 1)),
            ), 
        labelText: 'Email',
        
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),

        ),
      ),
      onChanged: (value) => setState(() => email = value),
    );

  
  Widget buildPassword() => TextFormField(
      decoration: InputDecoration(
        prefixIcon: Padding(
         padding: EdgeInsets.all(0.0),
         child: Icon(
          Icons.lock,
           color: Color.fromRGBO(83, 122, 88, 1)),
            ), 
        labelText: 'Password',
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),

        ),
      ),
      onChanged: (value) => setState(() => password = value),
      obscureText: true,
    );

     Widget buildSocialM() => TextFormField(
      decoration: InputDecoration(
        prefixIcon: Padding(
         padding: EdgeInsets.all(0.0),
         child: Icon(
          Icons.link,
           color: Color.fromRGBO(83, 122, 88, 1)),
            ), 
        labelText: 'Social media profile link',
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),

        ),
      ),
      onChanged: (value) => setState(() => socialM = value),
    );
    Widget buildCR() => TextFormField(
      decoration: InputDecoration(
        prefixIcon: Padding(
         padding: EdgeInsets.all(0.0),
         child: Icon(
          Icons.verified,
           color: Color.fromRGBO(83, 122, 88, 1)),
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
            'Accepted Categories', 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
    );

  Widget buildSingleCateg() => CheckboxListTile(
    controlAffinity: ListTileControlAffinity.leading ,
    activeColor: Color.fromRGBO(83, 122, 88, 1),
    title: Text('Plastic', style: TextStyle(fontSize: 20),),

    value: value, 
    onChanged: (value) => setState (() => this.value = value!),



    Widget buildNext() => ElevatedButton(
         child: Text('Next',
          style: TextStyle(fontSize: 20)
          ),
          onPressed: () {
            //final isValid = formKey.currentState.validate();
     
          },
           
            style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(83, 122, 88, 1),
            shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
            
            ),
          ));


    

  }



    
  

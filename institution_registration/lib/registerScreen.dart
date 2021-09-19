import 'dart:core';
import 'package:flutter/material.dart';


class regScreen extends StatefulWidget {
  const regScreen({ Key? key }) : super(key: key);

  @override
  _regScreenState createState() => _regScreenState();
}

class _regScreenState extends State<regScreen> {
  
  
  
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
        buildNext(),
      ],
      ),
    ),
    );
    Widget buildName() => TextFormField(
      decoration: InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => setState(() => name = value),
    );

    Widget buildEmail() => TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => setState(() => email = value),
    );

  
  Widget buildPassword() => TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => setState(() => password = value),
    );

     Widget buildSocialM() => TextFormField(
      decoration: InputDecoration(
        labelText: 'Social media profile link',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => setState(() => socialM = value),
    );
    Widget buildCR() => TextFormField(
      decoration: InputDecoration(
        labelText: 'Commercial Record',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => setState(() => CR = value),
    );
    // ignore: deprecated_member_use
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



    
  

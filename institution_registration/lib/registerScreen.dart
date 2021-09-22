import 'dart:core';
import 'package:flutter/material.dart';
import 'package:inst_registration/CheckBoxState.dart';


class regScreen extends StatefulWidget {
  const regScreen({ Key? key }) : super(key: key);

  @override
  _regScreenState createState() => _regScreenState();
}

class _regScreenState extends State<regScreen> {
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
            'Accepted Categories\n', 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
    );

  Widget buildSingleCateg(CheckBoxState Checkbox) => CheckboxListTile(
    controlAffinity: ListTileControlAffinity.leading ,
    activeColor: Color.fromRGBO(83, 122, 88, 1),
    title: Text(Checkbox.title, style: TextStyle(fontSize: 20),),

    value: Checkbox.value, 
    onChanged: (value) => setState (() => Checkbox.value = value!),

  );

    Widget buildNext() => ElevatedButton(
         child: Text('Next',
          style: TextStyle(fontSize: 20, color: Colors.white)
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
  Widget buildStartTime() {
String startTime = '8:00 AM';
  Future<void> _openTimePicker(BuildContext context) async {
    
    final TimeOfDay? startingTime = 
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if(startingTime != null){

      setState(() {
        startTime = startingTime.format(context);
      });
    }
  }

return Container(
  
  child: RawMaterialButton(
    fillColor: Color.fromRGBO(83, 122, 88, 1),
    child: Text(startTime,
    style: TextStyle(color: Colors.white),),
    onPressed: (){
      _openTimePicker(context);
    },
    ),);


  }
Widget buildEndTime() {
String endTime = '9:00 PM';
  Future<void> _openTimePicker(BuildContext context) async {
    
    final TimeOfDay? endingTime = 
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if(endingTime != null){

      setState(() {
        endTime = endingTime.format(context);
      });
    }
  }

return Container(
  
  child: ElevatedButton(
    onPressed: (){
      _openTimePicker(context);
    },
    style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0)
    
       ),
    primary: Color.fromRGBO(83, 122, 88, 1)),

    child: Text(endTime,
    style: TextStyle(color: Colors.white),),
    
    ),);


  }

  Widget buildTimetitle() => Container(
       
       child: Text(
            '\nPickup Time\n', 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
    );
     Widget buildStartTimeTitle() => Container(
       
       child: Text(
            '\nStart Time\n', 
            style: TextStyle( fontSize: 20),),
    );
      Widget buildEndTimeTitle() => Container(
       
       child: Text(
            '\nEnd Time\n', 
            style: TextStyle( fontSize: 20),),
    );
    Widget buildSpace() => Container(
       
       child: Text(
            '\n', )
    );

  final notifications =[
    CheckBoxState(title: 'Paper'),
    CheckBoxState(title: 'Cardboard'),
    CheckBoxState(title: 'Glass'),
    CheckBoxState(title: 'Plastic'),
    CheckBoxState(title: 'Nylon'),
    CheckBoxState(title: 'Cans'),
    CheckBoxState(title: 'Metals'),
    CheckBoxState(title: 'Electronics'),
    CheckBoxState(title: 'Batteries'),
    CheckBoxState(title: 'Furniture'),
    CheckBoxState(title: 'Clothes'),
    CheckBoxState(title: 'Food'),
  


  ];

  
  
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
  backgroundColor: Color.fromRGBO(83, 122, 88, 1),
  ),



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
        ...notifications.map(buildSingleCateg).toList(),
        buildTimetitle(),
        buildStartTimeTitle(),
        buildStartTime(),
        buildEndTimeTitle(),
        buildEndTime(),
        buildSpace(),
        buildNext(),
      ],
      ),
    ),
      );
    


    

  }



    
  

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:inst_registration/CheckBoxState.dart';
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:time_range/time_range.dart';
import 'package:email_validator/email_validator.dart';





class regScreen extends StatefulWidget {
  const regScreen({ Key? key }) : super(key: key);

  @override
  _regScreenState createState() => _regScreenState();
}

class _regScreenState extends State<regScreen> {
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
void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });}
     Widget buildSocialM() => TextFormField(
      decoration: InputDecoration(
        prefixIcon: Padding(
         padding: EdgeInsets.all(0.0),
         child: Icon(
          Icons.link,
           color: Color.fromRGBO(83, 122, 88, 1)),
            ), 
        labelText: 'Twitter Account',
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

          if(!formKey.currentState!.validate()){
            return;
          }
     
          },
           
            style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(83, 122, 88, 1),
            shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
            
            ),
  
       ));
     @override
  Widget buildStartTime(BuildContext context) {
  
   final _defaultTimeRange = TimeRangeResult(
    TimeOfDay(hour: 14, minute: 50),
    TimeOfDay(hour: 15, minute: 20),
    );
   TimeRangeResult? _timeRange;

   @override
   void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
   }

//https://pub.dev/packages/time_range/example
    return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 5),
                child: Text(
                  'Pickup Times',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              TimeRange(
                fromTitle: Text(
                  'FROM',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                toTitle: Text(
                  'TO',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                titlePadding: 50,
                textStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                activeTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(83, 122, 88, 0.5),
                ),
                borderColor: Colors.black,
                activeBorderColor: Colors.black,
                backgroundColor: Colors.transparent,
                activeBackgroundColor: Color.fromRGBO(83, 122, 88, 0.5),
                firstTime: TimeOfDay(hour: 8, minute: 00),
                lastTime: TimeOfDay(hour: 23, minute: 59),
                initialRange: _timeRange,
                timeStep: 10,
                timeBlock: 30,
                onRangeCompleted: (range) => setState(() => _timeRange = range),
              ),
              SizedBox(height: 30),
              if (_timeRange != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Selected Range: ${_timeRange!.start.format(context)} - ${_timeRange!.end.format(context)}',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        child: Text('Default'),
                        onPressed: () =>
                            setState(() => _timeRange = _defaultTimeRange),
                        color: Color.fromRGBO(83, 122, 88, 0.5),
                      )
                    ],
                  ),
                ),
            ],
          ),
        );
  }


 




  
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
  leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.black),
    onPressed: (){},),

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
        buildStartTime( context),
        buildSpace(),
        buildNext(),
      ],
      ),
    ),
      );
    


    

  }



    
  

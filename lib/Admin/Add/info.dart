

import 'package:flutter/material.dart';
import 'package:mostadeem/Admin/viViewModel.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/components/rounded_button.dart';
import 'package:mostadeem/components/text_field_container.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/services/database.dart';

import '../../constants.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
final AuthService _auth = AuthService();
final ViewInstitutionViewModel ourViewMode=ViewInstitutionViewModel();
final RegExp titleRegExp = RegExp('[a-zA-Z]'); // make it accepts numbers and special characters but not only one of them
Map<String, String> _authData = { // can use variables instead of map 
    'title': '',
    'description': '',
  }; 
  TextEditingController _titleController = TextEditingController(); //add it in rounded input class
  TextEditingController _desController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // added it
  // firebase 
  //final _auth = FirebaseAuth.instance; // delete it 


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ()=> FocusManager.instance.primaryFocus.unfocus(),
      child: Scaffold( // cnage background color to make it match ?
        backgroundColor: Colors.white,
        appBar: AppBar(
    
        title: Padding(
          padding: const EdgeInsets.only(left:57),
          child: Text('Add Info', style:TextStyle(
              letterSpacing:2,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),),
        ),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(18),
        ),
      ),
          backgroundColor: Color.fromRGBO(48, 126, 80, 1),
          elevation: 0.0,
            toolbarHeight:60.0,
          ),
          
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Form( 
            key: _formKey, 
            autovalidateMode: AutovalidateMode.always, // added it
            child: Column(
              children: [
        topImage(),      
        title(),                
        description(),   
        SizedBox(height: size.height * 0.01),
        submitButton(),  
       // bottomImage(),  
        SizedBox(height: size.height * 0.03),    
              
              ],),
            ),
          ),
        ),
        
      ),
    );
  }

Widget topImage(){
   Size size = MediaQuery.of(context).size;
  return 
  SizedBox(
                    // height: 270, // change the number to make the logo bigger     
                     width:size.width,
                     child: Image.asset("assets/images/park.png",
                      fit: BoxFit.contain,
                      alignment: Alignment.topCenter,));
}

Widget title(){
  return
                    TextFieldContainer(
            child: TextFormField( 
                autofocus: false,
                controller: _titleController, 
                cursorColor: kPrimaryColor,
                maxLength: 15,
                textInputAction: TextInputAction.next, // added it
             // keyboardType: TextInputType.number, //for phone there's one for email
      
                decoration: InputDecoration(
                  prefixIcon: Icon( Icons.title_rounded, color: kPrimaryColor,
                  ),
                  hintText: "Title",
                  // contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15), // make it smaller
             //  border: InputBorder.none,
             
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(15.0),
                  ),
    
                  borderSide: new BorderSide(
                    color: kPrimaryColor,
                    width: 2,
                  ),
                ),
                ),
                validator: (value) => value.isEmpty 
      ? 'Required'
      : (titleRegExp.hasMatch(value) 
          ? null 
          : 'Not a valid title'),
                        onSaved: (value) {
                        // or _emailController.text = value!;
                        _authData['title'] = value; },
      
                        onChanged: (val) {
                                  setState(() => _authData['title'] = val);
                                },
                  ),
          );
 

}

Widget description(){
  return
                   TextFieldContainer(
                child: TextFormField( 
                keyboardType: TextInputType.multiline,
            //  minLines: 1,//Normal textInputField will be displayed
                maxLines: 5,// when user presses enter it will adapt to it
                maxLength: 250, // ???
                autofocus: false,
                controller: _desController, 
                cursorColor: kPrimaryColor,
                textInputAction: TextInputAction.done, // added it
             // keyboardType: TextInputType.number, //for phone there's one for email
      
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 78),
                    child: Icon( Icons.description_rounded, color: kPrimaryColor,
                    ),
                  ),
                  hintText: "Description",
                   focusedBorder:OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromRGBO(48, 126, 80, 1), width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
        ),
                  // contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15), // make it smaller
             //  border: InputBorder.none,
             
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(15.0),
                  ),
    
                  borderSide: new BorderSide(
                    color: kPrimaryColor,
                    width: 10,
                  ),
                ),
                ),
                validator: (value) => value.isEmpty 
      ? 'Required'
      : (titleRegExp.hasMatch(value) 
          ? null 
          : 'Not a valid description'),
                        onSaved: (value) {
                        // or _emailController.text = value!;
                        _authData['description'] = value; },
      
                        onChanged: (val) {
                                  setState(() => _authData['description'] = val);
                                },
                  ),
          );
  

}

Widget bottomImage(){
  Size size = MediaQuery.of(context).size;
  return 
  SizedBox(
                    // height: 270, // change the number to make the logo bigger     
                     width:size.width,
                     child: Image.asset("assets/images/main_bottom.png",
                      fit: BoxFit.contain,
                    //  alignment: Alignment.bottomCenter,
                      ));
}

// clear fields after submit + direct to the previous page 
Widget submitButton(){
  return
                  RoundedButton(
                  text: "Submit",
                  press: () async{ 
                  if(_formKey.currentState.validate()){
                  // for validation display pop up

                  dynamic result= await _auth.addInformation(_authData['title'].trim(),_authData['description'].trim());

                  if(result=="success info"){
                    ourViewMode. showTopSnackBar(context,'Success','Information has been posted',Icons.add_task ); // change 
                    Navigator.of(context).pop();
                  }
                  else // error
                  {
                    ourViewMode.showTopSnackBar(context,'Couldn\'t post','An error occurred while posting info',Icons.cancel_outlined, );// change
                    // clear text fields
                    _titleController.clear();
                    _desController.clear();
                  }
                    }//
                  },
                );
    
    
}

}
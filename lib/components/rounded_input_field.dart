import 'package:flutter/material.dart';
import 'package:mostadeem/components/text_field_container.dart';
import 'package:mostadeem/constants.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String errorTextForValidation;
  final IconData icon;
  final ValueChanged<String> onSaved; // ValueChanged<String> ,FormFieldSetter<String>?
  final ValueChanged<String> onChanged;
  final Function validator;
  final TextInputType keyboard; //added it
  final TextInputAction textInputAction;
  final TextEditingController textController; // added it ,maybe deleted
  //final Function textFieldValidator;
  
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon, // icons.person
    this.onSaved,
    this.onChanged,
    this.validator,
    this.textInputAction,
    this.errorTextForValidation,
    this.keyboard,
    this.textController,
    //this.textFieldValidator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      
      child: TextFormField( // was TextField
      
        onSaved: onSaved, // not in form
        autofocus: false,
        onChanged: onChanged,
        keyboardType: keyboard, // added it ,maybe deleted
        controller: textController, // added it ,maybe deleted
        cursorColor: kPrimaryColor,
        textInputAction: textInputAction, // added it
        //validator: textFieldValidator,
       // keyboardType: TextInputType.number, for phone there's one for email

        decoration: InputDecoration(
          prefixIcon: Icon( icon, color: kPrimaryColor,
          ),
          hintText: hintText,
       //  border: InputBorder.none,
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(15.0),
          ),
          borderSide: new BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        ),
      validator:validator,
      ),
    );
  }
}

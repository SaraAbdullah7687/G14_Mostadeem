import 'package:flutter/material.dart';
import 'package:test_project/components/text_field_container.dart';
import 'package:test_project/constants.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String errorTextForValidation;
  final IconData icon;
  final ValueChanged<String> onSaved; // onChanged maybe wrong ,FormFieldSetter<String>?
  final TextInputType keyboardType; //added it
  final TextEditingController textController; // added it ,maybe deleted
  //final Function textFieldValidator;
  
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon, // icons.person
    this.onSaved,
    this.errorTextForValidation,
    this.keyboardType,
    this.textController,
    //this.textFieldValidator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField( // was TextField
        onSaved: onSaved, // not in form
        keyboardType: keyboardType, // added it ,maybe deleted
        controller: textController, // added it ,maybe deleted
        cursorColor: kPrimaryColor,
        textInputAction: TextInputAction.next, // added it
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
      validator: MultiValidator([
      RequiredValidator(errorText: "Required"),
      EmailValidator(errorText: errorTextForValidation), // WRONG don't generlize all fields as email
      ]
      ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mustadeem/components/text_field_container.dart';
import 'package:mustadeem/constants.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onSaved;
  final TextEditingController controller;
  const RoundedPasswordField({
    Key key,
    this.onSaved,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        onSaved: onSaved, // change it ?
        controller: controller,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.green[900],
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(15.0),
          ),
          borderSide: new BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        //  border: InputBorder.none,
        ),
        validator: MultiValidator([
      RequiredValidator(errorText: "Required"),
      MinLengthValidator(8, errorText: "At least 8 characters"),
      MaxLengthValidator(15, errorText: "At most 15 characters"),
      ]
      ),
      ),
    );
  }
}

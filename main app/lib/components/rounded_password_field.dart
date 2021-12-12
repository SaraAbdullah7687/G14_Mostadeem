import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:mostadeem/components/text_field_container.dart';
import 'package:mostadeem/constants.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onSaved;
  final ValueChanged<String> onChanged;
  final TextEditingController controllerPw;
  final bool isSignUp;
  final Function press;
  const RoundedPasswordField({
    Key key,
    this.onSaved,
    this.press,
    this.isSignUp,
    this.onChanged,
    this.controllerPw,
    TextInputAction textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 6),
            child: TextFormField(
              obscureText: true,
              onSaved: onSaved, // change it ?
              onChanged: onChanged,
              controller: controllerPw,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(
                  Icons.lock,
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
                // MinLengthValidator(8, errorText: "At least 8 characters"),
                MaxLengthValidator(15, errorText: "At most 15 characters"),
              ]),
            ),
          ),
          isSignUp
              ? new FlutterPwValidator(
                  controller: controllerPw,
                  minLength: 8,
                  uppercaseCharCount: 1,
                  numericCharCount: 1,
                  specialCharCount: 1,
                  width: 400,
                  height: 150,
                  onSuccess: () {},

                  /// do something
                )
              : GestureDetector(
                  onTap: press,
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

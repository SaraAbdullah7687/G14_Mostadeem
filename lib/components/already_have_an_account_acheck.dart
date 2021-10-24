import 'package:flutter/material.dart';
import 'package:mostadeem/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            login ? "Don’t have an Account ? " : "Already have an Account ? ",
            style: TextStyle(color: kPrimaryColor),
          ),
          GestureDetector(
            onTap: press,
            child: Text(
              login ? "Sign Up" : "Sign In",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                decoration:
              TextDecoration.underline, // added after sprint 1
              ),
            ),
          )
        ],
      ),
    );
  }
}

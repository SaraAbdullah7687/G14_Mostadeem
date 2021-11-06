// ignore: file_names
import 'dart:core';

//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mostadeem/screens/home/home.dart';
import 'package:mostadeem/screens/authenticate/bodyLogin.dart';
import 'package:mostadeem/screens/home/profile.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/components/advanceAlert.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'package:mostadeem/globals/global.dart' as globals;

class editProfile extends StatefulWidget {
  @override
  _editProfile createState() => _editProfile();
}

class _editProfile extends State<editProfile> {
  final AuthService _auth = AuthService();

  TextEditingController _controller = TextEditingController();
  TextEditingController _emailController =
      TextEditingController(); //add it in rounded input class
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _twitterController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  String message = '';

  static final RegExp nameRegExp = RegExp('[a-zA-Z]');

// Name .....................................

  Widget buildName() {
    String un = getName();

    //print (name);
    return TextFormField(
      initialValue: globals.userName,
      cursorColor: Color.fromRGBO(48, 126, 80, 1),
      maxLength: 15,
      validator: (value) => value.isEmpty
          ? 'Required'
          : (nameRegExp.hasMatch(value) ? null : 'Enter a Valid Name'),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        prefixIcon: Padding(
          padding: EdgeInsets.all(0.0),
          child: Icon(Icons.person, color: Color.fromRGBO(48, 126, 80, 1)),
        ),
        labelText: 'Name',
        labelStyle: TextStyle(color: Color.fromRGBO(48, 126, 80, 1)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromRGBO(48, 126, 80, 1)),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onChanged: (value) => setState(() => name = value),
    );
  }

// Email .....................................

  Widget buildEmail() => TextFormField(
      initialValue: globals.userEmail,
      cursorColor: Color.fromRGBO(48, 126, 80, 1),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        prefixIcon: Padding(
          padding: EdgeInsets.all(0.0),
          child: Icon(Icons.email, color: Color.fromRGBO(48, 126, 80, 1)),
        ),
        labelText: 'Email',
        labelStyle: TextStyle(color: Color.fromRGBO(48, 126, 80, 1)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromRGBO(48, 126, 80, 1)),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onChanged: (value) => setState(() => email = value),
      validator: MultiValidator([
        RequiredValidator(errorText: "Required"),
        EmailValidator(errorText: "Enter a valid email"),
      ]));

// Phone  .....................................

  Widget buildPhone() => TextFormField(
      initialValue: globals.userPhone,
      cursorColor: Color.fromRGBO(48, 126, 80, 1),
      maxLength: 10,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        prefixIcon: Padding(
          padding: EdgeInsets.all(0.0),
          child: Icon(Icons.phone, color: Color.fromRGBO(48, 126, 80, 1)),
        ),
        labelText: 'Phone',
        hintText: '05xxxxxxxx',
        labelStyle: TextStyle(color: Color.fromRGBO(48, 126, 80, 1)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromRGBO(48, 126, 80, 1)),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onChanged: (value) => setState(() => phone = value),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null) {
          return 'Required';
        }
        String pattern = "(05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})";
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(value))
          return 'Invalid phone number';
        else
          return null;
      });

// Twitter .....................................

// Title .....................................

  String email = globals.userEmail;

  final formKey = GlobalKey<FormState>();

  String name = globals.userName;
  String phone = globals.userPhone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            buildName(),
            const SizedBox(height: 16),
            buildEmail(),
            const SizedBox(height: 16),
            buildPhone(),
            const SizedBox(height: 16),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    child: Text('Cancel',
                        style:
                            TextStyle(fontSize: 20, color: Colors.grey[100])),
                    onPressed: () {
                      Navigator.of(context).pop(MaterialPageRoute(
                        builder: (context) => Home(),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      primary: Colors.grey,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Save',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () async {
                      var firebaseUser = FirebaseAuth.instance.currentUser;

                      if (formKey.currentState
                          .validate()) if (firebaseUser.email == email.trim()) {
                        print('emails the same has been checked');

                        try {
                          FirebaseFirestore.instance
                              .collection('contributor')
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .update({
                            'name': name,
                            'phone': phone,
                            'email': email
                          });
                          print('update should be okay');
                          getName();
                          getEmail();
                          getPhone();

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                              (route) => false);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AdvanceCustomAlert(
                                    icon: Icons.check,
                                    msgTitle: 'Profile updated',
                                    msgContent:
                                        'Your profile has been updated successfuly',
                                    btnContent: 'Ok');
                              });
                        } catch (e) {
                          Navigator.of(context).pop(MaterialPageRoute(
                            builder: (context) => Home(),
                          ));

                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AdvanceCustomAlert(
                                    icon: Icons.cancel,
                                    msgTitle: 'Could' 'nt update profile',
                                    msgContent:
                                        'An error occured while updating your profile, please try again later',
                                    btnContent: 'Ok');
                              });
                        }
                      }

                      if (firebaseUser.email != email.trim()) {
                        print('emails are not the same');

                        print(email);
                        updateEmail(context, email);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      primary: Color.fromRGBO(48, 126, 80, 1),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus.unfocus(),
      child: Scaffold());
}

final firestoreInstance = FirebaseFirestore.instance;

String getName() {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  firestoreInstance
      .collection("contributor")
      .doc(firebaseUser.uid)
      .get()
      .then((value) {
    String name = (value.data()['name']);
    globals.userName = name;
  });

  return globals.userName;
}

void getPhone() {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  firestoreInstance
      .collection("contributor")
      .doc(firebaseUser.uid)
      .get()
      .then((value) {
    String phone = (value.data()['phone']);
    globals.userPhone = phone;
  });
}

void updateEmail(BuildContext context, String email) async {
  print(email);
  var firebaseUser = FirebaseAuth.instance.currentUser;

  String name = globals.userName;
  String phone = globals.userPhone;

  try {
    print(email + 'heere');
    await firebaseUser.updateEmail(email);

    try {
      FirebaseFirestore.instance
          .collection('contributor')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({'name': name, 'phone': phone, 'email': email});
      print('update should be okay');
      getName();
      getEmail();
      getPhone();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Home()), (route) => false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(
                icon: Icons.check,
                msgTitle: 'Profile updated',
                msgContent: 'Your profile has been updated successfuly',
                btnContent: 'Ok');
          });
    } catch (e) {
      Navigator.of(context).pop(MaterialPageRoute(
        builder: (context) => Home(),
      ));

      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(
                icon: Icons.cancel,
                msgTitle: 'Could' 'nt update profile',
                msgContent:
                    'An error occured while updating your profile, please try again later',
                btnContent: 'Ok');
          });
    }
  } catch (e) {
    print(e);
    print('down');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AdvanceCustomAlert(
              icon: Icons.cancel,
              msgTitle: 'Taken email',
              msgContent: 'The entered email is already in use',
              btnContent: 'Ok');
        });
  }
}

String getEmail() {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  firestoreInstance
      .collection("contributor")
      .doc(firebaseUser.uid)
      .get()
      .then((value) {
    String email = (value.data()['email']);
    globals.userEmail = email;
  });

  return globals.userEmail;
}

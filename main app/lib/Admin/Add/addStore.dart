import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mostadeem/Admin/components/social_icon.dart';
import 'package:mostadeem/Admin/viViewModel.dart';
import 'package:mostadeem/components/advancedAlertNew.dart';
import 'package:mostadeem/components/rounded_button.dart';
import 'package:mostadeem/components/text_field_container.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mostadeem/services/database.dart';
import '../../constants.dart';

class AddStore extends StatefulWidget {
  @override
  _AddStoreState createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  final AuthService _auth = AuthService();
  Map<String, String> _authData = {
    // can use variables instead of map
    'name': '',
    'IG': '',
  };
  final RegExp titleRegExp = RegExp(
      '[a-zA-Z]'); // make it accepts numbers and special characters but not only one of them
  TextEditingController _nameController =
      TextEditingController(); //add it in rounded input class
  TextEditingController _igController = TextEditingController();
  final ViewInstitutionViewModel ourViewMode = ViewInstitutionViewModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // added it
  File image;
  RegExp instagramRegex = new RegExp("@[A-Za-z0-9_]{1,15}");
  RegExp insReg =
      new RegExp('(?=[a-zA-Z0-9._]{2,20})(?!.*[_.]{2})[^_.].*[^_.]'); // try
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus.unfocus(),
      child: Scaffold(
        // cnage background color to make it match ?
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 57),
            child: Text(
              'Add Store',
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(18),
            ),
          ),
          backgroundColor: Color.fromRGBO(48, 126, 80, 1),
          elevation: 0.0,
          toolbarHeight: 60.0,
        ),

        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 70),
            width: double.infinity,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always, // added it
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Image.file(image,
                              width: 150, height: 150, fit: BoxFit.cover))
                      : topImage(),

                  SizedBox(height: size.height * 0.03),
                  storeName(),
                  storeIG(), // change the validation , هنا لازم يحتوي على ارقام وحروف وسبشل كاركترز
                  storePhoto(),
                  SizedBox(height: size.height * 0.01),
                  submitButton(context),
                  SizedBox(height: size.height * 0.03),
                  //bottomImage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget storePhoto() {
    return GestureDetector(
      onTap: () {
        pickImage();
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: 280, // 250
          height: 63, //200
          decoration: BoxDecoration(
            border: Border.all(
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Material(
            color: Colors.white,
            elevation: 11.0, //14
            borderRadius: BorderRadius.circular(15.0),
            shadowColor: Colors.grey[100], //Color(0x802196F3)
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0), // 90
                child: myDetailsContainer1(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget storeName() {
    return TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: _nameController,
        cursorColor: kPrimaryColor,
        maxLength: 15,
        textInputAction: TextInputAction.next, // added it
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.store_mall_directory_rounded,
            color: kPrimaryColor,
          ),
          hintText: "Name",
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
            : (titleRegExp.hasMatch(value) ? null : 'Not a valid name'),
        onSaved: (value) {
          // or _emailController.text = value!;
          _authData['name'] = value;
        },

        onChanged: (val) {
          setState(() => _authData['name'] = val);
        },
      ),
    );
  }

  Widget storeIG() {
    return TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: _igController,
        cursorColor: kPrimaryColor,
        textInputAction: TextInputAction.done, // added it
        maxLength: 30,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.link,
            color: kPrimaryColor,
          ), // change it to instgram icon

          hintText: "Instagram account @xxx",
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
            : (instagramRegex.hasMatch(value)
                ? null
                : 'Not a valid Instagram account'),
        onSaved: (value) {
          // or _emailController.text = value!;
          _authData['IG'] = value;
        },

        onChanged: (val) {
          setState(() => _authData['IG'] = val);
        },
      ),
    );
  }

  Widget submitButton(BuildContext context) {
    return RoundedButton(
      text: "Submit",
      press: () async {
        if (_formKey.currentState.validate()) {
          if (image != null) {
            dynamic checkStoreResult = await DatabaseService()
                .checkStoreExists(_authData['name'].toLowerCase());
            if (checkStoreResult == 'No store') {
              // the store has not been added before
              // check first if store exists or not
              dynamic result = await _auth.addStore(
                  _authData['name'].toLowerCase().trim(),
                  _authData['IG'].trim());

              if (result == "success add") {
                // add photo

                dynamic uploadResult = await uploadImageToFirebase();

                if (uploadResult == 'success uploading') {
                  ourViewMode.showTopSnackBar(
                      context,
                      'Success',
                      'Store has been added successfully',
                      Icons.add_task); // change
                  Navigator.of(context).pop();
                } else {
                  ourViewMode.showTopSnackBar(
                    context,
                    'Couldn\'t add',
                    'An error occurred while adding store',
                    Icons.cancel_outlined,
                  ); // change
                  // clear text fields
                }
              } else // error
              {
                ourViewMode.showTopSnackBar(
                  context,
                  'Couldn\'t add',
                  'An error occurred while adding store',
                  Icons.cancel_outlined,
                ); // change
                // clear text fields
                _nameController.clear();
                _igController.clear();
              }
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AdvanceCustomAlertNew(
                      icon: Icons.error_outline,
                      msgContent: _authData['name'] + ' has been added before',
                      btnContent: 'Ok',
                    );
                  });
            }
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AdvanceCustomAlertNew(
                    icon: Icons.error_outline,
                    msgContent: 'Please select a photo',
                    btnContent: 'Ok',
                  );
                });
          }
        } //
      },
    );
  }

  Widget myDetailsContainer1() {
    return Padding(
      padding: const EdgeInsets.only(left: 22, top: 2),
      child: Row(
        children: [
          Icon(Icons.photo_library_outlined, color: kPrimaryColor, size: 30),
          SizedBox(width: 10),
          Text(
            "Add store image",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
          /* image!=null?
          Padding(
            padding: const EdgeInsets.only(top:2,left:30),
            child: Image.file(image,
            width:24,
            height:24,
            fit:BoxFit.cover),
          )
        :*/
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 33),
            child: Icon(
              Icons.upload,
              color: kPrimaryColor,
              size: 18,
            ), // maybe deleted
          ),
        ],
      ),
    );
  }

  Widget topImage() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: 150, // change the number to make the logo bigger
        width: 150, //assets/images/stroeIcon2.png
        child: Image.asset(
          "assets/images/store2.png",
          fit: BoxFit.contain,
          alignment: Alignment.topCenter,
        ));
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() {
        this.image = tempImage;
      });
    } on Exception catch (e) {
      print("catch platform ex in image picker");
    }
  }

  Future<String> uploadImageToFirebase() async {
    try {
      final fileName = _authData['name'];
      final destination = 'storeImages/$fileName';

      final ref = FirebaseStorage.instance.ref(destination);
      ref.putFile(image);
      return 'success uploading';
    } on FirebaseException catch (e) {
      return 'error uploading';
    }
  }
}

/*
  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_authData['name']);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }*/

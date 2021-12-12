import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/components/advancedAlertNew.dart';
import 'package:mostadeem/constants.dart';
import 'package:mostadeem/globals/global.dart' as global;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mostadeem/services/auth.dart';

import 'calendar.dart';
import 'home/home.dart';

class initateRequest2 extends StatefulWidget {
  const initateRequest2({Key key}) : super(key: key);

  @override
  _initateRequestState createState() => _initateRequestState();
}

// to get current user id and store it with the token
AuthService auth = AuthService();

class _initateRequestState extends State<initateRequest2> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  String uid = auth.getCurrentUserID();

  void initState() {
    super.initState();

    _fcm.getToken().then((fcmToken) {
      if (fcmToken != null) {
        print("TOOOOOOOOOOKKKKKKKKKKKKKEN in request for this device is: " +
            fcmToken +
            "  END");
        var tokens = FirebaseFirestore.instance
            .collection('contributor')
            .doc(uid)
            .collection('tokens')
            .doc(fcmToken);

        tokens.set({
          'token': fcmToken,
          'createdAt': FieldValue.serverTimestamp(), // optional
        });
      }
    });
  }

  // when onPressed -BACK-: take the cats and go to HOME screens
  void _goToHome(BuildContext context) async {
    // AFNAN
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
    //SARA
    /* Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => calendarScreen(
          category: thisCategory,
        ),
      ),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Initiate Request'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),
        toolbarHeight: 60.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          tooltip: 'Show Snackbar',
          onPressed: () {
            _goToHome(context);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: 280,
            margin: EdgeInsets.only(
                left: 10, top: 16), //Check Afnan's sizes and position
            child: Image.asset(
              'assets/images/step1.png',
              alignment: Alignment.center,
              height: 90,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 10, left: 30),
              child: Text(
                'Initiate a request:',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )),
          Container(child: RadioGroup())
        ],
      ),
    );
  }
}

class MyChoice {
  String choice;
  int index;

  MyChoice({this.index, this.choice});
}

class RadioGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RadioGroupState();
  }
}

class RadioGroupState extends State<RadioGroup> {
  String default_choice = 'by category';
  int default_index = 0;

  List<MyChoice> choices = [
    MyChoice(index: 0, choice: 'by category'),
    MyChoice(index: 1, choice: 'to a specific institution'),
  ];
// when onPressed: take the cats and go to calendar screens
  void _goToCalendar(BuildContext context, String thisCategory) async {
    // AFNAN
    //Navigator.of(context).push(
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(
          // Calendar
          category: thisCategory.toLowerCase(),
        ),
      ),
    );
    //SARA
    /* Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => calendarScreen(
          category: thisCategory,
        ),
      ),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Wrap(children: <Widget>[
          Container(
            child: Theme(
              data: Theme.of(context).copyWith(
                  unselectedWidgetColor: kPrimaryColor,
                  toggleableActiveColor: Colors.orange[700]),
              child: Column(
                  children: choices
                      .map((data) => RadioListTile(
                            title: Text('${data.choice}'),
                            groupValue: default_index,
                            value: data.index,
                            onChanged: (value) {
                              setState(() {
                                default_choice = data.choice;
                                default_index = data.index;
                              });
                            },
                          ))
                      .toList()),
            ),
          ),
          Container(
              child: default_choice == 'by category'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 45),
                              child: Text(
                                'Please select at least one category',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              )),
                          buildAllCategories(),
                        ])
                  : buildSpecInst()),
          Container(
            width: 100,
            margin: EdgeInsets.only(left: 130),
            child: ElevatedButton(
              onPressed: () {
                if (default_choice == 'by category') {
                  if (hasSelected()) {
                    print(categ);

                    _goToCalendar(context, categ);
                  } else {
                    print(categ);

                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AdvanceCustomAlertNew(
                              icon: Icons.cancel,
                              msgContent: 'You have not selected categories ',
                              btnContent: 'Ok');
                        });
                  }
                }

                if (default_choice == 'to a specific institution') {
                  if (hasSelectedSpecific(spec_cat)) {
                    print(categ);

                    _goToCalendar(context, categ);
                  } else {
                    print(categ);

                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AdvanceCustomAlertNew(
                              icon: Icons.cancel,
                              msgContent:
                                  'You have not selected categories for specific institution',
                              btnContent: 'Ok');
                        });
                  }
                }
              },
              child: Text('Next'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange[700]),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
            ),
          ),
        ])
      ],
    ));
  }

  Widget buildAllCategories() {
    return Container(
        height: 330,
        margin: EdgeInsets.only(left: 30, right: 30),
        width: double.infinity,
        child: Ink(
          width: 380,
          height: 60,
          color: Colors.white10,
          child: GridView.count(
            primary: true,
            padding: const EdgeInsets.all(20),

            crossAxisCount: 3, //set the number of buttons in a row
            crossAxisSpacing: 30, //set the spacing between the buttons
            mainAxisSpacing: 10,
            childAspectRatio: 1, //set the width-to-height ratio of the button,
            //>1 is a horizontal rectangle
            children: List.generate(global.reqCat.length, (index) {
              //using Inkwell widget to create a button
              return InkWell(
                  splashColor: Colors.grey, //the default splashColor is grey
                  onTap: () {
                    //set the toggle logic
                    setState(() {
                      for (int indexBtn = 0;
                          indexBtn < global.reqCat.length;
                          indexBtn++) {
                        if (indexBtn == index) {
                          global.reqCat[index] = !global.reqCat[index];
                        }
                      }
                    });
                  },
                  child: Ink(
                      decoration: BoxDecoration(
                        //set the background color of the button when it is selected/ not selected
                        color: global.reqCat[index]
                            ? Color.fromRGBO(48, 126, 80, 0.3)
                            : Colors.white,
                        // here is where we set the rounded corner
                        borderRadius: BorderRadius.circular(8),
                        //don't forget to set the border,
                        //otherwise there will be no rounded corner
                        border:
                            Border.all(color: Color.fromRGBO(48, 126, 80, 1)),
                      ),
                      child: Image.asset(
                          "assets/images/" + categories[index] + '.png')
                      //set the color of the icon when it is selected/ not selected

                      ));
            }),
          ),
        ));
  }

  String categ = '';
  List<String> categories = [
    'Paper',
    'Cardboard',
    'Glass',
    'Plastic',
    'Metals',
    'Electronics',
    'Nylon',
    'Cans',
    'Batteries',
    'Furniture',
    'Clothes',
    'Food'
  ];

  String selectedInst = '';
  List<String> inst = [];

  List<String> getNames(AsyncSnapshot<QuerySnapshot<Object>> snap) {
    List<String> names = [];
    print(
        "IN getNames 318 #########################################################3");
    snap.data.docs.forEach((element) {
      names.add(element['name']);
    });
    print(
        "IN getNames 322 #########################################################3");
    names.sort();
    print("Names SORTED: $names");
    return names;
  }

  String categ2 = 'Food';
  Widget buildSpecInst() {
    var selectedIns; //=============================================================

    return Row(children: <Widget>[
      SizedBox(
        height: 40,
      ),
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('institution')
            .where("status", isEqualTo: "approved")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            Text('No available institutions');
          } else {
            //////////////////////////////////////////////////////////////

            // REPLACE BY SARA'S DROPDOWN LIST

            return Container(
                width: 350,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 28, right: 10),
                              child: Icon(
                                Icons.account_balance,
                                size: 25,
                                color: kPrimaryColor,
                              ),
                            ),
                            Text('Select Institution',
                                style: TextStyle(color: kPrimaryColor)),

                            /* DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: kPrimaryColor),
                          underline: Container(
                            height: 2,
                            color: kPrimaryColor,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              global.specificCat =
                                  []; // DON'T FORGET TO ADD THIS LINE WHEN SARA CHANGES THE DROPDOWN LIST TO THE DROPDOWN LIST FROM THE DATABASE
                              dropdownValue = newValue;
                              snapshot.data.docs.forEach((element) {
                                if (element['name'] == selectedIns) {
                                  categ2 = element["category"];
                                  // need to exit the loop
                                }
                              });
                              global.isSpecific = true;
                              global.insName = selectedIns;
                            });
                          },
                          items: snapshot.data.docs
                              .map<DropdownMenuItem<String>>(
                                  (value) => new DropdownMenuItem<String>(
                                        value: value["name"],
                                        child: new Text(value["name"]),
                                      ))
                              .toList(),
                        ),*/
//#########################3

//###############################3
                          ]),

///////////////////////////////////////////////////////////////////////////////////////////

                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              //   height: 200,
                              width: 300,
                              margin:
                                  EdgeInsets.only(left: 29, top: 5, bottom: 5),
                              child: DropdownSearch<String>(
                                mode: Mode.MENU,
                                showSearchBox: true,
                                showSelectedItems: true,
                                items: getNames(snapshot),
                                //  label: "Menu mode",
                                // hint: "country in menu mode",
                                //  popupItemDisabled: (String s) => s.startsWith('I'),
                                selectedItem: dropdownValue,
                                onChanged: (String newValue) {
                                  setState(() {
                                    global.specificCat =
                                        []; // DON'T FORGET TO ADD THIS LINE WHEN SARA CHANGES THE DROPDOWN LIST TO THE DROPDOWN LIST FROM THE DATABASE
                                    dropdownValue = newValue;
                                    print(
                                        "dropdownValue is $dropdownValue@@@@@@@@@@@@@@@@@@@@@@@@@@2");
                                    snapshot.data.docs.forEach((element) {
                                      if (element['name'] == dropdownValue) {
                                        // replace name by id
                                        categ2 = element["category"];

                                        // need to exit the loop
                                      }
                                    });
                                    print(
                                        "categ2 is $categ2@@@@@@@@@@@@@@@@@@@@@@@@@@2");
                                    //    specificCateg(categ2);
                                    global.isSpecific = true;
                                    global.insName = dropdownValue;
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30, top: 5),
                              child: Text(
                                'Please select at least one category',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                height: 200,
                                width: 400,
                                child: specificCateg(
                                    categ2) // Just pass the categories attribute from the database
                                )
                          ]),
                    ]));
          }

          // This to avoid returning null in the snapshot
          return Container(
            width: 0,
            height: 0,
          );
        },
      )
    ]);
  }

  String dropdownValue =
      'Alber'; // Replace it by the first institution name in the snapshot

  List<String> spec_cat = [];

  Widget specificCateg(String categ) {
    List<String> categories = [];

    categories = categ2.split(',');

    for (int i = 0; i < categories.length; i++) {
      print(categories[i]);

      global.specificCat.add(false);
    }

    spec_cat =
        categories; // To pass it to hasSelectedSpecific when pressing the button to the next page

    print(categories);

    return Container(
        height: 400,
        margin: EdgeInsets.only(left: 30, right: 30),
        width: double.infinity,
        child: Ink(
          width: 380,
          height: 60,
          color: Colors.white10,
          child: GridView.count(
            primary: true,
            padding: const EdgeInsets.all(20),

            crossAxisCount: 3, //set the number of buttons in a row
            crossAxisSpacing: 30, //set the spacing between the buttons
            mainAxisSpacing: 10,
            childAspectRatio: 1, //set the width-to-height ratio of the button,
            //>1 is a horizontal rectangle
            children: List.generate(categories.length, (index) {
              //using Inkwell widget to create a button
              return InkWell(
                  splashColor: Colors.grey, //the default splashColor is grey
                  onTap: () {
                    //set the toggle logic
                    setState(() {
                      for (int indexBtn = 0;
                          indexBtn < categories.length;
                          indexBtn++) {
                        if (indexBtn == index) {
                          global.specificCat[index] =
                              !global.specificCat[index];
                        }
                      }
                    });
                  },
                  child: Ink(
                      decoration: BoxDecoration(
                        //set the background color of the button when it is selected/ not selected
                        color: global.specificCat[index]
                            ? Color.fromRGBO(48, 126, 80, 0.3)
                            : Colors.white,
                        // here is where we set the rounded corner
                        borderRadius: BorderRadius.circular(8),
                        //don't forget to set the border,
                        //otherwise there will be no rounded corner
                        border:
                            Border.all(color: Color.fromRGBO(48, 126, 80, 1)),
                      ),
                      child: Image.asset(
                          "assets/images/" + categories[index].trim() + '.png')
                      //set the color of the icon when it is selected/ not selected

                      ));
            }),
          ),
        ));
  }

// If the user used initiate by categore for specific category use this method to validate that he selected a category

  bool hasSelected() {
    bool check = false;

    for (int i = 0; i < global.reqCat.length; i++) {
      check = check || global.reqCat[i];
    }
    if (check) {
      print('has selected');

      int selectedItems = 0;
      categ = '';

      for (int i = 0; i < global.reqCat.length; i++) {
        if (global.reqCat[i] == true) categ += categories[i] + ', ';
      }
      categ = categ.substring(0, categ.length - 2); // To remove the last comma
      print(categ); // Just to check
    } else
      print('did not select');

    return check;
  }

// If the user used initiate request for specific category use this method to validate that he selected a category
  bool hasSelectedSpecific(List<String> specificCategories) {
    bool check = false;

    for (int i = 0; i < global.specificCat.length; i++) {
      check = check || global.specificCat[i];
    }
    if (check) {
      print('has selected');

      int selectedItems = 0;
      categ = '';

      for (int i = 0; i < global.specificCat.length; i++) {
        if (global.specificCat[i] == true)
          categ += specificCategories[i] + ', ';
      }
      categ = categ.substring(0, categ.length - 2); // To remove the last comma
      print(categ); // Just to check
    } else
      print('did not select');

    return check;
  }
}

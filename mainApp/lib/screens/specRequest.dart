import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:mostadeem/globals/global.dart' as global;
import 'package:mostadeem/screens/calendar.dart';
import 'package:mostadeem/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mostadeem/screens/home/home.dart';

import 'locatin.dart';
// dropDown ====================================================================
import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:mostadeem/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class specRequestScreen extends StatefulWidget {
  //static String tag = '/BookAppointmentScreen';
  @override
  specRequestScreenState createState() => specRequestScreenState();
}

class specRequestScreenState extends State<specRequestScreen> {
  // when onPressed -BACK-: take the cats and go to HOME screens
  void _goToHome(BuildContext context) async {
    // AFNAN
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

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
  }

  Future<List<String>> insList() async {
    List<String> names = []; //list();

    List<QueryDocumentSnapshot> _list =
        await DatabaseService().getAllInstitutions();
    _list.forEach((element) {
      names.add(element['name']);
    });
    return names;
  }

// to convert Future<List<String>> to List<String>
  List<String> insList2() {
    List<String> names = []; //list();

    insList().then((rows) {
      setState(() {
        names = rows;
        print(' HHHHHHHHHHHHHEEEEEEEEEERRRRRRRRREEEEEEEEEE: $names');
      });
    });
  }

/*void initState(){
  super.initState();

}*/
// to dispaly the categories for the selected ins
  void dispalyCat() {}
// 3333333333333333333333333333333333
  DropdownMenuItem<String> buildMenuItem(String item) {
    DropdownMenuItem<String>(
      value: item,
      child: Text(item),
    );
  }

// add Controller, but which type? for cats selection---------
  var selectedIns; //=============================================================
  final list = ["kk", "ll"]; //insList2();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Categories'),
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
        ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 280,
            margin: EdgeInsets.only(left: 40),
            child: Image.asset(
              'assets/images/step1.png',
              alignment: Alignment.center,
              height: 80,
              fit: BoxFit.fitWidth,
            ),
          ),

// Institution feild================================================
          Container(
            margin: EdgeInsets.only(left: 10, top: 5),
            child: Text(
              "Select Institution",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(48, 126, 80, 1),
                  fontWeight: FontWeight.bold),
            ),
          ),

          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("institution")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  const Text("Loading.....");
                else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 50.0),
                      Container(
                        /*decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                        ),*/
                        child: DropdownButton(
                          items: snapshot.data.docs
                              .map<DropdownMenuItem<String>>(
                                  (value) => new DropdownMenuItem<String>(
                                        value: value["name"],
                                        child: new Text(value["name"]),
                                      ))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedIns = newValue;
                              print(selectedIns);
                            });
                          },
                          value: selectedIns,
                          key: UniqueKey(), //==================888888888
                          isExpanded: false,
                          hint: new Text(
                            "Select",
                            style: TextStyle(color: Color(0xff11b719)),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
          //======================

// END Institution feild ===========================================

          Container(
            margin: EdgeInsets.only(left: 10, top: 5),
            child: Text(
              "Select at least one category",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(48, 126, 80, 1),
                  fontWeight: FontWeight.bold),
            ),
          ),

          // START CAT Contauiner==========================================================================
          Container(
              height: 460,
              margin: EdgeInsets.only(top: 5),
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
                  mainAxisSpacing: 20,
                  childAspectRatio:
                      1, //set the width-to-height ratio of the button,
                  //>1 is a horizontal rectangle
                  children: List.generate(global.reqCat.length, (index) {
                    //using Inkwell widget to create a button
                    return InkWell(
                        splashColor:
                            Colors.grey, //the default splashColor is grey
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
                              border: Border.all(
                                  color: Color.fromRGBO(48, 126, 80, 1)),
                            ),
                            child: Image.asset(
                                "assets/images/" + categories[index] + '.png')
                            //set the color of the icon when it is selected/ not selected

                            ));
                  }),
                ),
              )),
          // END CAT Contauiner==========================================================================
          Container(
            margin: const EdgeInsets.only(left: 125),
            child: ButtonTheme(
              minWidth: 110.0,
              height: 55.0,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                color: Color.fromRGBO(48, 126, 80, 1),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  bool check = hasSelected();

                  if (!check) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AdvanceCustomAlert(
                            icon: Icons.error,
                            msgTitle: 'Attention',
                            msgContent: 'Please select at least 1 category.',
                            btnContent: 'Ok',
                          );
                        });
                  } else {
                    _goToCalendar(context,
                        categ); // NEED ACTUAL DATA ==================================================================================
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
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
]; // retrirve from database

class DemoToggleButtons extends StatefulWidget {
  @override
  _DemoToggleButtonsState createState() => _DemoToggleButtonsState();
}

class _DemoToggleButtonsState extends State<DemoToggleButtons> {
  @override
  Widget build(BuildContext context) {
    //wrap the GridView wiget in an Ink wiget and set the width and height,
    //otherwise the GridView widget will fill up all the space of its parent widget
    return Container(
        height: 300,
        width: double.infinity,
        child: Ink(
          width: 380,
          height: 60,
          color: Colors.white,
          child: GridView.count(
            primary: true,
            padding: const EdgeInsets.all(20),
            crossAxisCount: 4, //set the number of buttons in a row
            crossAxisSpacing: 10, //set the spacing between the buttons
            mainAxisSpacing: 8,
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
                            ? Color.fromRGBO(48, 126, 80, 0.7)
                            : Colors.white,
                        // here is where we set the rounded corner
                        borderRadius: BorderRadius.circular(8),
                        //don't forget to set the border,
                        //otherwise there will be no rounded corner
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Image.asset(
                          "assets/images/" + categories[index] + '.png')
                      //set the color of the icon when it is selected/ not selected

                      ));
            }),
          ),
        ));
  }
}

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

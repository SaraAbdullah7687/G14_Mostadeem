import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_xd/home3.dart';

//================================================================
/*
void main() {
  runApp(const calendar(
    key: null,
  ));
}

class calendar extends StatefulWidget {
  const calendar({
    required Key? key,
  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: calendar(),
    );
  }
}

class calendar extends StatefulWidget {
  const calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<calendar> {
  DateTime date = DateTime.now();
  Future<Null> selectTimeMethod(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2021),
        lastDate: DateTime(2022));

    if (picked != null && picked != date) {
      setState(() {
        date = picked; // NULL CHECK 888888888888888888888888888
        print(date.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          /* Text(_dateTime == null
              ? "Nothing has been picked yet"
              : _dateTime.toString()),
         
         */
          // ignore: deprecated_member_use
          RaisedButton(
            child: Text("Pick a date"),
            onPressed: () {
              selectTimeMethod(context);
            },
          )
        ],
      ),
    );
  }
}

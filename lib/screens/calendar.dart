// ignore: file_names
/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'home3.dart';
import 'locatin.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Date & Time';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: MainPage(
          category: '',
        ),

        ///PARAMETER
      );
}

class MainPage extends StatefulWidget {
  String category; //FINAL ?

  //constructer--------------------------------------------------------------------------------------------
  MainPage({required this.category});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Date&Time'),
            backgroundColor: Color.fromRGBO(48, 126, 80, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(18),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                ),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocationApp(
                              category: widget.category,
                              dateTime:
                                  dateTime, // ERROR HEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEERRREEEEEEEEEEEEEEE
                            )),
                  );
                },
              ),
            ],
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              tooltip: 'Show Snackbar',
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => home3()),
                );
              },
            ),
            toolbarHeight: 80.0,
          ),
          backgroundColor: Colors.white10,
          body: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DatetimePickerWidget(),
              ],
            ),
          ),
        ),
      );
}

class DatetimePickerWidget extends StatefulWidget {
  @override
  _DatetimePickerWidgetState createState() => _DatetimePickerWidgetState();
}

class _DatetimePickerWidgetState extends State<DatetimePickerWidget> {
  var dateTime;

  String getText() {
    if (dateTime == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('MM/dd/yyyy HH:mm').format(dateTime!);
    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        title: 'DateTime',
        text: getText(),
        onClicked: () => pickDateTime(context),
      );

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime!.hour, minute: dateTime!.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }
}

/////////////////////////////////////////

class ButtonHeaderWidget extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onClicked;

  const ButtonHeaderWidget({
    Key? key,
    required this.title,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => HeaderWidget(
        title: title,
        child: ButtonWidget(
          text: text,
          onClicked: onClicked,
        ),
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(40),
          primary: Color.fromRGBO(48, 126, 80, 1),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
          ),
        ),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        onPressed: onClicked,
      );
}

class HeaderWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const HeaderWidget({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
}*/

/* The new calender with sperate time and date*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/screens/request.dart';
import 'locatin.dart';
import 'package:mostadeem/globals/global.dart'
    as global; //==================================================================================

/*Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Date & Time';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MainPage(
          category: '',
        ),

        ///PARAMETER
      );
}*/

class MainPage extends StatefulWidget {
  String category; //FINAL ?

  //constructer--------------------------------------------------------------------------------------------
  MainPage({required this.category});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //========================METHODS================================
  // when onPressed: BACK- take the cats and go to calendar screens
  void _goToCategory(BuildContext context) async {
    //AFNAN
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => requestScreen()),
    );
  }

  // when onPressed: take the cats and go to calendar screens
  void _goToLocation(BuildContext context, String thisCategory, String thisDate,
      String thisTime) async {
    // AFNAN
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LocationApp(
                category: thisCategory,
                date:
                    thisDate, // ERROR HEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEERRREEEEEEEEEEEEEEE : we fix it
                time: thisTime,
              )),
    );
  }

  //======================================================

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Data & Time",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Scaffold(
          body: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Date & Time'),
              backgroundColor: Color.fromRGBO(48, 126, 80, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(18),
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                  ),
                  tooltip: 'Show Snackbar',
                  onPressed: () {
                    if (global.globalDate == null ||
                        global.globalTime == null) {
                      // ERROR msg **********************************************************************************HERE****************************
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AdvanceCustomAlert(
                              icon: Icons.error,
                              msgTitle: 'Error',
                              msgContent: 'Please select Date & Time.',
                              btnContent: 'Ok',
                            );
                          });
                    } else {
                      _goToLocation(
                        context,
                        widget.category,
                        global.globalDate.toString(),
                        global.globalTime.toString(),
                      );
                    }

                    /// PASS dateTIME ====================================================
                  },
                ),
              ],
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  _goToCategory(
                      context); //===================================================================
                },
              ),
              toolbarHeight: 80.0,
            ),
            //      backgroundColor: Colors.white10,
            body: Padding(
              padding:
                  const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimePickerWidget(),
                  DatePickerWidget(),
                ],
              ),
            ),
          ),
        ),
      );
}

class DatePickerWidget extends StatefulWidget {
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  // DateTime? date;

  String getText() {
    if (global.globalDate == null) {
      return 'Select Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(global
          .globalDate!); // NULLABLE ###################################################################
    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        title: 'Date',
        text: getText(),
        onClicked: () => pickDate(context),
      );

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: global.globalDate ?? initialDate,
      firstDate: DateTime.now(),
//DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newDate == null) return;
    //if (newDate.isAfter(DateTime.now().add(Duration(days: 1)))) {} // ???????????????????????????????????????????????????????????????????????????

    // setState(() => date = newDate);
    setState(() => global.globalDate =
        newDate); //================================================================================
  }
}

class TimePickerWidget extends StatefulWidget {
  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
//  TimeOfDay? time;

  String getText() {
    if (global.globalTime == null) {
      return 'Select Time';
    } else {
      final hours = global.globalTime!.hour.toString().padLeft(2,
          '0'); // NULLABLE ###################################################################
      final minutes = global.globalTime!.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        title: 'Time',
        text: getText(),
        onClicked: () => pickTime(context),
      );

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay.now();
    final newTime = await showTimePicker(
      context: context,
      initialTime: global.globalTime ?? initialTime,
    );

    if (newTime == null) return;

    // setState(() => time = newTime);
    setState(() => global.globalTime =
        newTime); //========================================================================
  }
}

/////////////////////////////////////////
class ButtonHeaderWidget extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onClicked;

  const ButtonHeaderWidget({
    Key? key,
    required this.title,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => HeaderWidget(
        title: title,
        child: ButtonWidget(
          text: text,
          onClicked: onClicked,
        ),
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

/*
  @override
  Widget build(BuildContext context) => ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            width: 1.0,
            color: Color.fromRGBO(48, 126, 80, 1),
          ),
          minimumSize: Size.fromHeight(150),
          primary: //Color.fromRGBO(48, 126, 80, 1),
              Colors.white,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
          ),
        ),
        icon: Icon(
          Icons.access_time_rounded,
          color: Color.fromRGBO(48, 126, 80, 1),
        ),
        label: FittedBox(
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ),
        onPressed: onClicked,
      );*/

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            width: 1.0,
            color: Color.fromRGBO(48, 126, 80, 1),
          ),
          minimumSize: Size.fromHeight(120),
          primary: Colors.white,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
          ),
        ),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        onPressed: onClicked,
      );
}

class HeaderWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const HeaderWidget({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 80),
            child: Text(
              title,
              style: TextStyle(
                color: Color.fromRGBO(48, 126, 80, 1),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          /*  Icon(Icons.time_to_leave_rounded,
               title == 'Time' ? Color.fromRGBO(48, 126, 80, 1)
                  : Colors.white10),
          Icon(Icons.calendar_today,
              color: title == 'Date'
                  ? Color.fromRGBO(48, 126, 80, 1)
                  : Colors.white10),*/
          const SizedBox(
            height: 8,
          ),
          child,
        ],
      );
}

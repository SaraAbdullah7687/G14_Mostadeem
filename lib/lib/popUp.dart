import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inst_trial/Screens/authenticate/logIn.dart';
import 'package:inst_trial/Screens/authenticate/registerScreen.dart';

class AdvanceCustomAlert extends StatelessWidget {
  IconData icon;
  String msgTitle;
  String msgContent;
  String btnContent;

// constructor
  AdvanceCustomAlert({
    @required this.icon,
    @required this.msgTitle,
    @required this.msgContent,
    @required this.btnContent,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(15),
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: 250,
            width: 300,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white70,
                      child: Icon(
                        icon, // icon var
                        size: 60,
                        color: Color.fromRGBO(48, 126, 80, 1),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    color: Color.fromRGBO(48, 126, 80, 1),
                    child: SizedBox.expand(
                      child: Column(
                        children: [
                          Text(
                            msgTitle, // var
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            msgContent,
                            textAlign: TextAlign.center, // var
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          RaisedButton(
                            child: Text(
                              btnContent, //var
                              style: TextStyle(
                                color: Color.fromRGBO(48, 126, 80, 1),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();

                              if (icon == Icons.celebration) {
                                //=======================================================================================================================
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => logIn(),
                                    ),
                                    (route) => true);
                                /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()),
                                );*/
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

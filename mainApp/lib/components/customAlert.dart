import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/screens/home/home.dart';

class CustomAlert extends StatelessWidget {
  IconData icon;
  String msgTitle;
  String msgContent;
  //String btnContent;
  final Function press;

// constructor
  CustomAlert({
    @required this.icon,
    @required this.msgTitle,
    @required this.msgContent,
    // @required this.btnContent,
    @required this.press,
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
            height: 260,
            width: 300,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white70,
                      child: Icon(
                        //1- Icon var ######################################################################33
                        //  Icons.celebration,
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
                            // 2- msg title var ######################################################################33
                            //  'Done!',
                            msgTitle, // var
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            // 3- msg content var ######################################################################33
                            //  'we have recievd your request',
                            msgContent, // var
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: RaisedButton(
                                  child: Text(
                                    // 4- msg btn content var ######################################################################33
                                    // 'OK',
                                    "Cancle", //var
                                    style: TextStyle(
                                      color: Color.fromRGBO(48, 126, 80, 1),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              SizedBox(width: 12),
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: RaisedButton(
                                  child: Text(
                                    // 4- msg btn content var ######################################################################33
                                    // 'OK',
                                    "Yes", //var
                                    style: TextStyle(
                                      color: Color.fromRGBO(48, 126, 80, 1),
                                    ),
                                  ),
                                  onPressed: press,
                                ),
                              )
                            ],
                          ),
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

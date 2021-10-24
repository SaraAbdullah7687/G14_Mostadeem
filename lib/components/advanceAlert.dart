



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/screens/home/home.dart';

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
            height: 255,
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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                         
                          Padding(
                            padding: const EdgeInsets.only(top:6),
                            child: RaisedButton(
                              child: Text(
                                // 4- msg btn content var ######################################################################33
                                // 'OK',
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
                                        builder: (context) => Home(),
                                      ),
                                      (route) => false);
                                  /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()),
                                  );*/
                                }
                              },
                            ),
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
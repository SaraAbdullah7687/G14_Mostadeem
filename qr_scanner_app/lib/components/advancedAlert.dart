import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class AdvanceCustomAlertNew extends StatelessWidget  {

  IconData icon;
  String msgContent;
  String btnContent;
  Color backGCircle;
  Color btnColor;
  Function press;

AdvanceCustomAlertNew({
    @required this.icon,
    @required this.msgContent,
    @required this.btnContent,
    @required this.backGCircle,
    @required this.btnColor,
    @required this.press,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                           color: Colors.transparent


                          ),
            height: 180,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  
                  Text(msgContent, style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
                  SizedBox(height: 20),

                  
                  SizedBox(
  width: 100.0,
  height: 40.0,
  child:
                  ElevatedButton(
                    
                    

                    

                    style: ButtonStyle(
                      
                      backgroundColor: MaterialStateProperty.all(btnColor),


                      
                      

                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                            side: BorderSide(width: 0, color: Colors.transparent),

                        

                      ))
                    ),
                    
                    
                    
                    onPressed: 
                    press,
                    child: Text(btnContent, style: TextStyle(fontSize:17, color: Colors.white),),
                  ),),
                ],
              ),
            ),
          ),
          Positioned(
            top: -60,
            child: CircleAvatar(
              backgroundColor: backGCircle,
              radius: 60,
              child: Icon(icon, color: Colors.white, size: 50,),
            )
          ),
        ],
      )
    );
  }
}

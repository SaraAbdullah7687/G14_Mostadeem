import 'package:flutter/material.dart';

class twoButtonsAlert extends StatelessWidget  {

  IconData icon;
  String msgContent;
  String btn1Content;
  String btn2Content;
  Function press;




twoButtonsAlert({
    @required this.icon,
    @required this.msgContent,
    @required this.btn1Content,
    @required this.btn2Content,
    @required this.press


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
                  SizedBox(height: 14),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  SizedBox(
  width: 120.0,
  height: 40.0,
  child:
                  ElevatedButton(
                    
                    

                    

                    style: ButtonStyle(
                      
                      backgroundColor: MaterialStateProperty.all(Colors.orange[700]),


                      
                      

                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                            side: BorderSide(width: 0, color: Colors.transparent),

                        

                      ))
                    ),
                    
                    
                    
                    onPressed: () {
                    Navigator.of(context).pop();
                  },
                    child: Text(btn1Content, style: TextStyle(fontSize:17, color: Colors.white),),
                  ),),


                  SizedBox(
  width: 120.0,
  height: 40.0,
  child:
                  ElevatedButton(
                    
                    

                    

                    style: ButtonStyle(
                      
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(48, 126, 80, 1)),


                      
                      

                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                            side: BorderSide(width: 0, color: Colors.transparent),

                        

                      ))
                    ),
                    
                    
                    
                    onPressed: press,
                                        

                                          
                                          


              

            



            



            





     
          
                  
                    child: Text(btn2Content, style: TextStyle(fontSize:15, color: Colors.white),),
                  ),),

                ])
                ],
              ),
            ),
          ),
          Positioned(
            top: -60,
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(48, 126, 80, 1),
              radius: 60,
              child: Icon(icon, color: Colors.white, size: 60,),
            )
          ),
        ],
      )
    );
  }
}
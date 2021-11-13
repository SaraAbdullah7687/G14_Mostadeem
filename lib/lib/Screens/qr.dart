
import 'dart:core';



//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/screens/home/home.dart';
import 'package:mostadeem/screens/home/points.dart';
import 'package:mostadeem/screens/home/viewQR.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/components/advanceAlert.dart';
import 'package:mostadeem/shared/loading.dart';


import 'package:mostadeem/globals/global.dart' as globals;



class qrCodes extends StatefulWidget {
  const qrCodes({ Key key }) : super(key: key);

  @override
  _qrCodesState createState() => _qrCodesState();
}

class _qrCodesState extends State<qrCodes> {
  String uid='';
   final AuthService _auth = AuthService();

  @override

  Widget build(BuildContext context) {
              getName();
              getEmail();
              getPhone();
              getPoints();
    
    return 


Scaffold(
  
          backgroundColor: Colors.white,
                    body: 
                      StreamBuilder (
                        stream: FirebaseFirestore.instance.collection('code')
                        .where(('uid'), isEqualTo: FirebaseAuth.instance.currentUser.uid)
                        .where(('status'), isEqualTo: ('valid'))
                        //.orderBy('amount')  it returns snapshot.hasData false  Check it
                        .snapshots(),
                        builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot){

         
                        

                          if (!snapshot.hasData){
                            
                            print(snapshot.hasData);
                            return Loading();

                            //return Container(

                             // child: Column (children: [

                            //    Image.asset('assets/images/qrGreen.png', height:100),


                             // ]
                          //  )
                            //);
                    }
                    if (snapshot.data.docs.length==0){
                              return noQR('No valid QR codes', 'To generate a QR code, you can redeem your points');
                            }

     

                    return ListView(
                      children: snapshot.data.docs.map((document){
                        return  Container(
                          margin: EdgeInsets.only( top:20, left: 20, right:20),
                          decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.only(
                       topLeft: Radius.circular(10),
                       topRight: Radius.circular(10),
                       bottomLeft: Radius.circular(10),
                       bottomRight: Radius.circular(10)
                       ),
                      boxShadow: [
                      BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                      ),
                      ],
                       ),


                          child: Stack(
                          children:  <Widget>[


                          Row(
                            children: <Widget>[

                           Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 10, 20),
                            child: Text(document['amount'].toDouble().toString()+' SR',
                            style: TextStyle(
                           fontSize: 23,
                           fontWeight: FontWeight.w900,
                           color: Color.fromRGBO(48, 126, 80, 1)
                           ),
                            )
                            ),

                          Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.brown[50],


                          ),
                          margin: EdgeInsets.only(left:35, top: 8),
                          height: 50,
                          width: 90,
                          
                          child: 
                          OutlinedButton(
                            
                            
                

                          style: ButtonStyle(

                                
                          shape: 
                          MaterialStateProperty.all(RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(15.0))),
                          ),
                          

                          onPressed:(){
                            getPoints();

                           globals.userPoints=(globals.userPoints+(document['amount'].toDouble()*5.ceil())).ceil();
                            Navigator.of(context).push(
                       MaterialPageRoute(builder: (context)=>points()));


                       FirebaseFirestore.instance.collection('contributor').doc(FirebaseAuth.instance.currentUser.uid).update({
                      'points': globals.userPoints

                         });
                         FirebaseFirestore.instance.collection('code').doc(document.id).update({
                      'status': 'used'

                         });


                         FirebaseFirestore.instance.collection('code').doc(document.id).update({
                      'dateUsed': 'Restored to points at: \n'+globals.todayDate

                         });
                         



                         

                          } , 
                          
                          child: Text('Restore points',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          color: Color.fromRGBO(48, 126, 80, 1)

                          ),
                          )),
                          ),





                          Container(
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                           color: Color.fromRGBO(48, 126, 80, 0.3),


                          ),
                          margin: EdgeInsets.only(left:20, top:8),
                          height: 50,
                          width: 90,
                          child: 
                          OutlinedButton(
                          
                          style: ButtonStyle(
                          shape: 
                          MaterialStateProperty.all(RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(15.0))),
                          ),

                              onPressed:(){


                                        Navigator.of(context).push(
                       MaterialPageRoute(builder: (context)=>viewQR(code: document['code'], status: document['status'], dateCreated: document['dateRedeemed'], amount: document['amount'].toDouble()),));

                              } 
                              
                              , child:
                              RichText(
                             text: TextSpan(
                             children: [
                             TextSpan(
                             text: "View QR code  ", style: TextStyle(color: Color.fromRGBO(48, 126, 80, 1), fontWeight: FontWeight.bold),
                             
                              ),
                             WidgetSpan(
                            child: Icon(Icons.qr_code, size: 16, color:Color.fromRGBO(48, 126, 80, 1)),
                            
       
                            ),
                           ],
                           ),
                         )),

                              
                              
                              
                              ),

                          


                            



                          
                          ]),

                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 32, 20, 10),
                            child: Text('Code: ' + document['code'],
                            style: TextStyle(
                           fontSize: 10,
                           color:Colors.blue[900],
                           fontWeight: FontWeight.bold,

                           ),
                            )
                            ),


                            Padding(
                            padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
                            child: Text('Created at: ' + document['dateRedeemed'],
                            style: TextStyle(
                           fontSize: 10,
                           ),
                            )
                            ),






                          
                          ]
                          )
                        
                        );

                      }).toList(),


                    );

                        }
                        )
                        )
                        ;}
      }



final firestoreInstance = FirebaseFirestore.instance;

String getName(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;

    firestoreInstance.collection("contributor").doc(firebaseUser.uid).get().then((value){
      String name =(value.data()['name']);
      globals.userName=name;
      }) 
      ;
      
      return globals.userName;

      } 

      



String getEmail(){
  var firebaseUser =  FirebaseAuth.instance.currentUser;

    firestoreInstance.collection("contributor").doc(firebaseUser.uid).get().then((value){
      String email =(value.data()['email']);
      globals.userEmail=email;
      }) 
      ;
      
      return globals.userEmail;

      } 




  void getPhone(){
   
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("contributor").doc(firebaseUser.uid).get().then((value){
      String phone =(value.data()['phone']);
      globals.userPhone=phone;
      }) 
      ;}  

      Widget noQR(String title, String msg){

        return  Center(

        child: Container(

        margin: EdgeInsets.only(top:40),
          

          

        child: Column (
        
        children: [

        Image.asset('assets/images/qrGreen.png', height:100),
        Text('\n'+title+'\n', 
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),),
        Text(msg)


       ]
         )
        ));
      }








  class InvalidQRCodes extends StatefulWidget {
  const InvalidQRCodes({ Key key }) : super(key: key);

  @override
  _InvalidQRCodesState createState() => _InvalidQRCodesState();
}

class _InvalidQRCodesState extends State<InvalidQRCodes> {
  String uid='';
   final AuthService _auth = AuthService();

  @override

  Widget build(BuildContext context) {
              getName();
              getEmail();
              getPhone();
              getPoints();
    
    return 


Scaffold(
          backgroundColor: Colors.white,
                    body: 
                      StreamBuilder (
                        stream: FirebaseFirestore.instance.collection('code')
                        .where(('uid'), isEqualTo: FirebaseAuth.instance.currentUser.uid)
                        .where(('status'), isEqualTo: ('used')).snapshots(),
                        builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot){

         
                        

                          if (!snapshot.hasData){
                            
                            print(snapshot.hasData);
                            return Loading();

                            //return Container(

                             // child: Column (children: [

                            //    Image.asset('assets/images/qrGreen.png', height:100),


                             // ]
                          //  )
                            //);
                    }
                    if (snapshot.data.docs.length==0){
                              return noQR('No used QR codes', 'To generate a QR code, you can redeem your points');
                            }

     

                    return ListView(
                      children: snapshot.data.docs.map((document){
                        return  Container(
                          margin: EdgeInsets.only(top:15, left: 20, right:20),
                          decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.only(
                       topLeft: Radius.circular(10),
                       topRight: Radius.circular(10),
                       bottomLeft: Radius.circular(10),
                       bottomRight: Radius.circular(10)
                       ),
                      boxShadow: [
                      BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                      ),
                      ],
                       ),


                          child: Stack(
                          children:  <Widget>[


                          Row(
                            children: <Widget>[

                           Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 23),
                            child: Text(document['amount'].toDouble().toString()+' SR',
                            style: TextStyle(
                           fontSize: 25,
                           fontWeight: FontWeight.w900,
                           color: Color.fromRGBO(48, 126, 80, 1)
                           ),
                            )
                            ),

                          




                          


                            

                            Padding(
                            padding: EdgeInsets.fromLTRB(30, 15, 30, 10),
                            child: Text(document['dateUsed'],
                            style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.bold
                           ),
                            )
                            ),

                          
                          ]),

                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 36, 20, 10),
                            child: Text('Code: ' + document['code'],
                            style: TextStyle(
                           fontSize: 10,
                           color:Colors.blue[900],
                           fontWeight: FontWeight.bold,

                           ),
                            )
                            ),


                            Padding(
                            padding: EdgeInsets.fromLTRB(20, 50, 20, 8),
                            child: Text('Created at: ' + document['dateRedeemed'],
                            style: TextStyle(
                           fontSize: 10,
                           ),
                            )
                            ),






                          
                          ]
                          )
                        
                        );

                      }).toList(),


                    );

                        }
                        )
                        )
                        ;}
      }


String getPoints(){
   
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("contributor").doc(firebaseUser.uid).get().then((value){
      int points =(value.data()['points']);
      globals.userPoints=points;
      }) ;
      return globals.userPoints.toString();
      }

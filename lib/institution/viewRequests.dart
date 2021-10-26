
//import 'dart:convert';

//import 'dart:html';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mostadeem/Admin/components/social_icon.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/institution/vrViewModel.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants.dart';


class reqestsView extends StatelessWidget { 
   @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewRequestViewModel>(
        create: (_) => ViewRequestViewModel(),
        child: Container(
            height: 1200,
            width: 450,
            child: ViewRequests())
    );
  }
}



class ViewRequests extends StatefulWidget {
 const ViewRequests({
    Key key,
  }) : super(key: key);

  @override
  _ViewRequestsState createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests> {
  final AuthService _auth = AuthService();
  final List<Flushbar> flushBars = []; 
 WebViewController controller;
  String contID;

final ViewRequestViewModel ourViewMode=ViewRequestViewModel();

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero, () => setState(() {
      setup();
    }));
  }

    setup() async {
    await Provider.of<ViewRequestViewModel>(context, listen: false)
        .fetchRequests();
   
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> institutions = Provider.of<ViewRequestViewModel>(context, listen: false)
        .requests;
    return Scaffold(
        backgroundColor: Colors.grey[50],
      body: 
             StreamBuilder(
               stream: institutions,
               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) return Loading();
        
        if (snapshot.data.docs.length==0){
          return Center(
        child: Text(
          'No accepted requests',
          style: TextStyle(fontSize: 20, color: Colors.grey,),
        ),
      );
        }
        
        else return //Container( height: 50, width: 50,child: 
         new ListView.builder( 
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) =>
                buildInstitutionCard(context, snapshot.data.docs[index]),//),
                );
        }
    
      ),
   // ),    
    );
  }

 Widget buildInstitutionCard(BuildContext context, DocumentSnapshot document) {
    return  Padding(
            padding: const EdgeInsets.only(left:21,right:21,top:18,),
            child: Container(
               width: 140, // 250
               height: 145, //160
               decoration: BoxDecoration(
              /*  border: Border.all(
                 color: Colors.green[900],
                ),*/
               borderRadius: BorderRadius.circular(24.0),
               ),
                child: Material(
                    color: Colors.white,
                    elevation: 14.0, //14
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0), // 90 //15
                            child: myDetailsContainer1(context,document),
                          ),
                        ),
                ),
              ),
          );
    }

 Widget myDetailsContainer1(BuildContext context, DocumentSnapshot document) {
 return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
           Container( 
            margin: EdgeInsets.only(top:13, left:18, ), 
            child:Text(document['name'],
            style: TextStyle(color: Colors.green[900], fontSize: 25.0,fontWeight: FontWeight.bold),),),

            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                       padding: const EdgeInsets.only(left:12.0, top:7),
                       child: Icon(
                  Icons.category,
                  size:20,
                  color: kPrimaryColor,
                ),
                     ),
                Container( 
                margin: EdgeInsets.only(top:7, left:5,//left:18, 
                ), 
                child:  Text(document['category'],
                style: TextStyle(color: Colors.grey, fontSize: 12.0,),),),
              ],
            ),


            
                 Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left:12.0, top:7),
                       child: Icon(
                  Icons.calendar_today_sharp,
                  size:20,
                  color: kPrimaryColor,
                ),
                     ),
                     Container( 
            margin: EdgeInsets.only(top:9, left:5, ), 
            child:
            Text(ourViewMode.convertDate(context,document),
            style: TextStyle(color: Colors.grey, fontSize: 12.0,),),),
                   
               // time    
            Padding(
                       padding: const EdgeInsets.only(left:35.0, top:7),
                       child: Icon(
                  Icons.access_time,
                  size:20,
                  color: kPrimaryColor,
                ),
                     ),
                     Container( 
            margin: EdgeInsets.only(top:10, left:5, ), 
            child:
            Text(ourViewMode.convertTime(context,document),
            style: TextStyle(color: Colors.grey, fontSize: 12.0,),),),       
                   
                   ],
                 ),

 /* Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left:12.0, top:7),
                       child: Icon(
                  Icons.access_time,
                  size:20,
                  color: kPrimaryColor,
                ),
                     ),
                     Container( 
            margin: EdgeInsets.only(top:10, left:10, ), 
            child:
            Text(ourViewMode.convertTime(context,document),
            style: TextStyle(color: Colors.grey, fontSize: 12.0,),),),
                   ],
                 ),
*/

          /* Container( margin: const EdgeInsets.all(5),
              child: ElevatedButton.icon(
                onPressed: ()=> _checkCR(document.get("CR"),context),
                label: Text(document['CR'], style: TextStyle(color: Colors.blue[400], fontSize: 18.0,fontWeight: FontWeight.bold, decoration: TextDecoration.underline ),),
                icon: Icon(Icons.receipt_long_rounded), // or assignment confirmation_num_sharp
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(48, 126, 80, 1) // can be changed 
                ),
              )),*/
            lastRow(context,document),
  ],
    );

 }

Widget lastRow(BuildContext context, DocumentSnapshot document){
  return Row( 
    children: <Widget>[

contactIcons(context,document),
SizedBox(width: 6),
 requestStatus(context,document),
  ],);//,),);
}

Widget contactIcons(BuildContext context, DocumentSnapshot document){
  return 
    Flexible(
     child:Row( 
        mainAxisAlignment: MainAxisAlignment.start,
       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
    
    Flexible( child:
            IconButton(
          icon: const Icon(Icons.mail_outline),
          color: kPrimaryColor,
          tooltip: 'Send email',
          onPressed: ()=>  ourViewMode.sendingMails(document.get("email")),
         // _sendingMails(document.get("email")),
          
          ),),
    SizedBox(width: 12),
    Flexible( child:
                IconButton(
          icon: const Icon(Icons.phone),
          color: kPrimaryColor,
          onPressed: ()=> ourViewMode.goToWhatsapp(document.get("phone")),),),
    SizedBox(width: 12),
    Flexible( child:
                IconButton(
          icon: const Icon(Icons.location_on),
          color: kPrimaryColor,
          onPressed: ()=> ourViewMode.openLocation(document.get("location")),),),
 
  ],),//),
  );
}

Widget requestStatus(BuildContext context, DocumentSnapshot document){
return 

SingleChildScrollView(
                       scrollDirection: Axis.horizontal,
                         child:
 Row( //direction: Axis.vertical,
 //alignment: WrapAlignment.end,
mainAxisAlignment: MainAxisAlignment.end,
   children: <Widget>[
TextButton(
    child: Text('Accept'),
    style: ElevatedButton.styleFrom(
      shape: new RoundedRectangleBorder(
               borderRadius: new BorderRadius.circular(22.0),
               ),
      primary: kPrimaryColor, //Colors.green[400],
      onPrimary: Colors.white,
      onSurface: Colors.grey,
      padding: EdgeInsets.only(top:1 , bottom:1, right: 3, left: 3),
    ),
    onPressed: () {
     // ourViewMode.showMyDialog("accept", context,document.id,document);
     ourViewMode.showCustomAlert("accept", "Are you sure you want to accept this request?", context, document.id, document);
    },
  ),
SizedBox(width: 10), 

ElevatedButton(
    child: Text('Reject'),
    style: ElevatedButton.styleFrom(
      shape: new RoundedRectangleBorder(
               borderRadius: new BorderRadius.circular(22.0),
               ),
      primary: Colors.red[400],
      onPrimary: Colors.white,
      onSurface: Colors.grey,
      padding: EdgeInsets.all(3)
    ),
    onPressed: () {
     // ourViewMode.showMyDialog("reject", context,document.id,document);
     ourViewMode.showCustomAlert("reject", "Are you sure you want to reject this request?", context, document.id, document);
    },

),

    ], ),
   );

}

}// end of class

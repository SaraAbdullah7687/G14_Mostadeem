
//import 'dart:convert';

//import 'dart:html';

import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
//import 'package:flutter_svg/svg.dart';
////import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:test_project/Screens/background.dart';
import 'package:test_project/services/auth.dart';
import 'package:test_project/shared/loading.dart';
//import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'components/social_icon.dart';

class ViewInstitution extends StatelessWidget {
  final AuthService _auth = AuthService();
 WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(

           shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(18),
      ),
    ),
      /*  title: Text(
          "MOSTADEEM",
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),*/
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),
        elevation: 0.0,
         leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Colors.green[50], size: 30.0,),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
       /*   actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person , size: 30.0,
            color: Colors.white,),
              
              label: Text(
          "Logout",
          style: TextStyle(color: Colors.white,
          ),
        ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],*/
          toolbarHeight:80.0,
        ),
        
      body: Container( // ممكن ينشال

 decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),),

            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10), // shouldn't the bellow line be aysnc?
             child: StreamBuilder(stream: FirebaseFirestore.instance.collection("institution").where("status", isEqualTo: "pending").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) return Loading();
         return //Container( height: 50, width: 50,child: 
         new ListView.builder( 
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) =>
                buildInstitutionCard(context, snapshot.data.docs[index]),//),
                );
        }
    
      ),
    ),
    );
  }
/*
  Widget buildInstitutionCard(BuildContext context, DocumentSnapshot document) {
    //final institution = institutionList[index];
    return new Container(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
         elevation: 8, // ظل حول الكارد
         //shadowColor: Colors.green,
         shape:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), 
              borderSide: BorderSide(color: Colors.white), //BorderSide(color: Colors.green, width: 1)
          ),
              
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(document['name'], style: new TextStyle(fontSize: 30.0),),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(children: <Widget>[
                  
                    Text(document['email'], style: new TextStyle(fontSize: 30.0),),  
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(document['category'], style: new TextStyle(fontSize: 30.0),),  
                  Spacer(),
                    Icon(Icons.foundation_rounded),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }*/

    Widget buildInstitutionCard(BuildContext context, DocumentSnapshot document) {
    //final institution = institutionList[index];
    return  Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
               width: 250,
                          height: 200,
     //  child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 90.0),
                            child: myDetailsContainer1(context,document),
                          ),
                        ),
 /* child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        
                          Container(
                            margin: EdgeInsets.only(top:15),
                          width: 150,
                         // height: 100,
                          child: Column( children: <Widget>[
                          ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: //Image.asset("assets/images/logo.png",), 
                            Image(
                              fit: BoxFit.contain,
                              alignment: Alignment.topLeft,
                              image: AssetImage("assets/images/logo.png",),
                            ),
                          ),
                          Spacer(),
                          contactIcons(context,document),
                          
                          ],),),

                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 90.0),
                            child: myDetailsContainer1(context,document),
                          ),
                        ),

                        
                      ],),*/
                ),
              ),
           // ),
          );
    }
 Widget myDetailsContainer1(BuildContext context, DocumentSnapshot document) {
 return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /*
        Container( child: Padding(
          padding: EdgeInsets.only(right:60.0),
          child:*/
           Container( margin: EdgeInsets.only(top:13, left:18, ), child:  Text(document['name'],
            style: TextStyle(color: Colors.green[900], fontSize: 30.0,fontWeight: FontWeight.bold),),),//),
       // ),
       // Spacer(),
        Container(margin: EdgeInsets.only(left:18 ), child: Text(document['category'],
          style: TextStyle(color: Colors.black54, fontSize: 18.0,fontWeight: FontWeight.bold),)),
          // Spacer(),

Container( margin: const EdgeInsets.all(5),
              child: ElevatedButton.icon(
                onPressed: ()=> _checkCR(document.get("CR"),context),
                label: Text(document['CR'], style: TextStyle(color: Colors.white, fontSize: 18.0,fontWeight: FontWeight.bold),),
                icon: Icon(Icons.confirmation_num_sharp), // or assignment
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(48, 126, 80, 1) // can be changed 
                ),
              )),
    
     // Row( children: <Widget>[
        lastRow(context,document),
  ],
    );

 }
       
Widget lastRow(BuildContext context, DocumentSnapshot document){
  return Row( 
    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
contactIcons(context,document),
SizedBox(width: 6),
 institutionStatus(context,document),
  ],);//,),);
}

Widget contactIcons(BuildContext context, DocumentSnapshot document){
  return /*Container(
    // margin: EdgeInsets.only(left:15),
   // height: 50,
   // width: 1,
    child:*/
    Flexible(
     child:Row( 
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
    
    Flexible( child:
            IconButton(
          icon: const Icon(Icons.mail_outline),
          color: Colors.lightGreen[900],
          tooltip: 'Send email',
          onPressed: ()=> _sendingMails(document.get("email")),
          
          ),),
    SizedBox(width: 5),
    Flexible( child:
          SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  color: Colors.lightGreen[900],
                  press: ()=> _goToTwitter(document.get("twitter")),
                ),),
    SizedBox(width: 6),
    Flexible( child:
                IconButton(
          icon: const Icon(Icons.phone),
          color: Colors.lightGreen[900],
          onPressed: ()=> _goToWhatsapp(document.get("phone")),),),
  ],),//),
  );
}

Widget institutionStatus(BuildContext context, DocumentSnapshot document){
return 

SingleChildScrollView(
                       scrollDirection: Axis.horizontal,
                         child:
 Row( //direction: Axis.vertical,
 //alignment: WrapAlignment.end,

   children: <Widget>[
  //  Flexible(  child:
             /* Container( width:25 , 
                child:*/
 GestureDetector( onTap: (){_showMyDialog("approve", context,document.id,document); },
  child: Icon( Icons.check,
               size: 50.0,
               color: Colors.lightGreen[600],
             ), 
),

GestureDetector( onTap: (){_showMyDialog("Disapprove", context,document.id,document); },
  child: Icon( Icons.clear,
               size: 50.0,
               color: Colors.red[800],
             ), 
),

/*              IconButton(
               // padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
               iconSize: 50.0,
               icon: const Icon(Icons.check),
               color: Colors.lightGreen[600],
               onPressed: (){_showMyDialog("approve", context,document.id); },),*/ // pop up , are you sure?
//),//),
//SizedBox(width: 30),
   // Flexible(  child:
            /* Padding( padding: EdgeInsets.only(left:15),
                child:*/
            /*
              IconButton(
               // padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              iconSize: 50.0,
              icon: const Icon(Icons.clear),
              color: Colors.red[800],
              onPressed: (){ _showMyDialog("disapprove", context,document.id);},), */// pop up , are you sure?
//),//),
    
    ], ),
   );

}


Future _sendingMails(String email) async {
  String url = 'mailto:$email'; // specify mail from snapchot
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  

Future _goToTwitter(String account) async {
  String url = 'https://twitter.com/$account';
if (await canLaunch(url)) {
    await launch(url,forceWebView: true,enableJavaScript: true,
    enableDomStorage: true,);
  } else {
    throw 'Could not launch $url';
  }
}

Future _goToWhatsapp(String phone) async {
String url ="whatsapp://send?phone=$phone"; // maybe needs to be modified to api?
if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> _showMyDialog(String status, BuildContext context, String uid,DocumentSnapshot document) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Institution Status'),
        content: Text('Do you want to $status this intitution?'),
        actions: <Widget>[
          TextButton( // nothing should happen 
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: (){
                
                if(status=="approve"){
                  // change status to approved, then admin would not be able to see them 
                 String result= _auth.updateInstitutionStatus(status,uid);
                 if(result=='Success approve'){ // show another pop up 
                   print('status has changed to approved');
                  // sendEmail("YOU'VE BEEN APPROVED!!","Congratulations you've been approved to use Mostadeem app",context,document);

                 }
                 else if(result=='Fail approve'){print('could not update status, procces failed');}
                 else{ print(result);}
                }

                
                else {
                  // delete institution and send email to them to let them know 
                  String result= _auth.updateInstitutionStatus(status,uid);
                 if(result=='Success disapprove'){ // show another pop up 
                   print('intitution has been deleted');

                 }
                 else if(result=='Fail disapprove') {print('could not delete institution, procces failed');}
                  else{ print(result);}
                }
                
                Navigator.pop(context, 'OK');},
              child: const Text('Yes'),
            ),
          ],
        //),
      );
    },
  );
}

Future sendEmail(String subject, String text,BuildContext context,DocumentSnapshot document) async{
final email = 'p8713915@gmail.com';
final token='';
final smtpServer = gmailSaslXoauth2(email, token);
final message= Message()
..from = Address(email, 'Mostadeem team')
..recipients= [document.get("email")]
..subject= subject
..text= text;

try{
  await send(message, smtpServer);
}on MailerException catch (e){
  print(e);
}

}

 _checkCR(String CR, BuildContext context){
  // String url='https://mc.gov.sa/ar/eservices/Pages/Commercial-data.aspx';
     Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context)  =>
 WebView(
  javascriptMode: JavascriptMode.unrestricted,
  initialUrl: 'https://mc.gov.sa/ar/eservices/Pages/Commercial-data.aspx',
  onWebViewCreated: (WebViewController webController) {
   this.controller = webController;
  },
  
onProgress: (url){
controller.evaluateJavascript("document.getElementByTagName('header')[0].style.display='none'");
controller.evaluateJavascript("document.getElementByTagName('footer')[0].style.display='none'");
controller.evaluateJavascript("document.getElementById('ctl00_ctl74_g_3aefad74_14c7_474a_ac96_010ad3a5e1c1_ctl00_txtCRName').value='$CR'");
  },

 ),),
);

}

}// end of class

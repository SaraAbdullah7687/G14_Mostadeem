
//import 'dart:convert';

//import 'dart:html';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:test_project/Admin/components/social_icon.dart';
import 'package:test_project/components/google_auth_api.dart';
import 'package:test_project/institution/vrViewModel.dart';
import 'package:test_project/services/auth.dart';
import 'package:test_project/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';


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
        .fetchInstitutions();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> institutions = Provider.of<ViewRequestViewModel>(context, listen: false)
        .institutions;
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          centerTitle: true,
          title: Text(
          "Requests",
          style: TextStyle(
            letterSpacing:2,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
           shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(18),
      ),
    ),
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),
        elevation: 0.0,
        actions: <Widget>[
            IconButton(
              padding: EdgeInsets.only(right: 15),
              icon: Icon(Icons.logout , size: 25.0,
            color: Colors.white,),
            
              onPressed: () async {
                await _auth.signOut();
                GoogleAuthApi.signOut();
              },
            ),
          ],
          toolbarHeight:60.0, // was 80 
        ),
        
      body: /*Container( // ممكن ينشال

 decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),),

            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10), // shouldn't the bellow line be aysnc?
             child: */
             StreamBuilder(
               stream: institutions,
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
   // ),

    
    );
  }

 Widget buildInstitutionCard(BuildContext context, DocumentSnapshot document) {
    return  Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
               width: 150, // 250
               height: 160, //200
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
                            padding: const EdgeInsets.only(right: 15.0), // 90
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
            child:  Text(document['name'],
            style: TextStyle(color: Colors.green[900], fontSize: 25.0,fontWeight: FontWeight.bold),),),
           Container( margin: const EdgeInsets.all(5),
              child: ElevatedButton.icon(
                onPressed: ()=> _checkCR(document.get("CR"),context),
                label: Text(document['CR'], style: TextStyle(color: Colors.blue[400], fontSize: 18.0,fontWeight: FontWeight.bold, decoration: TextDecoration.underline ),),
                icon: Icon(Icons.receipt_long_rounded), // or assignment confirmation_num_sharp
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(48, 126, 80, 1) // can be changed 
                ),
              )),
            lastRow(context,document),
  ],
    );

 }

Widget lastRow(BuildContext context, DocumentSnapshot document){
  return Row( 
    children: <Widget>[

contactIcons(context,document),
SizedBox(width: 6),
 institutionStatus(context,document),
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
          color: Colors.lightGreen[900],
          tooltip: 'Send email',
          onPressed: ()=>  ourViewMode.sendingMails(document.get("email")),
         // _sendingMails(document.get("email")),
          
          ),),
    SizedBox(width: 12),
    Flexible( child:
          SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  color: Colors.lightGreen[900],
                  press: ()=> ourViewMode.goToTwitter(document.get("twitter")),
                ),),
    SizedBox(width: 12),
    Flexible( child:
                IconButton(
          icon: const Icon(Icons.phone),
          color: Colors.lightGreen[900],
          onPressed: ()=> ourViewMode.goToWhatsapp(document.get("phone")),),),
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
mainAxisAlignment: MainAxisAlignment.end,
   children: <Widget>[
  //  Flexible(  child:
             /* Container( width:25 , 
                child:*/
 /*GestureDetector( onTap: (){_showMyDialog("approve", context,document.id,document); },
  child: Icon( Icons.check,
               size: 40.0,
               color: Colors.lightGreen[600],
             ), 
),
*/

ElevatedButton(
    child: Text('Approve'),
    style: ElevatedButton.styleFrom(
      primary: Colors.green[400],
      onPrimary: Colors.white,
      onSurface: Colors.grey,
      padding: EdgeInsets.only(top:3 , bottom: 3, right: 10, left: 10),
    ),
    onPressed: () {
      _showMyDialog("approve", context,document.id,document);
    },
  ),
SizedBox(width: 10),

/*GestureDetector( onTap: (){_showMyDialog("Disapprove", context,document.id,document); },
  child: Icon( Icons.clear,
               size: 40.0,
               color: Colors.red[800],
             ), 
),
*/

ElevatedButton(
    child: Text('Disapprove'),
    style: ElevatedButton.styleFrom(
      primary: Colors.red[400],
      onPrimary: Colors.white,
      onSurface: Colors.grey,
      padding: EdgeInsets.all(3)
    ),
    onPressed: () {
      _showMyDialog("Disapprove", context,document.id,document);
    },

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

Future<void> _showMyDialog(String status, BuildContext context, String uid,DocumentSnapshot document) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Institution Status'),
        content: Text('Are you sure you want to $status this intitution?'),
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
                   sendEmail("approveEmail",context,document);
                   showTopSnackBar(context,'Success','Institution has been approved' );

                 }
                 else if(result=='Fail approve'){print('could not update status, procces failed');
                 showTopSnackBar(context,'Fail','Approve institution failed' );
                 }
                 else{ print(result);}
                }

                
                else {
                  // delete institution and send email to them to let them know 
                  String result= _auth.updateInstitutionStatus(status,uid);
                 if(result=='Success disapprove'){ // show another pop up 
                   print('intitution has been deleted'); // may change it
                   sendEmail("disapproveEmail",context,document);
                   showTopSnackBar(context,'Success','Institution has been disapproved' );

                 }
                 else if(result=='Fail disapprove') {
                 print('could not delete institution, procces failed');
                 showTopSnackBar(context,'Fail','Dispprove institution failed' );
                 
                 }
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

 sendEmail(String uid,BuildContext context,DocumentSnapshot document) async{
  
FirebaseFirestore.instance.collection('sendEmail').doc(uid).get().then((DocumentSnapshot emailMess) async{
final user  = await GoogleAuthApi.signIn();
print('inside sendEmail method');
if (user ==null) return;
print('inside sendEmail method after user check');
final email = user.email;
final auth= await user.authentication;
final token=auth.accessToken;
GoogleAuthApi.signOut();

print('Authenticated: $email');
final smtpServer = gmailSaslXoauth2(email, token);
final message= Message()
..from = Address(email, 'Mostadeem team')
..recipients= [document.get("email")]
..subject= emailMess['subject']
..text= '\n'+emailMess['text'] + 
'\n\n'+emailMess['details']+ 
'\n\n\n'+ emailMess['moreInfo'];

try{
  await send(message, smtpServer);

}on MailerException catch (e){
  print(e);
  
}
});
    
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

void showTopSnackBar(BuildContext context ,String title,String message) => show(
        context,
        Flushbar(
          icon: Icon(Icons.error, size: 32, color: Colors.white),
          shouldIconPulse: false,
          title: title,
          message: message, // change message
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
          borderRadius: 16,
           barBlur: 20,
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
      );

Future show(BuildContext context, Flushbar newFlushBar) async {
    await Future.wait(flushBars.map((flushBar) => flushBar.dismiss()).toList());
    flushBars.clear();

    newFlushBar.show(context);
    flushBars.add(newFlushBar);
  }
}// end of class

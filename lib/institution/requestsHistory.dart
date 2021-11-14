
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mostadeem/institution/vrViewModel.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants.dart';


class requestsHistory extends StatelessWidget { 
   @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewRequestViewModel>(
        create: (_) => ViewRequestViewModel(),
        child: Container(
            height: 1200,
            width: 450,
            child: RequestsHistory())
    );
  }
}



class RequestsHistory extends StatefulWidget {
 const RequestsHistory({
    Key key,
  }) : super(key: key);

  @override
  _RequestsHistoryState createState() => _RequestsHistoryState();
}

class _RequestsHistoryState extends State<RequestsHistory> {
  final AuthService _auth = AuthService();
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
        .fetchRequestsHistory();
   
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> reqHistory = Provider.of<ViewRequestViewModel>(context, listen: false)
        .requestsHistory;
    return Scaffold(
        backgroundColor: Colors.grey[50],
      body: 
             StreamBuilder(
               stream: reqHistory,
               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) return Loading();
        
        if (snapshot.data.docs.length==0){
          return Center(
        child: Text(
          'No requests in history',
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
            child:Text(document['reqTitle'],
            style: TextStyle(color: Colors.green[900], fontSize: 25.0,fontWeight: FontWeight.bold),),),

            Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left:12.0, top:7),
                       child: Icon(
                  Icons.person,
                  size:20,
                  color: kPrimaryColor,
                ),
                     ),
                     Container( 
            margin: EdgeInsets.only(top:9, left:5, ), 
            child:
            Text('by '+document['contName'],
            style: TextStyle(color: Colors.grey, fontSize: 12.0,),),),
                   
               // time    
            Padding(
                       padding: const EdgeInsets.only(left:35.0, top:7),
                       child: Icon(
                  Icons.category,
                  size:20,
                  color: kPrimaryColor,
                ),
                     ),
                     Container( 
            margin: EdgeInsets.only(top:10, left:5, ), 
            child:
            Text(document['category'],
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
            lastRow(context,document),
  ],
    );

 }

Widget lastRow(BuildContext context, DocumentSnapshot document){
  return Row( 
    children: <Widget>[

contactIcons(context,document),
  ],);
}

Widget contactIcons(BuildContext context, DocumentSnapshot document){
  return 
    Flexible(
     child:Row( 
        mainAxisAlignment: MainAxisAlignment.center,
       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
    
    Flexible( child:
            IconButton(
          icon: const Icon(Icons.mail_outline),
          color: kPrimaryColor,
          tooltip: 'Send email',
          onPressed: ()=>  ourViewMode.sendingMails(document.get("contEmail")),
         // _sendingMails(document.get("email")),
          
          ),),
    SizedBox(width: 50), //12
    Flexible( child:
                IconButton(
          icon: const Icon(Icons.phone),
          color: kPrimaryColor,
          onPressed: ()=> ourViewMode.goToWhatsapp(document.get("contPhone")),),),
    SizedBox(width: 50),
    Flexible( child:
                IconButton(
          icon: const Icon(Icons.location_on),
          color: kPrimaryColor,
          onPressed: ()=> ourViewMode.openLocation(document.get("location")),),),
 
  ],),//),
  );
}


}// end of class

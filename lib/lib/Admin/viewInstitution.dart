
import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_project/Screens/background.dart';
import 'package:test_project/services/auth.dart';
import 'package:test_project/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/social_icon.dart';

class ViewInstitution extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[50],
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
        backgroundColor: Colors.lightGreen[800],
        elevation: 0.0,
         leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Colors.green[50], size: 30.0,),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
          actions: <Widget>[
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
          ],
          toolbarHeight:80.0,
        ),
        
      body: Container( // ممكن ينشال

 decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),),

            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
  child: Row(
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

                        
                      ],)
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
           Container( margin: EdgeInsets.symmetric(vertical:22,horizontal: 0,), child:  Text(document['name'],
            style: TextStyle(color: Colors.green[900], fontSize: 30.0,fontWeight: FontWeight.bold),),),//),
       // ),
       // Spacer(),
        Container(child: Text(document['category'],
          style: TextStyle(color: Colors.black54, fontSize: 18.0,fontWeight: FontWeight.bold),)),
           Spacer(),
// add Commercial record

        Container(
          margin: EdgeInsets.only(left:60),
           width:100,
           height: 60,
          child:  
        Row(
          children: <Widget>[
            Flexible(  child:
GestureDetector( child:
IconButton(
  iconSize: 50.0,
          icon: const Icon(Icons.check),
          color: Colors.lightGreen[600],
          onPressed: (){ },), // pop up , are you show?
),),
Flexible(  child:
GestureDetector( child:
IconButton(
  iconSize: 50.0,
          icon: const Icon(Icons.clear),
          color: Colors.red[800],
          onPressed: (){ },), // pop up , are you show?
),),
          ],  
        ),
        ),
  ],
    );

 }
       
Widget contactIcons(BuildContext context, DocumentSnapshot document){
  return Container(
    margin: EdgeInsets.only(left:15),
     child:Row( 
  children: <Widget>[
    Flexible( child:
            IconButton(
          icon: const Icon(Icons.mail_outline),
          color: Colors.lightGreen[900],
          tooltip: 'Send email',
          onPressed: ()=> _sendingMails(document.get("email")),
          
          ),),
    Flexible( child:
          SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  color: Colors.lightGreen[900],
                  press: ()=> _goToTwitter(document.get("twitter")),
                ),),

    Flexible( child:
                IconButton(
          icon: const Icon(Icons.phone),
          color: Colors.lightGreen[900],
          onPressed: ()=> _goToWhatsapp(document.get("phone")),),),
  ],),);
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
    await launch(url);
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


Future<void> _showMyDialog(String status) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Institution Status'),
        content: const Text('Do you want to'),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('Yes'),
            ),
          ],
        //),
      );
    },
  );
}

}// end of class






/*
import 'package:flutter/material.dart';

class ViewInstitution extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 15.0),
          Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
    /*
   child: StreamBuilder(stream: FirebaseFirestore.instance.collection("institution").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) return Loading();
         return new GridView.builder( // بدون نيو؟

         crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,

            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) =>
                buildInstitutionCard(context, snapshot.data.docs[index]),);
        }
      
      ),         

*/
             
              child: GridView.count( // make it builder
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: <Widget>[
                  _buildCard('Cookie mint', '\$3.99', 'assets/cookiemint.jpg',
                      false, false, context),
                ],
              )),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }
//   Widget buildInstitutionCard(BuildContext context, DocumentSnapshot document) {
  Widget _buildCard(String name, String price, String imgPath, bool added,
      bool isFavorite, context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {/*
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CookieDetail(
                    assetPath: imgPath,
                    cookieprice:price,
                    cookiename: name
                  )));*/
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            isFavorite
                                ? Icon(Icons.favorite, color: Color(0xFFEF7532))
                                : Icon(Icons.favorite_border,
                                    color: Color(0xFFEF7532))
                          ])),
                  Hero(
                      tag: imgPath, // صورة
                      child: Container(
                          height: 75.0,
                          width: 75.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/logo.png"), // تعديل
                                  fit: BoxFit.contain)))),
                  SizedBox(height: 7.0),
                  Text(document['name'],
                      style: TextStyle(
                          color: Color(0xFFCC8053),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Text(document['name'],
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                  Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (!added) ...[
                              Icon(Icons.shopping_basket,
                                  color: Color(0xFFD17E50), size: 12.0),
                              Text('Add to cart',
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      color: Color(0xFFD17E50),
                                      fontSize: 12.0))
                            ],
                            if (added) ...[
                              Icon(Icons.remove_circle_outline,
                                  color: Color(0xFFD17E50), size: 12.0),
                              Text('3',
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      color: Color(0xFFD17E50),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0)),
                              Icon(Icons.add_circle_outline,
                                  color: Color(0xFFD17E50), size: 12.0),
                            ]
                          ]))
                ]))));
  }
}*/
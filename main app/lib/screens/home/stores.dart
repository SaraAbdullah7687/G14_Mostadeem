import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/globals/global.dart';
import 'package:mostadeem/screens/home/points.dart';
import 'package:mostadeem/screens/home/qr.dart';
import 'package:mostadeem/screens/home/viewQR.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/globals/global.dart' as globals;
import 'package:mostadeem/shared/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:mostadeem/Admin/components/social_icon.dart';



class stores extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,

        title: Text('Stores'),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
        ),
        backgroundColor: Color.fromRGBO(48, 126, 80, 1),
        elevation: 0.0,
        /* actions: <Widget>[
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
          */
        toolbarHeight: 60.0,
      ),
      body: Scaffold(
          backgroundColor: Colors.white,
                    body: 
                      StreamBuilder (
                        stream: FirebaseFirestore.instance.collection('store')
      
                         .orderBy('name')
                        .snapshots()
                        ,
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
                              return 
                              Center(
                                child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[

                                    Icon(
                                      Icons.store,
                                      color: Color.fromRGBO(48, 126, 80, 0.7),
                                      size: 100,

                                    ),

                                    Text('No available stores at the moment\n', style: TextStyle(fontSize: 18, fontWeight:FontWeight.bold,)),

                                    Text('Stay tuned for our exciting collaborators!', style: TextStyle(fontSize: 15),),







                                ] 
                              ));
                            }

     

                    return ListView(
                      children: snapshot.data.docs.map((document){
                        return  Container(
                          height: 80,
                          margin: EdgeInsets.only( top:10, left: 20, right:20, bottom:10),
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


                            
                            
                                Container(

                                  
                                  margin: EdgeInsets.only(top:10, left:25),
                                  
                                height:60,
                                width:60,
                                
                                child: 
          FutureBuilder (

          future:  _getImage(context, 'storeImages/'+cap(document['name'])),
          builder: (context, snapshot){

            try{ 

            if(snapshot.connectionState==ConnectionState.done){
              return Container(
                
                
                width: MediaQuery.of(context).size.width/1.2,
              height: MediaQuery.of(context).size.width/1.2,
              

              
              child: 
              
              snapshot.data);
            }

            if (snapshot.connectionState==ConnectionState.waiting){
              return Container(width: MediaQuery.of(context).size.width/1.2,
              height: MediaQuery.of(context).size.width/1.2,
              child: Loading());
            }
            

            return Container(child: Text('No image'));}

            catch (e){
              return 
              Container(child: Icon(
      Icons.store,
      color: Color.fromRGBO(48, 126, 80, 1),
      size: 30.0,
    ),
);
            }



          }




        )                  
                                ),

                        


                          

                          

                           


                             

                           


                           Positioned(
                            child: 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                            
                              Padding(
                            padding: EdgeInsets.fromLTRB(30, 15, 20, 8),
                            child: Text( cap(document['name']),
                            style: TextStyle(
                           fontSize: 24,
                           fontWeight: FontWeight.w900,
                           color: Color.fromRGBO(48, 126, 80, 1)
                           ),
                            )
                            ),
                            



                            



                            ]),
                           )]
                          ),


                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                             

                            Container(
                              margin: EdgeInsets.only(right:30,top:20),
                              child:
                            Flexible(
            child: SocialIcon(
              iconSrc: "assets/icons/instagram.svg",
              color: Colors.orange[700],
              press: () => _goToInstagram(document.get("instagram")),
            ),
          ),
          ),

                          ])





                          
                          ]
                          )
                        
                        );

                      }).toList(),


                    );

                        }
                        )
                        )
    );
  }
}


String cap(String s){

   return s[0].toUpperCase() + s.substring(1);




}

class FireStorageService extends ChangeNotifier   {

  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String Image) async {


    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }




}

Future _goToInstagram(String account) async {
    account=account.substring(1);
    String url = 'https://instagram.com/$account';
    print(url);

    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: true,
        enableJavaScript: true,
        enableDomStorage: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }


  Future<Widget> _getImage(BuildContext context,String imageName) async {

   Image image;
    try{
   await FireStorageService.loadImage(context, imageName).then((value){

image=Image.network(
  value.toString(),
  fit: BoxFit.scaleDown,
);
   
   });}



   catch (e){
              return 
              Container(child: Icon(
      Icons.store,
      color: Color.fromRGBO(48, 126, 80, 1),
      size: 45.0,
    ),
);
            }

   return image;


          }
   


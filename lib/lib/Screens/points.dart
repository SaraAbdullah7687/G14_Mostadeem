import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/globals/global.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/globals/global.dart' as globals;


class points extends StatefulWidget {
  @override
  State<points> createState() => _pointsState();
}

class _pointsState extends State<points> {
  final AuthService _auth = AuthService();
  





  @override
  Widget build(BuildContext context) {
     getPoints();



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,

        title: const Text('My Rewards', style: TextStyle( color: Color.fromRGBO(48, 126, 80, 1))),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: Icon(Icons.arrow_back , size: 35.0,
         color: Color.fromRGBO(48, 126, 80, 1),),
         onPressed: ()  {
                Navigator.of(context).pop();
                
              },);} ),

         
          
        toolbarHeight: 70.0,
      ),
      body: Center(

        child: Container(

          child: Column(
          children: <Widget>[
          
          Container(
          margin: EdgeInsets.only(top:0),
          height: 180,

          child: Stack(children: [
          
          Container(
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage(
              'assets/images/confetti.png'),
          fit: BoxFit.fill,
          ),)

          ),
          
          Positioned(
          
          top:30,
          left: 130,
          child: Text('Your Points',
          style: TextStyle(
          backgroundColor: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          ),
          textAlign: TextAlign.center,
          ),),
          
          Positioned(
          top:50,
          left: 118,  
          child: 
          Container(
          margin: EdgeInsets.only(top:5),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromRGBO(48, 126, 80, 1),
          ),
          child: FittedBox(
          fit: BoxFit.contain,

          
          
          child: Text(userPoints.toString(), 
          
          
          
          style: TextStyle(
          color: Colors.white,
            
          
          fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          ),),
          
          


            height: 50,
            width: 110,
            
          ),
          ),




          Positioned(
          top:110,
          left: 100,  
          child: 
          Container(
          margin: EdgeInsets.only(top:5),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromRGBO(48, 126, 80, 0.3),
          ),

          
          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[






          Text("Equivalent to "+(userPoints/5).toString()+" SAR", // Right it in the regulations 
          
          
          
          style: TextStyle(
          fontSize: 14,
          color: Color.fromRGBO(48, 126, 80, 1),
            
          
          fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          ),]),
          
            height: 30,
            width: 150,
            
          ),),


          ],),



          ),
         
          
          ]),





        ),
        
        ),
      );
    
  }
}





class TabBarDemo extends StatelessWidget {
  const TabBarDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
       DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      );
    
  }



  
}
void getPoints(){
   
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("contributor").doc(firebaseUser.uid).get().then((value){
      int points =(value.data()['points']);
      globals.userPoints=points;
      }) 
      ;}

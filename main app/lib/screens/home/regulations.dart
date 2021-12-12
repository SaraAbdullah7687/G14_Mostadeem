import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/components/google_auth_api.dart';
import 'package:mostadeem/globals/global.dart';
import 'package:mostadeem/screens/home/points.dart';
import 'package:mostadeem/screens/home/qr.dart';
import 'package:mostadeem/screens/home/viewQR.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/globals/global.dart' as globals;


class regulations extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,

        title: Text('Regulations'),

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
      body: SingleChildScrollView(

      
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
        
      
        
       Container(

         margin: EdgeInsets.only(top:40, left:100,),
         child:
       Row(
       children: <Widget>[



         Text(
          '5 ',
          style: TextStyle(
            fontSize: 30,
            color: Colors.orange[700],
            fontWeight: FontWeight.bold
          ),
        ),



       Text(
          'Points',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromRGBO(48, 126, 80, 1),
            fontWeight: FontWeight.bold

            
          ),
        ),

        Icon(
      Icons.arrow_forward,
      color: Color.fromRGBO(48, 126, 80, 1),
      size: 40.0,
      
    ),


     Text(
          '1 ',
          style: TextStyle(
            fontSize: 30,
            color: Colors.orange[700],
            fontWeight: FontWeight.bold
          ),
        ),


    Text(
          'SR',
          style: TextStyle(
            fontSize: 30,
            color: Color.fromRGBO(48, 126, 80, 1),
             fontWeight: FontWeight.bold

          ),
        ),

       ]),

       ),





        Row(



        children: <Widget>[


       Row(
       children: <Widget>[

       Container(

         width: 60,
         height:60,



         decoration: BoxDecoration(

        border: Border.all(
          width: 3,
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    
  ),


         margin: EdgeInsets.only(top:40, left:20),
       
       child: 

       Container(
         margin:EdgeInsets.only(top:5),
       
       child:Column(
           crossAxisAlignment: CrossAxisAlignment.center,

        
         children: <Widget>[

           Image.asset('assets/images/Paper.png'),


         
         ])

       )

      ),

      Container(

          margin: EdgeInsets.only(top:40, left:5),

          child: 

          Row(
       children: <Widget>[

       Icon(
      Icons.arrow_forward,
      color: Color.fromRGBO(48, 126, 80, 1),
      size: 35.0,
      
      ),


        

        Text(
          '2 ',
          style: TextStyle(
            fontSize: 25,
            color: Colors.orange[700],
            fontWeight: FontWeight.bold
          ),
        ),



       Text(
          'Points',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(48, 126, 80, 1),
            fontWeight: FontWeight.bold

            
          ),
        ),

       ]),)


       
       ]),









            Row(
       children: <Widget>[

       Container(

         width: 60,
         height:60,



         decoration: BoxDecoration(

        border: Border.all(
          width: 3,
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    
  ),


         margin: EdgeInsets.only(top:40, left:16),
       
       child: 

       Container(
       
       child:Column(
           crossAxisAlignment: CrossAxisAlignment.center,

        
         children: <Widget>[

           Image.asset('assets/images/Cardboard.png'),


         
         ])

       )

      ),

      Container(

          margin: EdgeInsets.only(top:45, left:3),

          child: 

          Row(
       children: <Widget>[

       Icon(
      Icons.arrow_forward,
      color: Color.fromRGBO(48, 126, 80, 1),
      size: 35.0,
      
      ),


        

        Text(
          '2 ',
          style: TextStyle(
            fontSize: 25,
            color: Colors.orange[700],
            fontWeight: FontWeight.bold
          ),
        ),



       Text(
          'Points',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(48, 126, 80, 1),
            fontWeight: FontWeight.bold

            
          ),
        ),

       ]),)


       
       ]),

        ]),







        Row(



        children: <Widget>[


       Row(
       children: <Widget>[

       Container(

         width: 60,
         height:60,



         decoration: BoxDecoration(

        border: Border.all(
          width: 3,
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    
  ),


         margin: EdgeInsets.only(top:40, left:20),
       
       child: 

       Container(
       
       child:Column(
           crossAxisAlignment: CrossAxisAlignment.center,

        
         children: <Widget>[

           Image.asset('assets/images/Glass.png', height:54 ),


         
         ])

       )

      ),

      Container(

          margin: EdgeInsets.only(top:40, left:5),

          child: 

          Row(
       children: <Widget>[

       Icon(
      Icons.arrow_forward,
      color: Color.fromRGBO(48, 126, 80, 1),
      size: 35.0,
      
      ),


        

        Text(
          '2 ',
          style: TextStyle(
            fontSize: 25,
            color: Colors.orange[700],
            fontWeight: FontWeight.bold
          ),
        ),



       Text(
          'Points',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(48, 126, 80, 1),
            fontWeight: FontWeight.bold

            
          ),
        ),

       ]),)


       
       ]),




            Row(
       children: <Widget>[

       Container(

         width: 60,
         height:60,



         decoration: BoxDecoration(

        border: Border.all(
          width: 3,
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    
  ),


         margin: EdgeInsets.only(top:40, left:16),
       
       child: 

       Container(
       
       child:Column(
           crossAxisAlignment: CrossAxisAlignment.center,

        
         children: <Widget>[

           Image.asset('assets/images/Plastic.png', height:54),


         
         ])

       )

      ),

      Container(

          margin: EdgeInsets.only(top:45, left:3),

          child: 

          Row(
       children: <Widget>[

       Icon(
      Icons.arrow_forward,
      color: Color.fromRGBO(48, 126, 80, 1),
      size: 35.0,
      
      ),


        

        Text(
          '2 ',
          style: TextStyle(
            fontSize: 25,
            color: Colors.orange[700],
            fontWeight: FontWeight.bold
          ),
        ),



       Text(
          'Points',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(48, 126, 80, 1),
            fontWeight: FontWeight.bold

            
          ),
        ),

       ]),)


       
       ]),

        ]),








        Row(



        children: <Widget>[


       Row(
       children: <Widget>[

       Container(

         width: 60,
         height:60,



         decoration: BoxDecoration(

        border: Border.all(
          width: 3,
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    
  ),


         margin: EdgeInsets.only(top:40, left:20),
       
       child: 

       Container(
       
       child:Column(
           crossAxisAlignment: CrossAxisAlignment.center,

        
         children: <Widget>[

           Image.asset('assets/images/Metals.png', height:54 ),


         
         ])

       )

      ),

      Container(

          margin: EdgeInsets.only(top:40, left:5),

          child: 

          Row(
       children: <Widget>[

       Icon(
      Icons.arrow_forward,
      color: Color.fromRGBO(48, 126, 80, 1),
      size: 35.0,
      
      ),


        

        Text(
          '4 ',
          style: TextStyle(
            fontSize: 25,
            color: Colors.orange[700],
            fontWeight: FontWeight.bold
          ),
        ),



       Text(
          'Points',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(48, 126, 80, 1),
            fontWeight: FontWeight.bold

            
          ),
        ),

       ]),)


       
       ]),




            Row(
       children: <Widget>[

       Container(

         width: 60,
         height:60,



         decoration: BoxDecoration(

        border: Border.all(
          width: 3,
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    
  ),


         margin: EdgeInsets.only(top:40, left:16),
       
       child: 

       Container(
       
       child:Column(
           crossAxisAlignment: CrossAxisAlignment.center,

        
         children: <Widget>[

           Image.asset('assets/images/Electronics.png', height:54),


         
         ])

       )

      ),

      Container(

          margin: EdgeInsets.only(top:45, left:3),

          child: 

          Row(
       children: <Widget>[

       Icon(
      Icons.arrow_forward,
      color: Color.fromRGBO(48, 126, 80, 1),
      size: 35.0,
      
      ),


        

        Text(
          '4 ',
          style: TextStyle(
            fontSize: 25,
      color: Colors.orange[700],
            fontWeight: FontWeight.bold
          ),
        ),



       Text(
          'Points',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(48, 126, 80, 1),
            fontWeight: FontWeight.bold

            
          ),
        ),

       ]),)


       
       ]),

        ]),








        Row(



        children: <Widget>[


       Row(
       children: <Widget>[

       Container(

         width: 60,
         height:60,



         decoration: BoxDecoration(

        border: Border.all(
          width: 3,
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    
  ),


         margin: EdgeInsets.only(top:40, left:20),
       
       child: 

       Container(
       
       child:Column(
           crossAxisAlignment: CrossAxisAlignment.center,

        
         children: <Widget>[

           Image.asset('assets/images/Nylon.png', height:54 ),


         
         ])

       )

      ),

      Container(

          margin: EdgeInsets.only(top:40, left:5),

          child: 

          Row(
       children: <Widget>[

       Icon(
      Icons.arrow_forward,
      color: Color.fromRGBO(48, 126, 80, 1),
      size: 35.0,
      
      ),


        

        Text(
          '2 ',
          style: TextStyle(
            fontSize: 25,
            color: Colors.orange[700],
            fontWeight: FontWeight.bold
          ),
        ),



       Text(
          'Points',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(48, 126, 80, 1),
            fontWeight: FontWeight.bold

            
          ),
        ),

       ]),)


       
       ]),




            Row(
       children: <Widget>[

       Container(

         width: 60,
         height:60,



         decoration: BoxDecoration(

        border: Border.all(
          width: 3,
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    
  ),


         margin: EdgeInsets.only(top:40, left:16),
       
       child: 

       Container(
       
       child:Column(
           crossAxisAlignment: CrossAxisAlignment.center,

        
         children: <Widget>[

           Image.asset('assets/images/Cans.png', height:54),


         
         ])

       )

      ),

      Container(

          margin: EdgeInsets.only(top:45, left:3),

          child: 

          Row(
       children: <Widget>[

       Icon(
      Icons.arrow_forward,
      color: Color.fromRGBO(48, 126, 80, 1),
      size: 35.0,
      
      ),


        

        Text(
          '3 ',
          style: TextStyle(
            fontSize: 25,
            color: Colors.orange[700],
            fontWeight: FontWeight.bold
          ),
        ),



       Text(
          'Points',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(48, 126, 80, 1),
            fontWeight: FontWeight.bold

            
          ),
        ),

       ]),)


       
       ]),

        ]),









        Row(



        children: <Widget>[


       Row(
       children: <Widget>[

       Container(

         width: 60,
         height:60,



         decoration: BoxDecoration(

        border: Border.all(
          width: 3,
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    
  ),


         margin: EdgeInsets.only(top:40, left:20),
       
       child: 

       Container(
       
       child:Column(
           crossAxisAlignment: CrossAxisAlignment.center,

        
         children: <Widget>[

           Image.asset('assets/images/Batteries.png', height:54 ),


         
         ])

       )

      ),

      Container(

          margin: EdgeInsets.only(top:40, left:5),

          child: 

          Row(
       children: <Widget>[

       Icon(
      Icons.arrow_forward,
      color: Color.fromRGBO(48, 126, 80, 1),
      size: 35.0,
      
      ),


        

        Text(
          '8 ',
          style: TextStyle(
            fontSize: 25,
            color: Colors.orange[700],
            fontWeight: FontWeight.bold
          ),
        ),



       Text(
          'Points',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(48, 126, 80, 1),
            fontWeight: FontWeight.bold

            
          ),
        ),

       ]),)


       
       ]),




            Row(
       children: <Widget>[

       Container(

         width: 60,
         height:60,



         decoration: BoxDecoration(

        border: Border.all(
          width: 3,
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    
  ),


         margin: EdgeInsets.only(top:40, left:16),
       
       child: 

       Container(
       
       child:Column(
           crossAxisAlignment: CrossAxisAlignment.center,

        
         children: <Widget>[

           Image.asset('assets/images/Furniture.png', height:54),


         
         ])

       )

      ),

      Container(

          margin: EdgeInsets.only(top:45, left:3),

          child: 

          Row(
       children: <Widget>[

       Icon(
      Icons.arrow_forward,
      color: Color.fromRGBO(48, 126, 80, 1),
      size: 35.0,
      
      ),


        

        Text(
          '10 ',
          style: TextStyle(
            fontSize: 20,
            color: Colors.orange[700],
            fontWeight: FontWeight.bold
          ),
        ),



       Text(
          'Points',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(48, 126, 80, 1),
            fontWeight: FontWeight.bold

            
          ),
        ),

       ]),)


       
       ]),

        ]),







        Row(



        children: <Widget>[


       Row(
       children: <Widget>[

       Container(
         width: 60,
         height:60,



         decoration: BoxDecoration(

        border: Border.all(
          width: 3,
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    
  ),


         margin: EdgeInsets.only(top:30, left:20, bottom:10),
       
       child: 

       Container(
       
       child:Column(
           crossAxisAlignment: CrossAxisAlignment.center,

        
         children: <Widget>[

           Image.asset('assets/images/Clothes.png', height:54 ),


         
         ])

       )

      ),

      Container(

          margin: EdgeInsets.only(top:20, left:5),

          child: 

          Row(
       children: <Widget>[

       Icon(
      Icons.arrow_forward,
      color: Color.fromRGBO(48, 126, 80, 1),
      size: 35.0,
      
      ),


        

        Text(
          '8 ',
          style: TextStyle(
            fontSize: 25,
            color: Colors.orange[700],
            fontWeight: FontWeight.bold
          ),
        ),



       Text(
          'Points',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(48, 126, 80, 1),
            fontWeight: FontWeight.bold

            
          ),
        ),

       ]),)


       
       ]),




            Row(
       children: <Widget>[

       Container(

         width: 60,
         height:60,



         decoration: BoxDecoration(

        border: Border.all(
          width: 3,
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
    
  ),


         margin: EdgeInsets.only(top:30, left:16, bottom:10),
       
       child: 

       Container(
       
       child:Column(
           crossAxisAlignment: CrossAxisAlignment.center,

        
         children: <Widget>[

           Image.asset('assets/images/Food.png', height:54),


         
         ])

       )

      ),

      Container(

          margin: EdgeInsets.only(top:20, left:3,),

          child: 

          Row(
       children: <Widget>[

       Icon(
      Icons.arrow_forward,
      color: Color.fromRGBO(48, 126, 80, 1),
      size: 35.0,
      
      ),


        

        Text(
          '2 ',
          style: TextStyle(
            fontSize: 25,
            color: Colors.orange[700],
            fontWeight: FontWeight.bold
          ),
        ),



       Text(
          'Points',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(48, 126, 80, 1),
            fontWeight: FontWeight.bold

            
          ),
        ),

       ]),)


       
       ]),

        ]),











       

       
        ])));
  }
}



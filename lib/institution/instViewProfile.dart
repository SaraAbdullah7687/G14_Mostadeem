import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/Admin/components/social_icon.dart';
import 'package:mostadeem/constants.dart';
import 'package:mostadeem/institution/vrViewModel.dart';

class InstViewProfile extends StatelessWidget {
final ViewRequestViewModel ourViewMode=ViewRequestViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          topWidget(context),
          bottomWidget(context),
          Positioned(
            top: MediaQuery.of(context).size.height * .5 -(MediaQuery.of(context).size.width*.2),
            left: MediaQuery.of(context).size.width * .35, 
            
            child: Container(
              width: MediaQuery.of(context).size.width * .3,
              height: MediaQuery.of(context).size.width * .3,
             
              child: ClipOval(
                child: Image(
                  image: AssetImage("assets/images/instPhoto.png"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget topWidget(BuildContext context){
return Container(
  width: MediaQuery.of(context).size.width,
  height:MediaQuery.of(context).size.height * .6, // maybe width
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/shapes2.png'),
      fit: BoxFit.cover,
    ),
  ),
);
  }

Widget bottomWidget(BuildContext context){
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      height:MediaQuery.of(context).size.height * .5, // maybe width
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight:Radius.circular(40), 
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            offset: Offset(0,-4),
            blurRadius: 8,
        ),
       ],
    ),
    child: bottomWidgetContent(context),
  ),
  );
}

Widget bottomWidgetContent(BuildContext context){ // bring from DB using inst UID
  return Column( // do we add button for initiate req??
   children: [
// Name
instName(),
// Rating
instRating(),
// Category
Padding(
  padding: const EdgeInsets.only(top:45),
  child:   listViewCat(context),
),
// Social media
//Spacer(),
SizedBox(height: 40,),
contactIcons(),
  ],
  );
}
Widget instName(){
  return Padding(
  padding: const EdgeInsets.only(
    top: 30,
    left: 30,// maybe i'll make it center
    right: 30,
  ),
    child: Text('Ehsan Org',
    style: TextStyle(color:kPrimaryColor, fontSize: 35.0,fontWeight: FontWeight.bold),
    ),
  
  );
}
Widget instRating(){
  return Text('rating');
}
Widget instCategory(){
  // bring photos of each cat, make them into listView
  return Container( 
                margin: EdgeInsets.only(top:7, left:5,//left:18, 
                ), 
                child:  Text("paper, glass",//document['category'],
                style: TextStyle(color: Colors.grey, fontSize: 12.0,),),);
}
Widget contactIcons(){
    return  Flexible(
     child:Row( 
        mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Flexible( child:
            IconButton(
          icon: const Icon(Icons.mail_outline),
          color: kPrimaryColor,
          tooltip: 'Send email',
          iconSize: 30,
          onPressed: (){}//=>  ourViewMode.sendingMails(document.get("email")),
          ),),
    SizedBox(width: 30),
    Flexible( child:
          Container(
            height: 30,
            width: 30,
            child: SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    color: kPrimaryColor,
                    
                    press: (){}//=> ourViewMode.goToTwitter(document.get("twitterAccount")),
                  ),
          ),),
    SizedBox(width: 30),
    Flexible( child:
                IconButton(
          icon: const Icon(Icons.phone),
          color: kPrimaryColor,
          iconSize: 30,
          onPressed: (){}//=> ourViewMode.goToWhatsapp(document.get("phone")),
          ),),
 
  ],),//),
  );
}

//there is maybe an error in the scrollbar
Widget listViewCat(BuildContext context){
final scrollController = ScrollController(initialScrollOffset: 0);
List<String> category =  ["Paper", "Plastic","Paper","Plastic"];
return Container( // see Nouf
alignment: Alignment.center,
padding: EdgeInsets.only(left: 50, right: 50),
   height: 100,
  child:Scrollbar(
    isAlwaysShown: true,
    child:ListView.builder(
      controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: category.length,
              itemBuilder: (BuildContext context, int index) {
                return getListView(category,index);
              }),
),);
}

Widget getListView(List<String> category,int index){
  return  Container(
      width: 100,
      height: 100,
      child: Image.asset(
       "assets/images/" + category[index] + '.png'),
    );;

}

}
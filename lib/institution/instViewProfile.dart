import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mostadeem/Admin/components/social_icon.dart';
import 'package:mostadeem/Admin/viViewModel.dart';
import 'package:mostadeem/constants.dart';
import 'package:mostadeem/institution/vrViewModel.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/services/database.dart';
import 'package:provider/provider.dart';

class InstViewProfile extends StatelessWidget {
final ViewInstitutionViewModel ourViewMode=ViewInstitutionViewModel(); // use the other one in admin class
String UID='CXbJCQp7PhZRveFPvp6G6j0uG4o2'; // يجي من افنان
AuthService auth = AuthService();
DatabaseService db = DatabaseService();
/*
@override
  void initState() {
    setup();
  }
  setup() async {
  // await Provider.of<ViewInstitutionViewModel>(context, listen: false)
   //     .fetchInstProfile(UID);
  }*/
  @override
Widget build(BuildContext context) {
  //Stream<DocumentSnapshot> instProfile = Provider.of<ViewInstitutionViewModel>(context, listen: false)
  //.instProfile;
    return Scaffold(
      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection('institution').doc(UID).snapshots(),
        builder: (context, snapshot) {
           if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;
          return Stack(
            children: [
              topWidget(context),
              bottomWidget(context,userDocument),
              Positioned(
                top: MediaQuery.of(context).size.height * .43 -(MediaQuery.of(context).size.width*.2),
                left: MediaQuery.of(context).size.width * .26, 
                
                child: Container(
                  width: MediaQuery.of(context).size.width * .5,
                  height: MediaQuery.of(context).size.width * .5,
                 
                 /// child: ClipOval(
                    child: Image(
                      image: AssetImage("assets/images/org2.png"),
                    ),
                  //),
                ),
              ),
            ],
          );
        }
      ),
    );
  }

Widget topWidget(BuildContext context){
return Container(
  width: MediaQuery.of(context).size.width,
  height:MediaQuery.of(context).size.height * .6, // maybe width
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/greenBG.png'),
      fit: BoxFit.cover,
    ),
  ),
);
  }

Widget bottomWidget(BuildContext context, dynamic userDocument){
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
    child: bottomWidgetContent(context,userDocument),
  ),
  );
}

Widget bottomWidgetContent(BuildContext context,dynamic userDocument){ // bring from DB using inst UID
  return Column( // do we add button for initiate req??
   children: [
// Name
Padding(
  padding: const EdgeInsets.only(top:50),
  child:   instName(userDocument),
),
// Rating
Padding(
  padding: const EdgeInsets.only(top:25),
  child:   instRating(userDocument),
),
// Category
Padding(
  padding: const EdgeInsets.only(top:10),
  child:   listViewCatVesion2(context,userDocument),
),
// Social media
Padding(
  padding: const EdgeInsets.only(top:15),
  child:   contactIcons(userDocument),
),
  ],
  );
}
Widget instName(dynamic userDocument){
  return Text(userDocument['name'],
    style: TextStyle(color:kPrimaryColor, fontSize: 35.0,fontWeight: FontWeight.bold),
    );
}
Widget instRating(dynamic userDocument){
   double ratesAverage = 0;
          List<String> rates = null;
          rates = userDocument['rates'].split(",");
          int ratesL = rates.length - 1; // why -1 ?
          print("The length of my array is $ratesL");
          for (var i = 0; i < ratesL; i++) {
            ratesAverage = ratesAverage + double.parse(rates[i]);
          }
          ratesAverage = ratesAverage / (ratesL);
          print("the average is: $ratesAverage");
         return RatingBarIndicator(
           itemSize: 30,
                      rating: ratesAverage,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),);
 
}

Widget contactIcons(dynamic userDocument){
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
          onPressed: ()=>  ourViewMode.sendingMails(userDocument["email"]),
          ),),
    SizedBox(width: 40),
    Flexible( child:
          Container(
            height: 30,
            width: 30,
            child: SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    color: kPrimaryColor,
                    
                    press: ()=> ourViewMode.goToTwitter(userDocument["twitterAccount"]),
                  ),
          ),),
    SizedBox(width: 40),
    Flexible( child:
                IconButton(
          icon: const Icon(Icons.phone),
          color: kPrimaryColor,
          iconSize: 30,
          onPressed: ()=> ourViewMode.goToWhatsapp(userDocument["phone"]),
          ),),
 
  ],),//),
  );
}

//there is maybe an error in the scrollbar
Widget listViewCat(BuildContext context,dynamic userDocument){
final scrollController = ScrollController(initialScrollOffset: 0);
List<String> category =  convertStringToArray(userDocument['category']);
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
  return  Center(
      
      child: Image.asset(
       "assets/images/" + category[index] + '.png',
       fit: BoxFit.fill,
       width: 85,
       height: 85,),
    );

}

List<String> convertStringToArray(String category){

var list = category.split(',');
int len=list.length;
int start=1;
if(len>1){ // more than 1 category
for (start; start<len;start++){//elminate white space from the Beginning of each category
list[start]= list[start].substring(1);

}
}
return list;
}

Widget listViewCatVesion2(BuildContext context,dynamic userDocument){
List<String> category =  convertStringToArray(userDocument['category']);
print(category);
return 
  Container( // see Nouf
  alignment: Alignment.center,
  padding: EdgeInsets.only(left: 50, right: 50),
     height: 120,
      child:Center(child:ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: category.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(child: getListView(category,index));
                }),),

);
}


}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mostadeem/institution/vrViewModel.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants.dart';


class currentRequestsView extends StatelessWidget { 
   @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewRequestViewModel>(
        create: (_) => ViewRequestViewModel(),
        child: Container(
            height: 1200,
            width: 450,
            child: ViewCurrentRequests())
    );
  }
}



class ViewCurrentRequests extends StatefulWidget {
 const ViewCurrentRequests({
    Key key,
  }) : super(key: key);

  @override
  _ViewCurrentRequestsState createState() => _ViewCurrentRequestsState();
}

class _ViewCurrentRequestsState extends State<ViewCurrentRequests> {
  final AuthService _auth = AuthService();
 // List<Widget> myDialogWidgets=[];
 // String valueCat;
 // List<String> categoryValue=[];
 // int widgetsCount=0;// count newly added widgets
  int itemCount=0;
 // List<int> counterForItems=[]; // ممكن مكانها مو هنا
final ScrollController _controllerOne = ScrollController();


 //final List<Flushbar> flushBars = []; 
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
        .fetchCurrentRequests();
  }
 

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> institutions = Provider.of<ViewRequestViewModel>(context, listen: false)
        .currentRequests;
    return Scaffold(
        backgroundColor: Colors.grey[50],
      body: 
             StreamBuilder(
               stream: institutions,
               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) return Loading(); // no data yet
         //return //Container( height: 50, width: 50,child: 
        if (snapshot.data.docs.length==0){
          return Center(
        child: Text(
          'No accepted requests',
          style: TextStyle(fontSize: 20, color: Colors.grey,),
        ),
      );
        }
        
        else return
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
            padding: const EdgeInsets.only(left:20,right:20,top:20,),
            child: Container(
               width: 120, // 250 150
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
                            padding: const EdgeInsets.only(right: 7), // 90 //15
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
           Container( // bring the name from another stream
            margin: EdgeInsets.only(top:13, left:18, ), 
            child:  Text(document['reqTitle'],
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
//SizedBox(width: 6),
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
          onPressed: ()=>  ourViewMode.sendingMails(document.get("contEmail")),
         // _sendingMails(document.get("email")),
          
          ),),
    SizedBox(width: 12),
    Flexible( child:
                IconButton(
          icon: const Icon(Icons.phone),
          color: kPrimaryColor,
          onPressed: ()=> ourViewMode.goToWhatsapp(document.get("contPhone")),),),
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

var listOfCat=convertStringToArray(document['category']);
//List<int> counterForItems= List<int> (listOfCat.length);
List<int> counterForItems=List.filled(listOfCat.length, 0);
return 

SingleChildScrollView(
                       scrollDirection: Axis.horizontal,
                         child:
 Padding(
   padding: const EdgeInsets.only(right:3,),
   child: Row( //direction: Axis.vertical,
   //alignment: WrapAlignment.end,
mainAxisAlignment: MainAxisAlignment.end,
     children: <Widget>[
Padding(
    padding: const EdgeInsets.only(right: 10),
    child: 
    ElevatedButton(
        child: Text('Done'),
        style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
               borderRadius: new BorderRadius.circular(30.0),
               ),
          primary: kPrimaryColor, //Colors.green[400],
          onPrimary: Colors.white,
          onSurface: Colors.grey,
          padding: EdgeInsets.only(top:3 , bottom: 3, right: 5, left: 5),
        ),
        onPressed: () {
          openDialog("complete",context,listOfCat,counterForItems,document['contribId'],document,); //هذي المعتمدة ، رجعيها
         
        },
      ),
),
/*
ElevatedButton.icon(
                  onPressed: (){},
                  label: Text("Done", style: TextStyle(color: Colors.white,
                   ),),
                  icon: Icon(Icons.check),
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor
                  ),
                )
*/
      ], ),
 ),
   );

}



Future openDialog(String status,BuildContext context, List<String> listOfCat,List<int> counterForItems,String contID,DocumentSnapshot document) async => showDialog(

context: context,
builder: (context)=>StatefulBuilder(
  builder: (context, setState) {
  return  AlertDialog(
    contentPadding: EdgeInsets.zero,
     shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(padding1),
        ),
    title: Center(
      child: Text("Number of items",style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
              color: kPrimaryColor, // added 
            ),
          ),
    ),
  
    content: Container(
      
      margin: EdgeInsets.only(top:20,left:20,right:20),
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: new Color.fromRGBO(48, 126, 80, 0.2),
        borderRadius: BorderRadius.all(
        Radius.circular(10.0) //                 <--- border radius here
    ),
      ),
      
           // width: MediaQuery.of(context).size.width / 1.3,
           // height: MediaQuery.of(context).size.height / 2.5,
           /* decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color(0xFFFFFF),
              borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
            ),*/
            child:dialogContent(context,listOfCat,counterForItems), ),
            actions: [
           
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.grey),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(width: 0, color: Colors.transparent),
                            ))
                          ),
                          child: Text("Cancle", style: TextStyle(fontSize:15, color: Colors.white),),
                          onPressed:()  {
                Navigator.pop(context, 'OK');
              } ,
                          
                        ),
          
SizedBox(width: 20,),

           ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.orange[700]),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(width: 0, color: Colors.transparent),
                            ))
                          ),
                          child: Text("Submit", style: TextStyle(fontSize:15, color: Colors.white),),
                          onPressed:() async {
                String result= await ourViewMode.countPoints(status,listOfCat,counterForItems,contID,context,document,document.id);
                /*if (result=="points updated"){
                  ourViewMode.showTopSnackBar(context,'Success','Request has been marked as done',Icons.check );
  
                }else*/ // points not updated
               // ourViewMode.showTopSnackBar(context,'Couldn\'t mark the request','An error occurred while marking the request',Icons.cancel_outlined, );
             Navigator.pop(context, 'OK');
              } ,
                          
                        ),
          
        ],
      ),
    ],
  
  );
  },),
);// end of show 

Widget dialogContent(BuildContext context,List<String> listOfCat,List<int> counterForItems){
var len=listOfCat.length;
return  SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.min, 
                  crossAxisAlignment: CrossAxisAlignment.stretch, // may change
                  children: <Widget>[
                  //_card(listOfCat,counterForItems),
                  Container( // don't make the size static
                    height: 110,
                    width: 110,
                    child: Scrollbar(
                      controller: _controllerOne,
                      isAlwaysShown: true,
                      child: ListView.builder(
                      controller: _controllerOne,
                      itemCount:len ,
                      itemBuilder: (BuildContext context, int index) {
                       return ListTile(
                        leading: Image.asset( // المشكلة الكاتيقوري بالطلب اول حرف يجي سمول
                                "assets/images/" + capitalize(listOfCat[index]) + '.png',
                                fit: BoxFit.fill,
                                width: 65,
                                height: 65,),
                        /*title: Text(listOfCat[index],style:TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: kPrimaryColor, // added 
                        ),
                      ),*/
                        trailing: counterItems(index,counterForItems),);}
                      ),
                    ),
                  ),
                  ],
                ),
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

Widget counterItems(int index,List<int> counterForItems){

  return StatefulBuilder(
   builder: (context, setState) {
  return Container(
                    width: 100, // 60
                    height: 32, // 32
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kPrimaryColor),//Theme.of(context).accentColor),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {/*decrement(counterForItems,index);*/
                            counterForItems[index]!=0? setState(()=>counterForItems[index]--): null;},
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 16,
                            )),
                        Container(
                          height: 25,
                          width: 32,
                          margin: EdgeInsets.symmetric(horizontal: 14), //3 
                          padding:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 1), // hor 3
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white),
                          child:
                            Center(
                              child: Text(counterForItems[index].toString(),
                              style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                            ),
                        ),  
                        InkWell(
                            onTap: () {/*increment(counterForItems,index);*/
                            setState(()=>counterForItems[index]++);},
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            )),
                      ],
                    ),
                  );
   });





}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

}// end of class




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
  List<Widget> myDialogWidgets=[];
  String valueCat;
  int widgetsCount=0;// count newly added widgets
  int itemCount=0;
  
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
            child:  Text(document['contName'],
            style: TextStyle(color: Colors.green[900], fontSize: 25.0,fontWeight: FontWeight.bold),),),

            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                       padding: const EdgeInsets.only(left:12.0, top:7),
                       child: Icon(
                  Icons.category,
                  size:20,
                  color: kPrimaryColor,
                ),
                     ),
                Container( 
                margin: EdgeInsets.only(top:7, left:5,//left:18, 
                ), 
                child:  Text(document['category'],
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
          openDialog(context,document['category'],);
         // ourViewMode.showMyDialog("done", context,document.id,document);
         //ourViewMode.showCustomAlert("done", "Are you sure you want to mark this request as done?", context, document.id, document);
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



Future openDialog(BuildContext context, String category) => showDialog(

context: context,
builder: (context)=>AlertDialog(
  title: Text("Number of items"),
  content: dialogContent(category),
  actions: [
    TextButton(
      child: Text('Submit'),
      onPressed:(){} , // save data to FB
    )
  ],

),
);// end of show 

Widget dialogContent(String category){

int numOfCat;// maybe in class declare
var listOfCat=convertStringToArray(category);

      for(int i=0; i< listOfCat.length; i++){ // check cond
      numOfCat+=1;
      }

return  SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, // may change
                  children: <Widget>[
                  initialContent(listOfCat),
                    

                   numOfCat == widgetsCount+1 ? null: // else show + button, بس كذا راح يروح الماينس بوتن بعد

        widgetsCount!=0? new  IconButton(icon: new Icon(Icons.remove),
        onPressed: (){
          // and delete widget
        dynamicWidgets('remove',listOfCat);  
        setState(()=>widgetsCount--);})

        :new Container(), // وmeybe delete it
        new IconButton(icon: new Icon(Icons.add),
        onPressed: () { 
          dynamicWidgets('add',listOfCat);
          setState(()=>widgetsCount++); }),

                  ],
                ),
);

}

convertStringToArray(String category){

var list = category.split(',');

}

void dynamicWidgets(String status,var listOfCat){
int index=myDialogWidgets.length;

  setState(() {
    if(status=='add'){
    myDialogWidgets.add(initialContent(listOfCat));}
    else
    myDialogWidgets.removeAt(index);
  }); 

}

Widget _card() {

}

Widget initialContent(var listOfCat){

return Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children:<Widget> [
    Container(
      width: 200,
      padding: EdgeInsets.only(left:10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color:kPrimaryColor, width:1)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          iconSize: 20,
          icon: Icon(Icons.arrow_drop_down, color:kPrimaryColor,),
          isExpanded: true,// change ir later
          value: valueCat,
          items: listOfCat.map(buildMenuItem).toList(),
          onChanged: (value)=> setState(()=> value=valueCat),
          ),
      ),
    )
,
 itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>itemCount--),):new Container(),
            new Text(itemCount.toString()),
            new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>itemCount++))
        

],);
}

DropdownMenuItem<String> buildMenuItem(String item)=>DropdownMenuItem(
  value: item,
  child: Text(item,
              style:TextStyle(fontSize: 12), ),

);

}// end of class

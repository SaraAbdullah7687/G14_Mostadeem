
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mostadeem/components/customAlert.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:mostadeem/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';

class ViewRequestViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> _requests;
  Stream<QuerySnapshot<Map<String, dynamic>>> _currentRequests;
  Stream<QuerySnapshot<Map<String, dynamic>>> _contInfo;
  AuthService auth=AuthService();
  final List<Flushbar> flushBars = []; 
  final AuthService _auth = AuthService();

  fetchRequests() async {
    String uid= auth.getCurrentUserID();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    print(uid+ "in view model");
    var firebase=  FirebaseFirestore.instance
        .collection("institution")
        .doc(uid)
        .collection("appointment");
    _requests =
        firebase.where("status", isEqualTo: "pending").where("date", isGreaterThanOrEqualTo: dateFormat.format(DateTime.now()), ).orderBy("date").snapshots(); // order by  + exclude old dates
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get requests {
    return _requests;
  }

  fetchCurrentRequests() async {
    String uid= auth.getCurrentUserID();
    print(uid+ "in view model current");
    var firebase=  FirebaseFirestore.instance
        .collection("institution")
        .doc(uid)
        .collection("appointment");
    _currentRequests =
        firebase.where("status", isEqualTo: "accepted").orderBy("date").snapshots(); // order by  + exclude old dates
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get currentRequests {
    return _currentRequests;
  }

Future sendingMails(String email) async {
  print("in view model hii ");
  String url = 'mailto:$email'; // specify mail from snapchot
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future openLocation(Map location) async {
print("in view model openLocation ");
print(location['geopoint'].latitude);
final String lat=location['geopoint'].latitude.toString();
final String lng=location['geopoint'].longitude.toString();
final String googleMapsUrl= 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

if (await canLaunch(googleMapsUrl)) {
    await launch(googleMapsUrl);
  } else {
    throw 'Could not launch $googleMapsUrl';
  }

}

Future goToWhatsapp(String phone) async {
 String newPhone= phone.substring(1);
String url ="whatsapp://send?phone=+966$newPhone"; // maybe needs to be modified to api?
if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

String convertDate(BuildContext context, DocumentSnapshot document){
  String date = document['date'].toString().substring( 0,10);
return date;
}

String convertTime(BuildContext context, DocumentSnapshot document){
  String before = document['time'].toString().substring(10); //9
  String time = before.substring(0,5); 
return time;
}

Future<void> showMyDialog(String status, BuildContext context, String uid,DocumentSnapshot document) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Request Status'),
        content: Text('Are you sure you want to $status this request?'),
        actions: <Widget>[
          TextButton( // nothing should happen 
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: (){
                  //accepted
                /* String result= _auth.updateInstitutionStatus(status,uid); // chsnge method
                 if(result=='Success approve'){ // show another pop up 
                   print('status has changed to approved');
                   sendEmail("approveEmail",context,document);
                   showTopSnackBar(context,'Success','Request has been moved to appoinments' );

                 }
                 else if(result=='Fail approve'){print('could not update status, procces failed');
                 showTopSnackBar(context,'Fail','Approve institution failed' );
                 }
                 else{ print(result);}*/
                
                Navigator.pop(context, 'OK');},
              child: const Text('Yes'),
            ),
          ],
        //),
      );
    },
  );
}

void showTopSnackBar(BuildContext context ,String title,String message, IconData icon) => show(
        context,
        Flushbar(
          icon: Icon(icon, size: 32, color: Colors.white),
          shouldIconPulse: false,
          title: title,
          message: message, // change message
          borderRadius: BorderRadius.circular(6),
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        //  margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
          
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

showCustomAlert(String status,String content, BuildContext context, String uid,DocumentSnapshot document) async {

  showDialog(
                    context: context,
                    builder: (BuildContext context) {
return CustomAlert(
      icon:Icons.error_outline,
      msgTitle: "Request Status\n",
      msgContent:content,
      press:()  async { 
        if(status=="accept"){ // then update status in both institution & contributor, and make the same request in other instituton as rejected
        // send appointment doc id, and get inst id from auth class 
        String result= _auth.updateAppointmentStatus(status,uid);// appointment id
        if(result=='Success accept'){ 
         String re2= _auth.updateRequestStatus(status,document['contribId'],document['requestID'] ); // تأكدي من اسامي الفيلدز
        
         if(re2=='accepted'){ // change status to rejected in other institutions
           String re3= await DatabaseService().updateRequestStatusInAllInst(status,document['requestID'] );
           print(re3);
           if(re3== "success"){
             print("re3 Succeeded");
           showTopSnackBar(context,'Success','Request has been accepted',Icons.check );
           }
           else if(re3=='fail'){
             print("re3 failed");
             showTopSnackBar(context,'Couldn\'t accept request','The request couldn\'t been accepted',Icons.cancel_outlined, );
           }
           else if (re3=="no doc with same req"){
            showTopSnackBar(context,'Success','Request has been accepted',Icons.check );
           }
           else{
             showTopSnackBar(context,'Fail','An error occured while accepthing the request',Icons.cancel_outlined, );
             print(re3+' did not work');
           }
         }
         else if(re2=='failed'){
           print('could not update status, procces failed');
           showTopSnackBar(context,'Fail','Accept request failed',Icons.cancel_outlined, );
         }
         else print(re2);
                   
                 }
        else if(result=='Fail accept'){print('could not update status, procces failed');
                 showTopSnackBar(context,'Fail','Accept request failed',Icons.cancel_outlined, );
                 }
        else{ print(result);}
        }// if accept
    
    
    
    else if(status=="reject"){

        // delete appointment from this inst
        String result= _auth.updateAppointmentStatus(status,uid);// appointment id
        if(result=='Success reject'){  
       // check if  there's an instition that has the same request or not 
        String re3= await DatabaseService().updateRequestStatusInAllInst(status,document['requestID'] ); 
           if(re3=='No inst has the request'){ // change status to rejected in req collection
         print(re3);
           String re2= _auth.updateRequestStatus(status,document['contribId'],document['requestID'] );
               if(re2== "Success reject"){
             print("re2 Succeeded reject");
           showTopSnackBar(context,'Success','Request has been rejected',Icons.check );
           }
               else if(re2=='Fail reject'){
             print("re3 failed");
             showTopSnackBar(context,'Fail','An error occured while rejecting the request',Icons.cancel_outlined, );
           }
               else{
             print(re2+' did not work');
             showTopSnackBar(context,'Fail','An error occured while rejecting the request',Icons.cancel_outlined, );
           }
         }
           else if(re3=='There is inst has the request'){// there is inst that have the same req
           print('there is inst that have the same req');
         }
            else print(re3);
                   
                 }
        else if(result=='Fail reject'){print('could not update status, procces failed');
                 showTopSnackBar(context,'Fail','An error occured while rejecting the request',Icons.cancel_outlined, );
                 }
        else{ print(result);}

}


    else { // status == done
    String result= _auth.updateAppointmentStatus(status,uid);// appointment id
    if(result=='Success done'){
       String re2= _auth.updateRequestStatus(status,document['contribId'],document['requestID'] ); // تأكدي من اسامي الفيلدز
        if(re2=='done'){ // change status to rejected in other institutions
           showTopSnackBar(context,'Success','Request has been marked as done',Icons.check );
         }
         else if(re2=='could not mark done'){
           print('could not update status, procces failed');
           showTopSnackBar(context,'Fail','Request couldn\'t be marked as done',Icons.cancel_outlined, );
         }
         else print(re2);
        }
    else if(result=='done failed'){
    showTopSnackBar(context,'Fail','Request couldn\'t be marked as done',Icons.cancel_outlined, );
    }
    else{
      
    }


}
      Navigator.pop(context, 'OK');
      },
    );
                    });
}

} // end class
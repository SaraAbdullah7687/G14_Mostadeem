import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mostadeem/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:swe444/Models/request.dart';

class ViewRequestViewModel with ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> _requests;
  Stream<QuerySnapshot<Map<String, dynamic>>> _currentRequests;
  AuthService auth=AuthService();
  final List<Flushbar> flushBars = []; 

  fetchRequests() async {
    String uid= auth.getCurrentUserID();
    print(uid+ "in view model");
    var firebase=  FirebaseFirestore.instance
        .collection("institution")
        .doc(uid)
        .collection("appointment");
    _requests =
        firebase.where("status", isEqualTo: "pending").orderBy("date").snapshots(); // order by  + exclude old dates
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


void showTopSnackBar(BuildContext context ,String title,String message) => show(
        context,
        Flushbar(
          icon: Icon(Icons.error, size: 32, color: Colors.white),
          shouldIconPulse: false,
          title: title,
          message: message, // change message
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
          borderRadius: 16,
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

} // end class
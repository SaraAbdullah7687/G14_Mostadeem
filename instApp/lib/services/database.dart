import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inst_app/models/instModel.dart';



class databaseService {


  final CollectionReference _institutionCollection = FirebaseFirestore.instance.collection('institution'); 
    final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
    final CollectionReference _contributorCollection = FirebaseFirestore.instance.collection('contributor');

       String retVal = "error";


Stream<QuerySnapshot> get brews {
    return _institutionCollection.snapshots();
  }


Future<String> createUserInstitution(
  
  String uid,
  String name,
  String email, 
  String phone,
  String twitter, 
  String cr,
  String categ,



) 
async {
String retVal = "error";
var creation = new DateTime.now();

try {
      print("create institution collection");
      await _institutionCollection.doc(uid).set({
      'uid':uid,
      'name': name,
      'email': email,
      'phone': phone ,
      'twitterAccount': twitter,
      'CR': cr,
      'category':categ,
      'status': 'pending',
      'userType': 'institution',
      'dateCreated': creation,
      });

  retVal = "success";
    } catch (e) {
      print(e);
    }
try {
      print("create users collection");

      await _usersCollection.doc(uid).set({
        'name': name,
        'userType': 'institution',


      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

Future<String> getUserStatus(String uid/*,BuildContext context*/) async{

print(uid);
print("database file");
final snapshot =await _institutionCollection.doc(uid).get();
print("after getting type");
print (snapshot['status']+" in database method");
 String status = snapshot['status'];
 return status;
    }



String updateAppointment(String uid, String status, String instID){
String result="nothing changed";
// check condition approve or disapprove
if(status =='accept'){// get current user uid
_institutionCollection.doc(instID).collection("appointment").doc(uid) // لحظة هذا الاي دي حق الدوك للابوينمنت؟
    .update({'status' : 'accepted'}) // modify it
    .then((_) => print(result='Success accept'),)
    .catchError((error) => print(result='Fail accept'),);
    result='Success accept';
}
else if(status == 'reject'){
_institutionCollection.doc(instID).collection("appointment").doc(uid)
    .delete() 
    .then((_) => print(result='Success reject'),)
    .catchError((error) => print(result='Fail reject'),);
result='Success reject';
}
else{ // status==done
_institutionCollection.doc(instID).collection("appointment").doc(uid) // لحظة هذا الاي دي حق الدوك للابوينمنت؟
    .update({'status' : 'done'}) 
    .then((_) => print(result='Success done'),)
    .catchError((error) => print(result='done failed'),);
    result='Success done';
}
return result;

}

String updateRequest(String contID, String status, String reqID){
String result="nothing changed";
// check condition approve or disapprove
if(status =='accept'){// get current user uid
_contributorCollection.doc(contID).collection("request").doc(reqID) // لحظة هذا الاي دي حق الدوك للابوينمنت؟
    .update({'status' : 'accepted'})
    .then((_) => print(result='accepted'),)
    .catchError((error) => print(result='failed'),);
    result='accepted';
}
else if(status=='reject'){  
_contributorCollection.doc(contID).collection("request").doc(reqID)
    .update({'status' : 'rejected'})
    .then((_) => print(result='rejected'),)
    .catchError((error) => print(result='Fail reject'),);
result='Success reject';
}
else{// status==done
_contributorCollection.doc(contID).collection("request").doc(reqID) // لحظة هذا الاي دي حق الدوك للابوينمنت؟
    .update({'status' : 'done'})
    .then((_) => print(result='done'),)
    .catchError((error) => print(result='could not mark done'),);
    result='done';
}
return result;

}

Future<String> updateRequestStatusInAllInst(String status, String reqID) async {
String result="initial";
var theRequest = FirebaseFirestore.instance.collectionGroup('appointment')
   .where("requestID", isEqualTo: reqID).where("status", isEqualTo: "pending"); // only bring the request that is pending and has requestID=reqID, (I specify the status pending bc I already accepted one)
   if(status=='accept'){
     print('in accept if database');
     QuerySnapshot<Map<String, dynamic>> query = await theRequest.get();
     List<QueryDocumentSnapshot<Map<String, dynamic>>> document= query.docs;
     print('before checking doc length');
     if (document.length!=0){
     for (int i=0; i < document.length; i++){
       print('before if doc exixts');
       if(document[i].exists){
       try{
         print('inside for loop,before changing status');
        var docRef= document[i].reference;
        docRef.delete(); // call method to delete rejected req
       result="success";
       } 
       on FormatException catch (error) {
         print("error in update status all");
         return result="fail";
       }
       }
       else {return result="no institutions has the same req";}

     }// end for
     }else{
     print('doc length is 0');
     result="no doc with same req";}
     return result;
 
   //return result;
   }
   
   else { // status == reject => check if there is inst that has the same request
   QuerySnapshot<Map<String, dynamic>> query = await theRequest.get();
     List<QueryDocumentSnapshot<Map<String, dynamic>>> document= query.docs;
     print('before checking doc length');
     if (document.length==0){ // no inst has the req => change status in request collection
      return "No inst has the request";
     }
     else {// there's inst has the request
      return "There is inst has the request";
     }

   }
}

}


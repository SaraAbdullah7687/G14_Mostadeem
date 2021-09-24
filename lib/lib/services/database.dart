import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/models/ContributorModel.dart';

class DatabaseService {

  //final String uid;
 //DatabaseService({ this.uid });

  // collection reference
  final CollectionReference _contributorCollection = FirebaseFirestore.instance.collection('contributor'); // was Firestore instead of FirebaseFirestore
  final CollectionReference _institutionCollection = FirebaseFirestore.instance.collection('institution'); // was Firestore instead of FirebaseFirestore

  // get institution stream
  Stream<QuerySnapshot> get brews {
    return _institutionCollection.snapshots();
  }


Future<String> createUserContributor(ContributorModel user) async {
    String retVal = "error";
//ممكن طريقة انشاء الكولكشن غلط مدري كم عندنا من كوليكشن
    try {
      print("create contributor collection");
      await _contributorCollection.doc(user.uid).set({
        'uid':user.uid,
        'Name': user.name,
        'email': user.email,
        'userType': 'contributor',
        //'notifToken': user.notifToken,?? what should we add?
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }


String updateInstitution(String uid, String status){
String result="nothing changed";
// check condition approve or disapprove
if(status =='approve'){
_institutionCollection.doc(uid)
    .update({'status' : 'approved'})
    .then((_) => print(result='Success approve'),)
    .catchError((error) => print(result='Fail approve'),);
}
else{ // delete institution and send them email 
_institutionCollection.doc(uid)
    .delete()
    .then((_) => print(result='Success delete'),)
    .catchError((error) => print(result='Fail delete'),);
}
return result;

}



}
// modify this class from the bookclub
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/models/ContributorModel.dart';

class DatabaseService {

  //final String uid;
 //DatabaseService({ this.uid });

  // collection reference
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users'); // was Firestore instead of FirebaseFirestore
/*
  Future<void> updateUserData(String name, String email) async {
    return await userCollection.doc(uid).set({ // was document instead of doc
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }*/

  // get brews stream
  Stream<QuerySnapshot> get brews {
    return _userCollection.snapshots();
  }



Future<String> createUser(ContributorModel user) async {
    String retVal = "error";
//ممكن طريقة انشاء الكولكشن غلط مدري كم عندنا من كوليكشن
    try {
      await _userCollection.doc(user.uid).set({
        'Name': user.name,
        'email': user.email,
        //'notifToken': user.notifToken,?? what should we add?
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }






}
// modify this class from the bookclub
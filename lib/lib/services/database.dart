import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users'); // was Firestore instead of FirebaseFirestore
/*
  Future<void> updateUserData(String sugars, String name, int strength) async {
    return await userCollection.doc(uid).setData({ // was document instead of doc
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }*/

  // get brews stream
  Stream<QuerySnapshot> get brews {
    return userCollection.snapshots();
  }

}
// modify this class from the bookclub
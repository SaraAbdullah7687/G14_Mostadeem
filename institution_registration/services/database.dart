import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inst_registration/models/instModel.dart';



class databaseService {


  final CollectionReference _institutionCollection = FirebaseFirestore.instance.collection('institution'); 
    final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

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



}


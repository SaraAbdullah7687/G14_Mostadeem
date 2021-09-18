import 'package:test_project/models/ContributorModel.dart';
import 'package:test_project/models/userMu.dart';
import 'package:test_project/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  UserMu _userFromFirebaseUser(User user) { // was FirebaseUser instead of User
  print(user); // maybe wrong
    return user != null ? UserMu(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserMu> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser); // was onAuthStateChanged instead of authStateChanges()
     
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  /*
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously(); // was AuthResult instead of UserCredential
      User user = result.user; // was FirebaseUser instead of User
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }*/

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      User _user = _result.user; // was FirebaseUser instead of User
      return _user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password, String name) async { // خلي الميثود تقبل رقم جواله
   String retVal = "retVal error";
   try {
     print("before registering user");
      UserCredential _result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User _user = _result.user; // was FirebaseUser instead of User
      print("user registered");
       ContributorModel _userCont = ContributorModel(
        uid: _user.uid,
        email: _user.email,
        name: name,); //notifToken: await _fcm.getToken(),?? 

        String _returnString = await DatabaseService().createUser(_userCont); // maybe database service
        print("user created");
        if (_returnString == "success") { // didn't work
        retVal = "success";
      }
    print(retVal); // delete it 
       
      // create a new document for the user with the uid
     // await DatabaseService(uid: _user.uid).updateUserData('0','new crew member', 100);
      return _userFromFirebaseUser(_user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}
import 'package:test_project/models/userMu.dart';
import 'package:test_project/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  UserMu _userFromFirebaseUser(User user) { // was FirebaseUser instead of User
    return user != null ? UserMu(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserMu> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser); // was onAuthStateChanged instead of authStateChanges()
     
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously(); // was AuthResult instead of UserCredential
      User user = result.user; // was FirebaseUser instead of User
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user; // was FirebaseUser instead of User
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user; // was FirebaseUser instead of User
      // create a new document for the user with the uid
     // await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
      return _userFromFirebaseUser(user);
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
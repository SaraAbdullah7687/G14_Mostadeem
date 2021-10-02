import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:inst_registration/models/InstModel.dart';
import 'package:inst_registration/models/userMu.dart';
//import 'package:inst_registration/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;


class AuthService {

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  // create user obj based on firebase user
  UserMu? _userFromFirebaseUser(auth.User? user) { 
  if (user ==null)
  return null;
    return UserMu(uid: user.uid, email: user.email); 
  }

  // auth change user stream
  Stream<UserMu?>? get user {
    return _firebaseAuth.authStateChanges().map((_userFromFirebaseUser));
       }


  Future<UserMu?> signINWithEmailAndPassword(
    String email, 
    String password,
  ) async{
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password);
      return _userFromFirebaseUser(credential.user);
  }

  Future<UserMu?> createUserWithEmailAndPassword(
  String email,
  String password,
  ) async{
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password);
      return _userFromFirebaseUser(credential.user);
  }




  Future<void> signOut() async{
    return await _firebaseAuth.signOut();
    
  }
}
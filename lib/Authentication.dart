import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
 abstract class AuthImplemenatation
 {

 }


 class Auth implements AuthImplemenatation
 {
   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    Future<String> SignIn(String email, String password) async
   {
     FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
     return user.uid;
   }

    Future<String> SignUp(String email, String password) async
   {
     FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
     return user.uid;
   }

    Future<String> getCurrentuser() async
    {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return user.uid; 
    }
    
    Future<void> signOut() async
    {
      _firebaseAuth.signOut();
    }

 }
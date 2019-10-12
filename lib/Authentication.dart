import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
 abstract class AuthImplemenatation
 {Future<void> signOut() async
    {
      _firebaseAuth.signOut();
    }

 }


 class Auth implements AuthImplemenatation
 {
   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    //asynchronization method for SignIn
    Future<String> SignIn(String email, String password) async
   {
     FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
     return user.uid;
   }

    //asynchronization method for SignUp
    Future<String> SignUp(String email, String password) async
   {
     FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
     return user.uid;
   }

    //get the userid whho goto the login
    Future<String> getCurrentuser() async
    {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return user.uid; 
    }
    
    //asynchronization method for SignOut
    Future<void> signOut() async
    {
      _firebaseAuth.signOut();//using the firebase authentication
    }

 }
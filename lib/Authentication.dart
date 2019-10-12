import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
 abstract class AuthImplementation
 {
   Future<String> SignIn(String email, String password);
   Future<String> SignUp(String email, String password);
   Future<String> getCurrentuser();
   Future<void> signOut();
 }


 class Auth implements AuthImplementation
 {
   //private variable
   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    //asynchronization method for SignIn
    Future<String> SignIn(String email, String password) async
   {
     FirebaseUser user =  (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
     return user.uid;
   } 

      //asynchronization method for SignUp
    Future<String> SignUp(String email, String password) async
   {
     FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
     return user.uid;
   }
  

    //get the userid who goto the Login to the system
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
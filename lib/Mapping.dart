import 'package:flutter/material.dart';
import 'LoginRegisterPage.dart';
import 'Authentication.dart';
import 'HomePage.dart';

class MappingPage extends StatefulWidget
{
  final AuthImplementation auth; 

  MappingPage
  ({
      this.auth,
  });

  State<StatefulWidget> createState()
  {
    return _MappingPageState();
  }
}

  enum AuthStatus
  {
    notSignedIn,
    signedIn,
  }

  class _MappingPageState extends State<MappingPage> 
  {
    AuthStatus authStatus = AuthStatus.notSignedIn;

    @override
      void initState()
      {
         super.initState();

         widget.auth.getCurrentuser().then((firebaseUserId)
         {
            setState(() {
                authStatus = firebaseUserId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;        
            });
         });
      }

      void _signedIn()
      {
        setState(() 
        {
          authStatus = AuthStatus.signedIn;
        });
      }

      void _signOut()
      {
        setState(() 
        {
          authStatus = AuthStatus.notSignedIn;
        });
      }


    @override
      Widget build(BuildContext context)
      {
        switch(authStatus)
        {
          case AuthStatus.notSignedIn://if user is not sign in then allow to go to the LoginRegisterPage 
          return new LoginRegisterPage
          (
            auth: widget.auth,
            onSignedIn: _signedIn,//for sign in if user want

          );

          case AuthStatus.signedIn://if user is already signed in then allow to go to the HomePage
          return new HomePage
          (
            auth: widget.auth,
            onSignedOut: _signOut,//for logout if user want

          );
        }
        return null;
      }    
  }

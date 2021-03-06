import 'package:blog/DialogBox.dart';
import 'package:flutter/material.dart'; //every dart file need that import packages
import 'Authentication.dart';
import 'DialogBox.dart';



//generate stateful widget for LoginRegisterPage
class LoginRegisterPage extends StatefulWidget
{

  LoginRegisterPage
  ({
      this.auth,
      this.onSignedIn,
  });

  final AuthImplementation auth;
  final VoidCallback onSignedIn;

    State<StatefulWidget> createState()
    {
        return _LoginRegisterState();
    }
}


enum FormType
{
    login,
    register
}
 

class _LoginRegisterState extends State<LoginRegisterPage> 
{
  DialogBox dialogBox = new DialogBox(); // intialize the dialogBox


  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";



  bool validateAndSave()
  {
      final form = formKey.currentState;

      if(form.validate())
      {
          form.save();
          return true;
      }
      else
      {
          return false;
      }
  }

  // That method using when user press the Login button 
  void validateAndSubmit() async
  {
    if(validateAndSave())
    {
      try
      {
        if(_formType == FormType.login)
        {
          //if login
          String userId = await widget.auth.SignIn(_email, _password);
          //dialogBox.information(context, "Congratulations", "your are logged in successfully.");
          print("login userId = "+ userId);
        }
        else
        {
          //if not login
          String userId = await widget.auth.SignUp(_email, _password);
          //dialogBox.information(context, "Congratulations", "your account has been created successfully.");
          print("Register userId = "+ userId);
        }

        widget.onSignedIn();
      }
      catch(e)
      {
          dialogBox.information(context, "Error ", e.toString()); //set the dialog box for show the error
          print("Error "+ e.toString());
      }
    }


  }

  void moveToRegister()
  {
      formKey.currentState.reset();

      setState(() 
      {
            _formType = FormType.register;  
      });

  } 

  void moveToLogin()
  {
      formKey.currentState.reset();

      setState(() 
      {
            _formType = FormType.login;  
      });

  }



  //Design
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
          backgroundColor: Colors.indigo,
          body: new Stack
            (
              fit: StackFit.expand,
              children: <Widget>[
                new Image(
                  image: new AssetImage("images/welcome_new.png"),
                  fit: BoxFit.cover,    
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Form(
                      key: formKey,
                      child: new Container(
                        padding: const EdgeInsets.all(30.0),
                        child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: createInputs() + createButtons(),
                        ), 
                      ),   
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  List<Widget> createInputs()
  {
      return
      [
          SizedBox(height: 20.0,),

          new TextFormField
          (
              decoration: new InputDecoration(
                labelText: 'Email',
                labelStyle: new TextStyle
                  (
                    fontSize: 16.0, 
                    fontFamily: 'Voces', 
                    fontStyle: FontStyle.normal, 
                    color: Theme.of(context).accentColor, 
                  )
                ),
              validator: (value)
              {
                  return value.isEmpty ? 'Email is required' : null;
              },

              style: new TextStyle
              (
                fontSize: 16.0, 
                fontFamily: 'Voces', 
                fontStyle: FontStyle.normal, 
                color: Colors.black,
              ),

              onSaved: (value)
              {
                  return _email = value; 
              },
          ),

          SizedBox(height: 10.0,), 

          new TextFormField
          (
              decoration: new InputDecoration(
                labelText: 'Password',
                labelStyle: new TextStyle
                  (
                    fontSize: 16.0, 
                    fontFamily: 'Voces', 
                    fontStyle: FontStyle.normal, 
                    color: Theme.of(context).accentColor, 
                  )
                ),
                obscureText: true,

              validator: (value)
              {
                  return value.isEmpty ? 'Password is required' : null;
              },

              style: new TextStyle
              (
                fontSize: 16.0, 
                fontFamily: 'Voces', 
                fontStyle: FontStyle.normal, 
                color: Colors.black,
              ),

              onSaved: (value)
              {
                  return _password = value; 
              },
          ),

          SizedBox(height: 10.0,),
      ];
  }

  List<Widget> createButtons()
  {
      if(_formType == FormType.login)
      {
          return
          [
              new RaisedButton
              (
                  child: new Text(
                    "Login", 
                    style: new TextStyle
                      (
                        fontSize: 20.0, 
                        fontFamily: 'Voces', 
                        fontStyle: FontStyle.normal, 
                        color: Theme.of(context).accentColor, 
                      )
                    ),
                  color: Colors.black,
                  textColor: Theme.of(context).accentColor,
                  onPressed: validateAndSubmit,
              ),

              new FlatButton
              (
                  child: new Text(
                    "Not have an Account? Create Account?", 
                    style: new TextStyle
                      (
                        fontSize: 15.0, 
                        fontFamily: 'Voces', 
                        fontStyle: FontStyle.normal, 
                        color: Theme.of(context).accentColor, 
                        )
                      ),
                  textColor: Theme.of(context).accentColor,
                  onPressed: moveToRegister,

              ),
          ];
      }

      else
      {
          return
          [
              new RaisedButton
              (
                  child: new Text(
                    "Create Account", 
                    style: new TextStyle
                      (
                        fontSize: 20.0, 
                        fontFamily: 'Voces', 
                        fontStyle: FontStyle.normal, 
                        color: Theme.of(context).accentColor,
                      )
                    ),
                  color: Colors.black,  
                  textColor: Theme.of(context).accentColor,
                  onPressed: validateAndSubmit,
              ),

              new FlatButton
              (
                  child: new Text(
                    "Already have an Account? Login", 
                    style: new TextStyle
                      (
                        fontSize: 16.0, 
                        fontFamily: 'Voces', 
                        fontStyle: FontStyle.normal, 
                        color: Theme.of(context).accentColor,
                        )
                      ),
                  textColor: Theme.of(context).accentColor,
                  onPressed: moveToLogin,

              ),
          ];
      }
  }
}


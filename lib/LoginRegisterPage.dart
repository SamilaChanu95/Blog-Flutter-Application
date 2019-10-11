import 'package:flutter/material.dart';
//every dart file need that import packages

//generate stateful widget for LoginRegisterPage
class LoginRegisterPage extends StatefulWidget
{
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
                    fontSize: 14.0, 
                    fontFamily: 'Voces', 
                    fontStyle: FontStyle.normal, 
                    color: Colors.yellowAccent[400] 
                  )
                ),
              validator: (value)
              {
                  return value.isEmpty ? 'Email is required' : null;
              },

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
                    fontSize: 14.0, 
                    fontFamily: 'Voces', 
                    fontStyle: FontStyle.normal, 
                    color: Colors.yellowAccent[400] 
                  )
                ),
                obscureText: true,

              validator: (value)
              {
                  return value.isEmpty ? 'Password is required' : null;
              },

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
                        color: Colors.yellowAccent[400] 
                      )
                    ),
                  color: Colors.black54,
                  textColor: Colors.yellowAccent[400],
                  onPressed: validateAndSave,
              ),

              new FlatButton
              (
                  child: new Text(
                    "Not have an Account? Create Account?", 
                    style: new TextStyle
                      (
                        fontSize: 14.0, 
                        fontFamily: 'Voces', 
                        fontStyle: FontStyle.normal, 
                        color: Colors.yellowAccent[400] 
                        )
                      ),
                  textColor: Colors.yellowAccent[400],
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
                        color: Colors.yellowAccent[400] 
                      )
                    ),
                  color: Colors.black54,  
                  textColor: Colors.yellowAccent[400],
                  onPressed: validateAndSave,
              ),

              new FlatButton
              (
                  child: new Text(
                    "Already have an Account? Login", 
                    style: new TextStyle
                      (
                        fontSize: 14.0, 
                        fontFamily: 'Voces', 
                        fontStyle: FontStyle.normal, 
                        color: Colors.yellowAccent[400] 
                        )
                      ),
                  textColor: Colors.yellowAccent[400],
                  onPressed: moveToLogin,

              ),
          ];
      }
  }
}

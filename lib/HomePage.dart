import 'package:blog/PhotoUpload.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'PhotoUpload.dart';

class HomePage extends StatefulWidget
{ 
  HomePage
  ({

    this.auth,
    this.onSignedOut,

  });
  final AuthImplementation auth;
  final VoidCallback onSignedOut;  


  @override
    State<StatefulWidget> createState()
    {
      return _HomePageState();
    }

}

class _HomePageState extends State<HomePage>
{

  void _logoutUser() async
  {
    try
    {
        await widget.auth.signOut();
        widget.onSignedOut();
    }
    catch(e)
    {
        print("Error = "+ e.toString());
    }
  }

  @override
    Widget build(BuildContext context)
    {
      return new Scaffold
      (
        appBar: new AppBar
        (
          title: new Text("Home"),
        ),
        body: new Container
        (
          
        ),

        bottomNavigationBar: new BottomAppBar
        (
          color: Colors.indigo,
          child: new Container
          (
            margin: const EdgeInsets.only(left: 60.0, right: 60.0),
            child: new Row
            (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,

              children: <Widget>
              [

                new IconButton
                (
                  icon: new Icon(Icons.add_a_photo),
                  iconSize: 40,
                  color: Colors.white,

                  onPressed: ()
                  {
                    Navigator.push
                    (
                      context, 
                      MaterialPageRoute(builder: (context)
                      {
                        return new UploadPhotoPage();
                      })
                    );
                  },
                ),

                new IconButton
                (
                  icon: new Icon(Icons.power_settings_new),
                  iconSize: 40,
                  color: Colors.white,

                  onPressed: _logoutUser, // set the event listener by set the method for onPressed property
                ),

              ],
            ),
          ),
        ),

      );
    }
}
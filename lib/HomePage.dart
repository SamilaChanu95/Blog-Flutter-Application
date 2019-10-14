import 'package:blog/PhotoUpload.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'PhotoUpload.dart';
import 'Posts.dart';

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

  //Posts need to show as thw List Data type
  List<Posts> postsList = [];

  @override
  void initState() { // method for retrieve the data from the database
    
    super.initState();

    DatabaseReference postsRef = FirebaseDatabase.instance.reference().child("Posts"); //get the data from the firebase database reference "Posts"
  
    postsRef.once().then((DataSnapshot snap)
    {
      var KEYS = snap.value.keys; //ek ek  postsRef ekata adala key and data variable 2 kata gani.
      var DATA = snap.value;

      postsList.clear();

      for(var individualKey in KEYS)
      {
        Posts posts = new Posts 
        (
          DATA[individualKey]['image'],
          DATA[individualKey]['description'],
          DATA[individualKey]['date'],
          DATA[individualKey]['time'],
        ); //create new post

        postsList.add(posts);
      }

      setState(() 
      {
        print('Length : $postsList.length'); //return the total no. posts

      });

    });
  }


  void _logoutUser() async
  {
    try
    {
        await widget.auth.signOut();
        widget.onSignedOut();
    }
    catch(e)
    {
        print("Error "+ e.toString());
    }
  }

  @override
    Widget build(BuildContext context)
    {
      return new Scaffold
      (
        appBar: new AppBar
        (
          title: new Text
          (
            "Home",
            style: TextStyle
              ( 
                fontSize: 22.0,
                fontFamily: 'Voces', 
                fontStyle: FontStyle.normal, 
                color: Theme.of(context).accentColor,  
              ),
          ),
        ),
        body: new Container
        (
          child: postsList.length == 0 ? new Text("No  Blog Post available") : new ListView.builder
          ( 
            itemCount: postsList.length,
            itemBuilder: (_, index)
            {
              return PostsUI(postsList[index].image, postsList[index].description, postsList[index].date, postsList[index].time);
            }
          ),
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
                  color: Theme.of(context).accentColor,

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
                  color: Theme.of(context).accentColor,

                  onPressed: _logoutUser, // set the event listener by set the method for onPressed property
                ),

              ],

            ),

          ),

        ),

      );
      
    }

    Widget PostsUI(String image,String description,String date,String time)
    {
      return new Card
      (
        elevation: 8.0,
        margin: EdgeInsets.all(12.0),

        child: new Container
        (
          padding: new EdgeInsets.all(14.0),
          child: new Column
          (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>
            [
              new Row
              (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>
                  [
                    new Text
                    (
                      date,
                      style: Theme.of(context).textTheme.subtitle,
                      textAlign: TextAlign.center,
                 
                    ),

                    new Text
                    (
                      time,
                      style: Theme.of(context).textTheme.subtitle,
                      textAlign: TextAlign.center,
                    ),

                  ],

              ),

              SizedBox(height: 10.0,),

              new Image.network
              (
                image,
                fit: BoxFit.cover,   
              ),

              SizedBox(height: 10.0,),

              new Text
              (
                description,
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),

            ],

          ),

        ),

      );

    }
}
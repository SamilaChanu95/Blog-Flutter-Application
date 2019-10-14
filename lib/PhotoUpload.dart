import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart'; //get the image from the mobile phone gallary
import 'dart:io';



class UploadPhotoPage extends StatefulWidget
{
  State<StatefulWidget> createState()
  {
    return _UploadPhotoPageState();
  }
}

class _UploadPhotoPageState extends State<UploadPhotoPage>
{
  File sampleImage;
  String _myValue;
  String url;
  final formkey = new GlobalKey<FormState>();


  Future getImage() async
  {
    //get the image from the mobile phone gallary
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    
    setState(() 
    {
      sampleImage = tempImage;
      //pass the image
    });
  }

  bool validateAndSave()
  {
    final form = formkey.currentState;

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


  void uploadStatusImage() async
  {
    if(validateAndSave()) //save karaathinm pamanak post eka store we
    {
      final StorageReference postImageRef = FirebaseStorage.instance.ref().child("Post Images"); //give the path storage for the image to store in the firebase database
    
      var timeKey = new DateTime.now(); // get the current time

      final StorageUploadTask uploadTask = postImageRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);
      //sample image eka time ekth ekka jpg format eken storage eke upload we

      var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL(); // get the url of the image stored in Storage
    
      url = ImageUrl.toString(); 
      
      print("Image URL is: "+url);//returns the string representation of the object
    
      goToHomePage(); //method for gto the home page with the new post

      saveToDatabase(url); //then save that url in the data base which postimage store in the storage
    }
  }

  void saveToDatabase(url)
  {
    var dbtimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d,yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');


    String date = formatDate.format(dbtimeKey); //get the date using the formatDate 
    String time = formatTime.format(dbtimeKey); //get the time using the formatTime

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data = 
    { 
      "image":url,
      "description": _myValue,
      "date": date,
      "time": time,

    };

    ref.child("Posts").push().set(data); //database eke Posts child eke data, propertise 4 n save we
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
          "Upload Image",
          style: TextStyle
              ( 
                fontSize: 22.0,
                fontFamily: 'Voces', 
                fontStyle: FontStyle.normal, 
                color: Theme.of(context).accentColor,  
              ),
        ),
        centerTitle: true,
      ),

      body: new Center
      (
              //sample image is null then display that msg on the screen
        child: sampleImage == null ? Text
        (
          "Select an image",
          style: TextStyle
              ( 
                fontSize: 16.0,
                fontFamily: 'Voces', 
                fontStyle: FontStyle.normal, 
                color: Colors.black, 
                 
              ),
        ): enableUpload(),//if sampleImage is null then allow to user for select the image from the gallary 
      ),

      floatingActionButton: new FloatingActionButton //add floating button
      (
        onPressed: getImage,
        backgroundColor: Colors.indigo,
        tooltip: 'Add Image',
        child: new Icon
        (
          Icons.add_a_photo,
          color: Theme.of(context).accentColor,
        ),
      ),

    );
  }

  Widget enableUpload()
  {
    return Container
    (
      child: new Form
      (
        key: formkey,

        child: Column
        (
          children: <Widget>
          [
            Image.file(sampleImage, height: 330.0, width: 660.0),

            SizedBox(height: 15.0,),
            new TextFormField
            (
              
              decoration: new InputDecoration
              (
                labelText: 'Description',
                fillColor: Theme.of(context).accentColor,
                border: new OutlineInputBorder
                (
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),

              validator: (value)
              {
                return value.isEmpty ? 'Blog Description is required' : null;
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
                return _myValue = value;
              },

            ),

            SizedBox(height: 15.0,),

            RaisedButton
            (
              elevation: 10.0,
              child: new Text(
                "Add a New Post",
                style: new TextStyle
                      (
                        fontSize: 20.0, 
                        fontFamily: 'Voces', 
                        fontStyle: FontStyle.normal, 
                        color: Theme.of(context).accentColor, 
                      ),
              ),              
              color: Colors.indigo,
              onPressed: uploadStatusImage,  
            ),

          ],

        ),

      ),

    );

  }
}
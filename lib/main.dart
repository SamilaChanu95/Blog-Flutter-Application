import 'package:flutter/material.dart';  //every dart file need that import packages
import 'LoginRegisterPage.dart';
import 'HomePage.dart';



void main()
{
  runApp(new BlogApp());
}

class BlogApp extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return new MaterialApp
      (
      //avoid the debug tag
      debugShowCheckedModeBanner: false,

      title:  "Blog",

      theme: new ThemeData
        (
        primarySwatch: Colors.indigo,

      ), // ThemeData

      home: HomePage(),
    ); // MaterialApp

  }
}
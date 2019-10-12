import 'package:blog/Authentication.dart';
import 'package:flutter/material.dart';  //every dart file need that import packages
import 'Mapping.dart';
import 'Authentication.dart';



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

      home: MappingPage(auth: Auth(),),
    ); // MaterialApp

  }
}  
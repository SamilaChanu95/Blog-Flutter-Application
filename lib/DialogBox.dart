import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class DialogBox
{
  information(BuildContext context, String title, String description)
  {
    return showDialog
    (
      context: context,
      barrierDismissible: true,

      builder: (BuildContext context)
      {
        return AlertDialog
        (
          title: Text(
            title,
            style: TextStyle
              (
                fontSize: 20.0, 
                fontFamily: 'Voces', 
                fontStyle: FontStyle.normal, 
                color: Colors.black 
              ),
            ),
          backgroundColor: Theme.of(context).accentColor,
          content: SingleChildScrollView
          (
            child: ListBody
            (
              children: <Widget>
              [
                Text(description)
              ],

            ),

          ),

          actions: <Widget>
          [
            FlatButton
            (
              child: Text(
                "ok",
                style: TextStyle
                  (
                    fontSize: 20.0, 
                    fontFamily: 'Voces', 
                    fontStyle: FontStyle.normal, 
                    color: Colors.black 
                  )
                ),
                
              onPressed: ()
              {
                return Navigator.pop(context);
              },
            )
          ],

        );
      }
    );
  }
}
import 'package:flutter/material.dart';

class Mydialog{
Future<void>nomalDialog(BuildContext context,String message)async{
  showDialog(context: context, builder: (context)=> 
  SimpleDialog(
    title: Text(message),children: <Widget>[
     Padding(
       padding: const EdgeInsets.all(10.0),
       child: ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
     )
      
      ],
    ),
  );
  
}
}
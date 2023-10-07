import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/login.dart';
import 'package:flutter_firebase_test/meprofile.dart';
import 'package:flutter_firebase_test/register1.dart';




void main()async{
  WidgetsFlutterBinding.ensureInitialized();
     
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyA-3drNTbNQG3Ijj8NmY0u-OpI-UyV5EDA", 
      appId: "1:427527336711:android:73a701d718c062454c0ba2", 
      messagingSenderId: "427527336711", 
      projectId: "test-77ba3",
      authDomain: "project-id.firebaseapp.com",
      databaseURL: "https://test-77ba3-default-rtdb.asia-southeast1.firebasedatabase.app/",
      storageBucket:"gs://test-77ba3.appspot.com"
      
      )
  );
 



  runApp( MyApp());
}



class MyApp extends StatelessWidget{
Widget build(BuildContext context){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.greenAccent[700]
       
        
    ),
      // backgroundColor: Colors.pink[100],
    ),
    home: Scaffold(
     
    
     
      
      body: const login(),
     
    ),
  );
  
}
}

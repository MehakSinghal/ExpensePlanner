import 'package:ExpensePlanner/screens/login_screen.dart';
import 'package:ExpensePlanner/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<DocumentSnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("users")
        .doc("docID")
        .get();
  }
  void _changeScreen(BuildContext context){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
        print('User is currently signed out!');
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> SplashScreen()));
        print('User is signed in!');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: FutureBuilder(builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          _changeScreen(context);
        }else if (snapshot.connectionState == ConnectionState.none) {
          return Text("No data");
        }return Container(
          color: Color.fromRGBO(184,216,216,1),
        );
      },future:getData() ),
      debugShowCheckedModeBanner: false,
    );
  }
}
// Color.fromRGBO(254,95,85,1),  ORANGE
// Color.fromRGBO(238,245,219,1), BEIGE
// Color.fromRGBO(79,99,103,1), GREEN DARK
// Color.fromRGBO(122,158,159,1), GREEN MEDIUM
// Color.fromRGBO(184,216,216,1), GREEN LIGHT
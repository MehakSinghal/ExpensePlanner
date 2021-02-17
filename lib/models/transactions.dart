import 'package:ExpensePlanner/screens/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Transactions{
  final String month;
  final double amount;
  final String title;
  final String description;
  final String date;
  final String image;
  final String id;

  Transactions({this.amount,this.month,this.title,this.date,this.description,this.id,this.image});

  static Future<void> add(Transactions editedForm , BuildContext context , DateTime date,File img) async{
    final url = "https://expense-planner-96018-default-rtdb.firebaseio.com/transactions.json";
        final ref = FirebaseStorage.instance.ref().child('transaction_image').child(date.toIso8601String()+'.jpg');
        await ref.putFile(img);
        final urlImg = await ref.getDownloadURL();
    final response = await http.post(url,
        body: json.encode({
          'title': editedForm.title,
          'description': editedForm.description,
          'amount' : editedForm.amount,
          'date' : date.toIso8601String(),
          'image' : urlImg,
          'creatorId' : FirebaseAuth.instance.currentUser.uid,
          'month' : date.month,
        }));
     Navigator.push(context, MaterialPageRoute(builder: (ctx)=> SplashScreen()));
  }

  static Future<void> update(Transactions editedForm, var id , BuildContext context, DateTime date, [File img]) async{
    final url= "https://expense-planner-96018-default-rtdb.firebaseio.com/transaction/$id.json";
    if(img==null){
      final response = await http.patch(url,
          body: json.encode({
            'title': editedForm.title,
            'description': editedForm.description,
            'amount' : editedForm.amount,
            'date' : date.toIso8601String(),
            'month' : date.month,
          }));
    }else{
      final ref = FirebaseStorage.instance.ref().child('transaction_image').child(date.toIso8601String()+'.jpg');
      await ref.putFile(img);
      final urlImg = await ref.getDownloadURL();
      final response = await http.post(url,
          body: json.encode({
            'title': editedForm.title,
            'description': editedForm.description,
            'amount' : editedForm.amount,
            'date' : date.toIso8601String(),
            'image' : urlImg,
            'month' : date.month
          }));
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SplashScreen()));
  }

  static Future<void> delete(String id, BuildContext context) async{
    if(id == null){
      Navigator.of(context).pop();
    }
    else{
      final url= "https://expense-planner-96018-default-rtdb.firebaseio.com/transaction/$id.json";
      final response = await http.delete(url);
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SplashScreen()));
  }

  }
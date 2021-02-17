import 'package:ExpensePlanner/constants.dart';
import 'package:ExpensePlanner/models/transactions.dart';
import 'package:ExpensePlanner/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List _data=[];
  @override
  void initState() {
    fetchData();
    super.initState();
  }
  Future<void> fetchData() async {
    var user = FirebaseAuth.instance.currentUser.uid;
    final filterString ='orderBy="creatorId"&equalTo="$user"';
    var url = "https://expense-planner-96018-default-rtdb.firebaseio.com/transactions.json?$filterString";
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      print("NO");
    } else {
      extractedData.forEach((key, value) {
        _data.add(Transactions(
          id: key,
          title: value['title'],
          description: value['description'],
          amount: value['amount'],
          date: value['date'],
          image: value['image'],
          month: value['month'].toString(),
        ));
      });
      /*extractedData.forEach((key, value) {
        switch(value['month']){
          case 1 : _barData[0] = _barData[0]+value['amount']; break;
          case 2 : _barData[1] = _barData[1]+value['amount']; break;
          case 3 : _barData[2] = _barData[2]+value['amount']; break;
          case 4 : _barData[3] = _barData[3]+value['amount']; break;
          case 5 : _barData[4] = _barData[4]+value['amount']; break;
          case 6 : _barData[5] = _barData[5]+value['amount']; break;
          case 7 : _barData[6] = _barData[6]+value['amount']; break;
          case 8 : _barData[7] = _barData[7]+value['amount']; break;
          case 9 : _barData[8] = _barData[8]+value['amount']; break;
          case 10 : _barData[9] = _barData[9]+value['amount']; break;
          case 11 : _barData[10] = _barData[10]+value['amount']; break;
          case 12 : _barData[11] = _barData[11]+value['amount']; break;
        }
      });*/
    }
    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> TabScreen(_data)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(184, 216, 216, 1),
      body: Container(
              height: Constants.getSize(context).height,
              width: Constants.getSize(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.payment,
                    size: 140,
                    color: Color.fromRGBO(238, 245, 219, 1),
                  ),
                  Text(
                    "EXPENSE PLANNER",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromRGBO(79,99,103,1),
                    ),
                  ),
                  CircularProgressIndicator(valueColor:
                  new AlwaysStoppedAnimation<Color>(Color.fromRGBO(79,99,103,1))),
                  SizedBox(height: 20,),
                  Text("LOADING...PLEASE WAIT!",style: TextStyle(color: Color.fromRGBO(79,99,103,1),fontSize: 15)),
                ],
              ),
            ),
    );
  }
}

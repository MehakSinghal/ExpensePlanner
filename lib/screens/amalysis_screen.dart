import 'package:ExpensePlanner/models/transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../constants.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';
class AnalysisScreen extends StatefulWidget {
  List barData=[];

  AnalysisScreen(this.barData);
  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {

  List<Color> colors = [
    Color.fromRGBO(79, 99, 103, 1),
    Color.fromRGBO(69, 99, 113, 1),
    Color.fromRGBO(122, 158, 159, 1),
    Color.fromRGBO(143, 185, 186, 1),
    Color.fromRGBO(184, 216, 216, 1),
    Color.fromRGBO(228, 245, 229, 1),
    Color.fromRGBO(248, 245, 219, 1),
  ];

  List<charts.Series> data;

  List<charts.Series<Transactions, String>> _createData() {
    List <double>_barData=[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
    widget.barData.forEach((element) {
      switch(element.month){
        case "1" : _barData[0] = _barData[0]+element.amount; break;
        case "2" : _barData[1] = _barData[1]+element.amount; break;
        case "3" : _barData[2] = _barData[2]+element.amount; break;
        case "4" : _barData[3] = _barData[3]+element.amount; break;
        case "5" : _barData[4] = _barData[4]+element.amount; break;
        case "6" : _barData[5] = _barData[5]+element.amount; break;
        case "7" : _barData[6] = _barData[6]+element.amount; break;
        case "8" : _barData[7] = _barData[7]+element.amount; break;
        case "9" : _barData[8] = _barData[8]+element.amount; break;
        case "10" : _barData[9] = _barData[9]+element.amount; break;
        case "11" : _barData[10] = _barData[10]+element.amount; break;
        case "12" : _barData[11] = _barData[11]+element.amount; break;
      }
    });
    //print(_barData);
    final transactionData = [
      Transactions(month: "Jan", amount: _barData[0]),
      Transactions(month: "Feb", amount: _barData[1]),
      Transactions(month: "Mar", amount: _barData[2]),
      Transactions(month: "Apr", amount: _barData[3]),
      Transactions(month: "May", amount: _barData[4]),
      Transactions(month: "Jun", amount: _barData[5]),
      Transactions(month: "Jul", amount: _barData[6]),
      Transactions(month: "Aug", amount: _barData[7]),
      Transactions(month: "Sep", amount: _barData[8]),
      Transactions(month: "Oct", amount: _barData[9]),
      Transactions(month: "Nov", amount: _barData[10]),
      Transactions(month: "Dec", amount: _barData[11]),
    ];
    return [
      charts.Series<Transactions, String>(
        id: "id",
        domainFn: (Transactions t, _) => t.month,
        measureFn: (Transactions t, _) => t.amount,
        data: transactionData,
        fillColorFn: (Transactions t, _) =>
            charts.Color.fromHex(code: '#8FB9BA'),
      )
    ];
  }


    @override
    void initState() {
      data = _createData();

      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: Constants
                .getSize(context)
                .width * 0.06,
            vertical: Constants
                .getSize(context)
                .height * 0.02),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "WEEKLY ANALYSIS",
              style: TextStyle(
                  color: Color.fromRGBO(79, 99, 103, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Container(
              height: Constants
                  .getSize(context)
                  .height * 0.3,
              width: Constants
                  .getSize(context)
                  .width * 0.9,
              margin: EdgeInsets.symmetric(
                vertical: Constants
                    .getSize(context)
                    .height * 0.02,
              ),
              //color: Colors.yellow,
              child: PieChart(
                animationDuration: Duration(milliseconds: 1200),
                chartRadius: Constants
                    .getSize(context)
                    .height * 0.5,
                chartType: ChartType.ring,
                dataMap: {
                  "Mon": 20,
                  "Tue": 20,
                  "Wed": 20,
                  "Thu": 20,
                  "Fri": 20,
                  "Sat": 20,
                  "Sun": 20,
                },
                showLegends: true,
                legendPosition: LegendPosition.right,
                initialAngle: 0,
                //chartValueStyle: TextStyle(color: Color.fromRGBO(234, 243, 250, 1)),
                colorList: colors,
              ),
            ),
            Text(
              "YEARLY ANALYSIS",
              style: TextStyle(
                  color: Color.fromRGBO(79, 99, 103, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Container(
              height: Constants
                  .getSize(context)
                  .height * 0.32,
              width: Constants
                  .getSize(context)
                  .width,
              margin: EdgeInsets.symmetric(
                vertical: Constants
                    .getSize(context)
                    .height * 0.02,
              ),
              //color: Colors.yellow,
              child: charts.BarChart(
                data,
                animate: true,
                vertical: true,

                animationDuration: Duration(milliseconds: 1200),
              ),
            )
          ],
        ),
      );
    }
  }

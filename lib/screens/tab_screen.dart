import 'dart:io';

import 'package:ExpensePlanner/screens/add_expense%20screen.dart';
import 'package:ExpensePlanner/screens/amalysis_screen.dart';
import 'package:ExpensePlanner/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TabScreen extends StatefulWidget {
  List data;

  TabScreen(this.data);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "EXPENSE PLANNER",
            style: TextStyle(
              color: Color.fromRGBO(79, 99, 103, 1),
            ),
          ),
          backgroundColor: Color.fromRGBO(184, 216, 216, 1),
          leading: IconButton(
            icon: Icon(
              Icons.payment,
              size: 30,
              color: Color.fromRGBO(238, 245, 219, 1),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: Text("LOGOUT",
                            style: TextStyle(
                                color: Color.fromRGBO(79, 99, 103, 1))),
                        content: Text("Are you sure you want to logout?",
                            style: TextStyle(
                                color: Color.fromRGBO(79, 99, 103, 1))),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                //exit(0);
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    color: Color.fromRGBO(122, 158, 159, 1)),
                              )),
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "No",
                                style: TextStyle(
                                    color: Color.fromRGBO(122, 158, 159, 1)),
                              )),
                        ],
                      ));
            },
          ),
          bottom: TabBar(
            labelColor: Color.fromRGBO(79, 99, 103, 1),
            indicatorColor: Color.fromRGBO(79, 99, 103, 1),
            tabs: [
              Tab(
                text: "ALL",
              ),
              Tab(
                text: "ANALYSIS",
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(238, 245, 219, 1),
          child: Icon(
            Icons.add,
            size: 35,
            color: Color.fromRGBO(79, 99, 103, 1),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (ctx) => AddExpenseScreen()));
          },
        ),
        body: TabBarView(
          children: [Dashboard(widget.data), AnalysisScreen(widget.data)],
        ),
      ),
    );
  }
}

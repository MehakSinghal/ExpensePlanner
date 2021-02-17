import 'package:ExpensePlanner/constants.dart';
import 'package:ExpensePlanner/models/transactions.dart';
import 'package:ExpensePlanner/screens/add_expense%20screen.dart';
import 'package:flutter/material.dart';

class ExpenseDetailScreen extends StatelessWidget {
  int i;
  Transactions t;
  var date;

  ExpenseDetailScreen(this.i, this.t, this.date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(184, 216, 216, 1),
        toolbarHeight: Constants.getSize(context).height * 0.07,
        title: Text(
          t.title,
          style: TextStyle(color: Color.fromRGBO(79, 99, 103, 1), fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            top: Constants.getSize(context).height * 0.03,
            left: Constants.getSize(context).width * 0.04,
            right: Constants.getSize(context).width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: i,
              child: Container(
                width: Constants.getSize(context).width * 0.486,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(79, 99, 103, 1), width: 2),
                  shape: BoxShape.circle,
                ),
                margin: EdgeInsets.only(
                    left: Constants.getSize(context).width * 0.21,
                    bottom: Constants.getSize(context).height * 0.01),
                child: CircleAvatar(
                  radius: 98,
                  backgroundImage: NetworkImage(
                    t.image == null
                        ? "https://ak.picdn.net/shutterstock/videos/1459387/thumb/1.jpg?ip=x480"
                        : t.image,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Constants.getSize(context).width * 0.01),
              child: Text(
                t.title,
                style: TextStyle(
                    fontSize: 35,
                    color: Color.fromRGBO(122, 158, 159, 1),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Constants.getSize(context).width * 0.01),
              child: Text(
                t.description,
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(122, 158, 159, 1),
                    fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: Constants.getSize(context).height * 0.02,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Constants.getSize(context).width * 0.01),
                  child: Text(
                    date.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(79, 99, 103, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: Constants.getSize(context).width * 0.02,
                ),
                Container(
                  width: Constants.getSize(context).width * 0.65,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(
                      left: Constants.getSize(context).width * 0.01),
                  child: Text(
                    "\$" + t.amount.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(79, 99, 103, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Constants.getSize(context).height * 0.05,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              buttonHeight: Constants.getSize(context).height * 0.06,
              buttonMinWidth: Constants.getSize(context).width * 0.4,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => AddExpenseScreen(t)));
                  },
                  color: Color.fromRGBO(184, 216, 216, 1),
                  child: Text(
                    "EDIT TRANSACTION",
                    style: TextStyle(
                        color: Color.fromRGBO(79, 99, 103, 1), fontSize: 17),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Transactions.delete(t.id, context);
                  },
                  color: Colors.red[300],
                  child: Text(
                    "DELETE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

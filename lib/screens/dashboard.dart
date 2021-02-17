import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import 'expense_detail_screen.dart';

class Dashboard extends StatelessWidget {
  List _data;

  Dashboard(this._data);

  @override
  Widget build(BuildContext context) {
    return _data.length > 0
        ? ListView.builder(
            itemBuilder: (ctx, i) {
              var p = DateFormat.yMMMd().format(DateTime.parse(_data[i].date));
              return InkWell(
                child: Row(
                  children: [
                    Hero(
                      tag: i,
                      child: Container(
                        height: Constants.getSize(context).height * 0.1,
                        width: Constants.getSize(context).width * 0.2,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(79, 99, 103, 1))),
                        margin: EdgeInsets.only(
                            top: Constants.getSize(context).height * 0.02,
                            left: Constants.getSize(context).width * 0.04,
                            right: Constants.getSize(context).width * 0.04),
                        child: Image.network(
                          _data[i].image == null
                              ? "https://ak.picdn.net/shutterstock/videos/1459387/thumb/1.jpg?ip=x480"
                              : _data[i].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              _data[i].title,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(122, 158, 159, 1)),
                            ),
                            SizedBox(
                              width: Constants.getSize(context).width * 0.1,
                            ),
                            Container(
                              color: Colors.yellow,
                              width: Constants.getSize(context).width * 0.4,
                              alignment: Alignment.centerRight,
                              child: Text(
                                "\$" + _data[i].amount.toString(),
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(122, 158, 159, 1)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Constants.getSize(context).height * 0.017,
                        ),
                        Text(
                          p.toString(),
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(184, 216, 216, 1)),
                        )
                      ],
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>
                              ExpenseDetailScreen(i, _data[i], p)));
                },
              );
            },
            itemCount: _data.length,
          )
        : Center(
            child: Text(
              "Add some Transactions",
              style: TextStyle(
                  color: Color.fromRGBO(122, 158, 159, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
          );
  }
}

import 'package:ExpensePlanner/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  Widget _fieldBuilder(
      IconData icon, String text, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromRGBO(238, 245, 219, 1),
      ),
      width: Constants.getSize(context).width * 0.8,
      height: Constants.getSize(context).height * 0.06,
      child: TextField(
        cursorColor: Color.fromRGBO(122, 158, 159, 1),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            icon,
            color: Color.fromRGBO(122, 158, 159, 1),
          ),
          hintText: text,
        ),
      ),
    );
  }

  static TextEditingController _emailController = new TextEditingController();
  static TextEditingController _passwordController =
  new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(79, 99, 103, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: Constants.getSize(context).width * 0.06),
              color: Color.fromRGBO(79, 99, 103, 1),
              width: Constants.getSize(context).width,
              height: Constants.getSize(context).height * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Welcome,",
                    style: TextStyle(
                      color: Color.fromRGBO(238, 245, 219, 1),
                      fontSize: 23,
                    ),
                  ),
                  SizedBox(
                    height: Constants.getSize(context).height * 0.01,
                  ),
                  Text(
                    "SIGNUP",
                    style: TextStyle(
                      color: Color.fromRGBO(238, 245, 219, 1),
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: Constants.getSize(context).height * 0.04,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Constants.getSize(context).height * 0.04,
            ),
            _fieldBuilder(Icons.person, "Email", _emailController),
            SizedBox(
              height: Constants.getSize(context).height * 0.04,
            ),
            _fieldBuilder(Icons.vpn_key, "Password", _passwordController),
            SizedBox(
              height: Constants.getSize(context).height * 0.04,
            ),
            _fieldBuilder(Icons.vpn_key, "Confirm Password", _passwordController),
            SizedBox(
              height: Constants.getSize(context).height * 0.04,
            ),
            Container(
              width: Constants.getSize(context).width * 0.8,
              height: Constants.getSize(context).height * 0.06,
              //decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color.fromRGBO(122, 158, 159, 1),
                onPressed: () {},
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: Color.fromRGBO(238, 245, 219, 1),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=> LoginScreen()));

                },
                child: Text(
                  "Already have an account? | Log In",
                  style: TextStyle(color: Color.fromRGBO(122, 158, 159, 1)),
                ))
          ],
        ),
      ),
    );
  }
}

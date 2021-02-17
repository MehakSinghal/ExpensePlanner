import 'package:ExpensePlanner/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscurePassword = true;
  bool _isLogin = true;
  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  static TextEditingController _emailController = new TextEditingController();
  static TextEditingController _passwordController =
      new TextEditingController();
  static TextEditingController _confirm = new TextEditingController();

  void _makeUser(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      if (_isLogin) {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      } else {
        if (_passwordController.text == _confirm.text) {
          UserCredential user = await _auth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
          final url = "https://expense-planner-96018-default-rtdb.firebaseio.com/users.json";
          final response = await http.post(url,body:json.encode({
            'email': _emailController.text,
            'password':_passwordController.text,
            'id' : _auth.currentUser.uid,
          }) );
        } else {
          /*Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Match the passwords!")));*/
        }
      }
    } on PlatformException catch (err) {
      var message = 'Please check your credentials';
      if (err.message != null) {
        message = err.message;
      }
     /* Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));*/
      setState(() {
        isLoading = false;
      });
    } catch (err) {
      setState(() {
        isLoading = false;
      });
    }
  }

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
                    _isLogin ? "Welcome Back," : "Welcome,",
                    style: TextStyle(
                      color: Color.fromRGBO(238, 245, 219, 1),
                      fontSize: 23,
                    ),
                  ),
                  SizedBox(
                    height: Constants.getSize(context).height * 0.01,
                  ),
                  Text(
                    _isLogin ? "LOGIN" : "SIGNUP",
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromRGBO(238, 245, 219, 1),
              ),
              width: Constants.getSize(context).width * 0.8,
              height: Constants.getSize(context).height * 0.06,
              margin: EdgeInsets.only(
                  top: Constants.getSize(context).height * 0.04,
                  bottom: Constants.getSize(context).height * 0.04),
              child: TextField(
                cursorColor: Color.fromRGBO(122, 158, 159, 1),
                obscureText: false,
                controller: _emailController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color.fromRGBO(122, 158, 159, 1),
                  ),
                  hintText: "Email",
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromRGBO(238, 245, 219, 1),
              ),
              width: Constants.getSize(context).width * 0.8,
              height: Constants.getSize(context).height * 0.06,
              margin: EdgeInsets.only(
                  bottom: Constants.getSize(context).height * 0.04),
              child: TextField(
                cursorColor: Color.fromRGBO(122, 158, 159, 1),
                obscureText: _isLogin ? _isObscurePassword : false,
                controller: _passwordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                    ),
                    color: _isLogin
                        ? Color.fromRGBO(122, 158, 159, 1)
                        : Color.fromRGBO(238, 245, 219, 1),
                    onPressed: () {
                      setState(() {
                        _isObscurePassword = !_isObscurePassword;
                      });
                    },
                  ),
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: Color.fromRGBO(122, 158, 159, 1),
                  ),
                  hintText: "Password (minimum 6 characters long)",
                ),
              ),
            ),
            if (!_isLogin)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromRGBO(238, 245, 219, 1),
                ),
                width: Constants.getSize(context).width * 0.8,
                height: Constants.getSize(context).height * 0.06,
                margin: EdgeInsets.only(
                    bottom: Constants.getSize(context).height * 0.04),
                child: TextField(
                  cursorColor: Color.fromRGBO(122, 158, 159, 1),
                  controller: _confirm,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Color.fromRGBO(122, 158, 159, 1),
                    ),
                    hintText: "Confirm Password",
                  ),
                ),
              ),
            Container(
              width: Constants.getSize(context).width * 0.8,
              height: Constants.getSize(context).height * 0.06,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color.fromRGBO(122, 158, 159, 1),
                onPressed: () => _makeUser(context),
                child: isLoading
                    ? CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Color.fromRGBO(238, 245, 219, 1)))
                    : Text(
                        _isLogin ? "Login" : "Signup",
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
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Text(
                  _isLogin
                      ? "Do not have an account? | Sign Up"
                      : "Already have an account? | Log In",
                  style: TextStyle(color: Color.fromRGBO(122, 158, 159, 1)),
                ))
          ],
        ),
      ),
    );
  }
}

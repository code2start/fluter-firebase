import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Enter your email'),
              onChanged: (value) {
                setState(() {
                  this._email = value;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Enter your password'),
              onChanged: (value) {
                setState(() {
                  this._password = value;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(child: Text('Login'), onPressed: () {}),
            FlatButton(
              onPressed: () {},
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

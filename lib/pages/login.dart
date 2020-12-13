import 'package:firebase/pages/home.dart';
import 'package:firebase/pages/register.dart';
import 'package:firebase/provider/auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email, _password;
  var loginKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: loginKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              RaisedButton(
                  child: Column(
                    children: [
                      prov.authStatus == AuthStatus.authentecating
                          ? CircularProgressIndicator()
                          : Text('Login'),
                    ],
                  ),
                  onPressed: () async {
                    if (!await prov.login(_email, _password)) {
                      loginKey.currentState.showSnackBar(
                          SnackBar(content: Text(prov.errorMessage)));
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(prov.user),
                        ),
                      );
                    }
                  }),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register(),
                    ),
                  );
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

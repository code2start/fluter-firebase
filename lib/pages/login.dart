import 'package:firebase/pages/home.dart';
import 'package:firebase/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email, _password;
  FirebaseAuth instance = FirebaseAuth.instance;
  var loginKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
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
                  child: Text('Login'),
                  onPressed: () async {
                    try {
                      UserCredential credential =
                          await instance.signInWithEmailAndPassword(
                              email: _email, password: _password);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'invalid-email') {
                        loginKey.currentState.showSnackBar(
                            SnackBar(content: Text('Invalid Email')));
                        print('Invalid email');
                      }
                      if (e.code == 'user-not-found') {
                        loginKey.currentState.showSnackBar(
                            SnackBar(content: Text('User not found')));
                        print('Hi, User not found');
                      } else if (e.code == 'wrong-password') {
                        loginKey.currentState.showSnackBar(
                            SnackBar(content: Text('Wrong Password')));
                      }
                    } catch (e) {
                      print(e.code);
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

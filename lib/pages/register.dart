import 'package:firebase/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _name, _email, _password;
  FirebaseAuth instance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an account'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Enter your name'),
                onChanged: (value) {
                  setState(() {
                    this._name = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
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
                  child: Text('Register'),
                  onPressed: () async {
                    try {
                      UserCredential credential =
                          await instance.createUserWithEmailAndPassword(
                              email: this._email, password: this._password);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        //show snackBar
                      } else if (e.code == 'email-already-in-use') {
                        //show snackBarf
                      }
                      //print('exception');
                    }
                  }),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

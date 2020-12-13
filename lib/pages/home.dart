import 'package:firebase/pages/login.dart';
import 'package:firebase/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final User user;
  Home(this.user);

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                prov.logout();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              })
        ],
      ),
      body: Center(
        child: Text(prov.user.email),
      ),
    );
  }
}

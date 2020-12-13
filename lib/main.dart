import 'package:firebase/pages/home.dart';
import 'package:firebase/pages/login.dart';
import 'package:firebase/provider/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
          child: MyApp(),
        ),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _showScreen(context),
    );
  }

  Widget _showScreen(context) {
    var prov = Provider.of<AuthProvider>(context);
    switch (prov.authStatus) {
      case AuthStatus.authentecating:
      case AuthStatus.unAuthenticated:
        return Login();
      case AuthStatus.authenticated:
        return Home(prov.user);
    }
    return Container();
  }
}

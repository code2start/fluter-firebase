import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum AuthStatus { unAuthenticated, authentecating, authenticated }

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  AuthStatus _authStatus;
  String errorMessage;

  AuthProvider() {
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        _authStatus = AuthStatus.unAuthenticated;
      } else {
        _user = user;
      }
      notifyListeners();
    });
  }

  AuthStatus get authStatus => _authStatus;
  User get user => _user;

  Future<bool> login(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _authStatus = AuthStatus.authentecating;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        errorMessage = "Your email is invalid";
        print('Invalid email');
      }
      if (e.code == 'user-not-found') {
        errorMessage = "User not found";
        print('Hi, User not found');
      } else if (e.code == 'wrong-password') {
        errorMessage = "Your password is not correct";
      }
    } catch (e) {
      print(e.code);
    }
  }

  logout() async {
    await _auth.signOut();
    _authStatus = AuthStatus.unAuthenticated;
    notifyListeners();
  }
}

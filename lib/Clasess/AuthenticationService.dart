import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Authentication_Pages/loginPage.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut(context) async {
    await _firebaseAuth.signOut();
    Navigator.pop(context);
    Navigator.pushNamed(context, '/loginPage');
  }

}

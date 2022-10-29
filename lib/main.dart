// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:budget_app/Authentication_Pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Authentication_Pages/registrationPage.dart';
import 'Clasess/AuthenticationService.dart';
import 'HomeScreen.dart';
import 'budget.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            initialData: null,
            create: (context) =>
            context
                .read<AuthenticationService>()
                .authStateChanges),
      ],
      child: AuthenticatorWrapper(),
    );
  }
}
//
// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     title: 'Login page',
//     theme: ThemeData(
//         primarySwatch: Colors.green
//     ),
//     initialRoute: "/monts",
//     routes: {
//       // "/": (context) => const LoginPage(),
//       "/months": (context) => const monthPage(),
//       "/register": (context) => const RegisterPage(),
//       "/budget": (context) => const BudgetPage(),
//     },
//   );
// }

//}

class AuthenticatorWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    context.read<AuthenticationService>().signOut();

    final firebaseuser = context.watch<User?>();
    var temp = null;


    if (firebaseuser != null) {
      temp = monthPage();
    } else
      temp = LoginPage();


    return MaterialApp(
      home: temp,
      theme: ThemeData(
          primarySwatch: Colors.red
      ),
      routes: {
        // "/": (context) => const LoginPage(),
        "/months": (context) => const monthPage(),
        "/register": (context) => const RegisterPage(),
        "/budget": (context) => const BudgetPage(),
      },
    );
  }
}

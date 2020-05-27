import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/login_flow/pages/signin_page.dart';
import 'package:stay_home_polls_app/main.dart';

class SignInFlowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.orangeAccent,
        textTheme: AppConstants.of(context).textTheme,
      ),
      home: Scaffold(
        body: SignInPage(),
        backgroundColor: Colors.white,
      ),
    );
  }
}

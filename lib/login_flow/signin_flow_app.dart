import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/login_flow/pages/signin_page.dart';
import 'package:stay_home_polls_app/login_flow/pages/splash_page.dart';

class SignInFlowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.orangeAccent,
        fontFamily: 'Nunito',
      ),
      home: Scaffold(
        /*  body: SplashPage(), */
        body: SignInPage(),
        backgroundColor: Colors.white,
      ),
    );
  }
}

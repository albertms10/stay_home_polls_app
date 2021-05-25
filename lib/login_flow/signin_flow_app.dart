import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/login_flow/pages/signin_page.dart';
import 'package:stay_home_polls_app/main.dart';

class SignInFlowApp extends StatelessWidget {
  const SignInFlowApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        colorScheme: const ColorScheme.light(
          secondary: Colors.orangeAccent,
        ),
        textTheme: AppConstants.of(context).textTheme,
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SignInPage(),
        backgroundColor: Colors.white,
      ),
    );
  }
}

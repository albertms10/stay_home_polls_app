import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stay_home_polls_app/constants/font_const.dart';
import 'package:stay_home_polls_app/login_flow/pages/signin_page.dart';

class SignInFlowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.orangeAccent,
        textTheme: GoogleFonts.getTextTheme(fontFamily),
      ),
      home: Scaffold(
        body: SignInPage(),
        backgroundColor: Colors.white,
      ),
    );
  }
}

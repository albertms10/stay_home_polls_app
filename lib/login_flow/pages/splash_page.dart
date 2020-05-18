import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  final String error;
  const SplashPage({this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: error != null ? Text(error) : CircularProgressIndicator(),
        ),
      ),
    );
  }
}

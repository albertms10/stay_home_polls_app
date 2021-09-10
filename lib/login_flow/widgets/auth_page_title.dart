import 'package:flutter/material.dart';

class AuthPageTitle extends StatelessWidget {
  final String text;

  const AuthPageTitle(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.grey[500],
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

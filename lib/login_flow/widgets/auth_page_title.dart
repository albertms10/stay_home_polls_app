import 'package:flutter/material.dart';

class AuthPageTitle extends StatelessWidget {
  final String text;

  const AuthPageTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.grey[500],
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

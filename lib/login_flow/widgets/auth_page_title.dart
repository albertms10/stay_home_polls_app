import 'package:flutter/material.dart';

class AuthPageTitle extends StatelessWidget {
  final String text;
  AuthPageTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        this.text,
        style: TextStyle(
          fontSize: 30,
          color: Colors.grey[500],
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

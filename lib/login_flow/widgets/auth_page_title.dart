import 'package:flutter/material.dart';

class AuthPageTitle extends StatelessWidget {
  final String text;
  AuthPageTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        this.text,
        style: TextStyle(
          fontSize: 40,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

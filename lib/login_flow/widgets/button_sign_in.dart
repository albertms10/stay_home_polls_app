import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String text;
  final Color color;
  final void Function() onPressed;

  const SignInButton({
    this.text = 'Sign in',
    this.color = Colors.white,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      color: color,
      padding: const EdgeInsets.all(16.0),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );
  }
}

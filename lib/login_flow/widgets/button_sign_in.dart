import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String text;
  final Color color;
  final void Function() onPressed;

  const SignInButton({
    Key key,
    this.text = 'Sign in',
    this.color = Colors.white,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: color,
        padding: const EdgeInsets.all(16.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );
  }
}

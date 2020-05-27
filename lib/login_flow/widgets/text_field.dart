import 'package:flutter/material.dart';

enum SignInTextFieldType { email, password }

class SignInTextField extends StatefulWidget {
  final SignInTextFieldType type;
  final TextEditingController controller;
  final Color accentColor;

  SignInTextField(this.type, this.controller, this.accentColor);

  @override
  _SignInTextFieldState createState() => _SignInTextFieldState();
}

class _SignInTextFieldState extends State<SignInTextField> {
  bool _viewPassword = false;

  get isPassword => widget.type == SignInTextFieldType.password;

  @override
  Widget build(BuildContext context) {
    Widget eye;
    if (isPassword)
      eye = IconButton(
        icon: Icon(_viewPassword ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() => _viewPassword = !_viewPassword);
        },
      );

    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        fillColor: widget.accentColor,
        border: OutlineInputBorder(),
        labelText: isPassword ? 'Password' : 'Email',
        labelStyle: TextStyle(color: Colors.grey[600]),
        suffixIcon: eye,
      ),
      keyboardType: widget.type == SignInTextFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      obscureText: isPassword && !_viewPassword,
    );
  }
}

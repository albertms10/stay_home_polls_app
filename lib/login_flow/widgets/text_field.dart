import 'package:flutter/material.dart';

enum SignInTextFieldType { email, password }

class SignInTextField extends StatefulWidget {
  final SignInTextFieldType type;
  final TextEditingController controller;
  SignInTextField(this.type, this.controller);

  @override
  _SignInTextFieldState createState() => _SignInTextFieldState();
}

class _SignInTextFieldState extends State<SignInTextField> {
  bool _viewPassword = false;

  get isPassword => widget.type == SignInTextFieldType.password;

  @override
  Widget build(BuildContext context) {
    Widget eye;
    if (isPassword) {
      eye = IconButton(
        icon: Icon(_viewPassword ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() => _viewPassword = !_viewPassword);
        },
      );
    }
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
        hintText: isPassword ? 'Password' : 'Email',
        hintStyle: TextStyle(color: Colors.grey[400]),
        suffixIcon: eye,
      ),
      keyboardType:
          isPassword ? TextInputType.emailAddress : TextInputType.text,
      obscureText: isPassword && !_viewPassword,
    );
  }
}

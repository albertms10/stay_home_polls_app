import 'package:flutter/material.dart';

enum SignInTextFieldType { email, password }

class SignInTextField extends StatefulWidget {
  final SignInTextFieldType type;
  final TextEditingController controller;
  final Color fillColor;
  final void Function() action;

  const SignInTextField({
    this.type,
    this.controller,
    this.fillColor,
    this.action,
  });

  @override
  _SignInTextFieldState createState() => _SignInTextFieldState();
}

class _SignInTextFieldState extends State<SignInTextField> {
  bool _viewPassword;

  @override
  void initState() {
    super.initState();

    _viewPassword = false;
  }

  bool get isPassword => widget.type == SignInTextFieldType.password;

  @override
  Widget build(BuildContext context) {
    Widget eye;

    if (isPassword) {
      eye = IconButton(
        icon: Icon(_viewPassword ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => _viewPassword = !_viewPassword),
      );
    }

    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value.isEmpty) return 'Please, fill this field';

        return null;
      },
      decoration: InputDecoration(
        fillColor: widget.fillColor,
        border: const OutlineInputBorder(),
        labelText: isPassword ? 'Password' : 'Email',
        labelStyle: TextStyle(color: Colors.grey[600]),
        suffixIcon: eye,
      ),
      textInputAction: widget.type == SignInTextFieldType.email
          ? TextInputAction.next
          : TextInputAction.done,
      onFieldSubmitted: (value) => widget.type == SignInTextFieldType.email
          ? FocusScope.of(context).nextFocus()
          : widget.action(),
      keyboardType: widget.type == SignInTextFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      obscureText: isPassword && !_viewPassword,
    );
  }
}

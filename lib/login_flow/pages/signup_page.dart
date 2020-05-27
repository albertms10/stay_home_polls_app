import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/login_flow/widgets/auth_page_title.dart';
import 'package:stay_home_polls_app/login_flow/widgets/button_sign_in.dart';
import 'package:stay_home_polls_app/login_flow/widgets/text_field.dart';

class EmailAndPassword {
  final String email, password;
  EmailAndPassword(this.email, this.password);

  toString() => "Email: '$email' / Password: '$password'";
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var _email = TextEditingController();
  var _password = TextEditingController();

  final primaryColor = Colors.teal;
  final accentColor = Colors.orangeAccent;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.teal),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 70),
                AuthPageTitle('Register'),
                SizedBox(height: 24),
                SignInTextField(
                  type: SignInTextFieldType.email,
                  controller: _email,
                  accentColor: accentColor,
                ),
                SizedBox(height: 24),
                SignInTextField(
                  type: SignInTextFieldType.password,
                  controller: _password,
                  accentColor: accentColor,
                ),
                SizedBox(height: 48),
                SignInButton(
                  text: 'Register',
                  color: primaryColor,
                  onPressed: () {
                    if (_formKey.currentState.validate())
                      Navigator.of(context).pop(
                        EmailAndPassword(_email.text, _password.text),
                      );
                  },
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(width: 8),
                    FlatButton(
                      padding: const EdgeInsets.all(8),
                      child: Text('Sign in'),
                      textColor: primaryColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/login_flow/pages/signin_page.dart';
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
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final primaryColor = Colors.teal;
  final accentColor = Colors.orangeAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.teal, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 70),
              AuthPageTitle('Register'),
              SizedBox(height: 24),
              SignInTextField(SignInTextFieldType.email, _email, accentColor),
              SizedBox(height: 24),
              SignInTextField(
                  SignInTextFieldType.password, _password, accentColor),
              SizedBox(height: 48),
              SignInButton(
                text: 'Register',
                color: primaryColor,
                onPressed: () {
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
                  FlatButton(
                    child: Text('Go back'),
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
    );
  }
}

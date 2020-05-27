import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/login_flow/auth_state_switch.dart';
import 'package:stay_home_polls_app/login_flow/pages/signup_page.dart';
import 'package:stay_home_polls_app/login_flow/widgets/auth_page_title.dart';
import 'package:stay_home_polls_app/login_flow/widgets/button_sign_in.dart';
import 'package:stay_home_polls_app/login_flow/widgets/text_field.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _showProgress = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  _showSnackbar(String message, [Color backgroundColor = Colors.black87]) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  _waitAndCheckErrors(Function signInFunc) async {
    setState(() => _showProgress = true);
    try {
      await signInFunc();
    } catch (e) {
      _showSnackbar(e.toString(), Colors.red);
      setState(() => _showProgress = false);
    }
  }

  _signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  _signInWithEmailAndPassword() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _email.text,
      password: _password.text,
    );
  }

  _createUserWithEmailAndPassword(EmailAndPassword emailAndPassword) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAndPassword.email, password: emailAndPassword.password);
  }

  @override
  Widget build(BuildContext context) {
    if (_showProgress) return Center(child: CircularProgressIndicator());

    final SignInConfig config = Provider.of<SignInConfig>(context);
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 120),
              Image(
                image: AssetImage('assets/icons/logo.png'),
                height: 100,
              ),
              SizedBox(height: 6),
              AuthPageTitle('StayHomePolls'),
              SizedBox(height: 32),
              SignInTextField(
                SignInTextFieldType.email,
                _email,
                accentColor,
              ),
              SizedBox(height: 16),
              SignInTextField(
                SignInTextFieldType.password,
                _password,
                accentColor,
              ),
              SizedBox(height: 32),
              SignInButton(
                color: primaryColor,
                onPressed: () =>
                    _waitAndCheckErrors(_signInWithEmailAndPassword),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'First time here?',
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                  FlatButton(
                    child: Text('Register'),
                    textColor: primaryColor,
                    onPressed: () async {
                      EmailAndPassword result =
                          await Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => SignUpPage()),
                      );
                      if (result != null) {
                        _createUserWithEmailAndPassword(result);
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 40),
              if (config.canLoginAnonymously)
                FlatButton(
                  child: Text(
                    'Sign in anonymously',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  onPressed: () => _waitAndCheckErrors(_signInAnonymously),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

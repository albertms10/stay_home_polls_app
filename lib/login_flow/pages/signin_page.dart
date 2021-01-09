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
  var _showProgress = false;
  var _email = TextEditingController();
  var _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _showSnackbar(String message, [Color backgroundColor = Colors.black87]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  void _waitAndCheckErrors(Function signInFunction) async {
    setState(() => _showProgress = true);
    try {
      await signInFunction();
    } catch (e) {
      _showSnackbar(e.toString(), Colors.red);
      setState(() => _showProgress = false);
    }
  }

  void _signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  void _signInWithEmailAndPassword() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _email.text.trim(),
      password: _password.text.trim(),
    );
  }

  void _createUserWithEmailAndPassword(
      EmailAndPassword emailAndPassword) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAndPassword.email.trim(),
        password: emailAndPassword.password.trim());
  }

  void _signIn() {
    if (_formKey.currentState.validate()) {
      _waitAndCheckErrors(_signInWithEmailAndPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showProgress) return Center(child: CircularProgressIndicator());

    final SignInConfig config = Provider.of<SignInConfig>(context);
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 120),
              Image(
                image: AssetImage('assets/icons/android_icon.png'),
                height: 100,
              ),
              SizedBox(height: 16),
              AuthPageTitle('StayHomePolls'),
              SizedBox(height: 32),
              SignInTextField(
                type: SignInTextFieldType.email,
                controller: _email,
                accentColor: accentColor,
              ),
              SizedBox(height: 16),
              SignInTextField(
                type: SignInTextFieldType.password,
                controller: _password,
                accentColor: accentColor,
                action: _signIn,
              ),
              SizedBox(height: 32),
              SignInButton(
                color: primaryColor,
                onPressed: _signIn,
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
                  SizedBox(width: 8),
                  FlatButton(
                    padding: const EdgeInsets.all(8),
                    child: Text('Register'),
                    textColor: primaryColor,
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (builder) => SignUpPage()))
                          .then((result) {
                        if (result != null && result is EmailAndPassword)
                          _createUserWithEmailAndPassword(result);
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 40),
              if (config.canSignInAnonymously)
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

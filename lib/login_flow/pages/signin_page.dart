import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/login_flow/auth_state_switch.dart';
import 'package:stay_home_polls_app/login_flow/pages/signup_page.dart';
import 'package:stay_home_polls_app/login_flow/widgets/auth_page_title.dart';
import 'package:stay_home_polls_app/login_flow/widgets/button_sign_in.dart';
import 'package:stay_home_polls_app/login_flow/widgets/text_field.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage();

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> _formKey;

  TextEditingController _email;
  TextEditingController _password;

  bool _showProgress;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();

    _email = TextEditingController();
    _password = TextEditingController();

    _showProgress = false;
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  void _showSnackbar(String message, [Color backgroundColor = Colors.black87]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  void _waitAndCheckErrors(Future<void> Function() signInFunction) async {
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
    EmailAndPassword emailAndPassword,
  ) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAndPassword.email.trim(),
      password: emailAndPassword.password.trim(),
    );
  }

  void _signIn() {
    if (_formKey.currentState.validate()) {
      _waitAndCheckErrors(_signInWithEmailAndPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showProgress) return const Center(child: CircularProgressIndicator());

    final theme = Theme.of(context);
    final config = Provider.of<SignInConfig>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 120.0),
              const Image(
                image: AssetImage('assets/icons/android_icon.png'),
                height: 100.0,
              ),
              const SizedBox(height: 16.0),
              const AuthPageTitle('StayHomePolls'),
              const SizedBox(height: 32.0),
              SignInTextField(
                type: SignInTextFieldType.email,
                controller: _email,
                fillColor: theme.colorScheme.secondary,
              ),
              const SizedBox(height: 16.0),
              SignInTextField(
                type: SignInTextFieldType.password,
                controller: _password,
                fillColor: theme.colorScheme.secondary,
                action: _signIn,
              ),
              const SizedBox(height: 32.0),
              SignInButton(
                color: theme.primaryColor,
                onPressed: _signIn,
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'First time here?',
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  TextButton(
                    style: TextButton.styleFrom(
                      onSurface: theme.primaryColor,
                      padding: const EdgeInsets.all(8.0),
                    ),
                    onPressed: () async {
                      final emailAndPassword = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );

                      if (emailAndPassword != null &&
                          emailAndPassword is EmailAndPassword) {
                        _createUserWithEmailAndPassword(emailAndPassword);
                      }
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              if (config.canSignInAnonymously)
                TextButton(
                  onPressed: () => _waitAndCheckErrors(_signInAnonymously),
                  child: Text(
                    'Sign in anonymously',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

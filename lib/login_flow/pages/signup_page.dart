import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/login_flow/widgets/auth_page_title.dart';
import 'package:stay_home_polls_app/login_flow/widgets/button_sign_in.dart';
import 'package:stay_home_polls_app/login_flow/widgets/text_field.dart';

class EmailAndPassword {
  final String email;
  final String password;

  const EmailAndPassword(this.email, this.password);

  @override
  String toString() => "Email: '$email' / Password: '$password'";
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> _formKey;

  TextEditingController _email;
  TextEditingController _password;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();

    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.teal),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 70.0),
                const AuthPageTitle('Register'),
                const SizedBox(height: 24.0),
                SignInTextField(
                  type: SignInTextFieldType.email,
                  controller: _email,
                  fillColor: theme.colorScheme.secondary,
                ),
                const SizedBox(height: 24.0),
                SignInTextField(
                  type: SignInTextFieldType.password,
                  controller: _password,
                  fillColor: theme.colorScheme.secondary,
                ),
                const SizedBox(height: 48.0),
                SignInButton(
                  text: 'Register',
                  color: theme.primaryColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.of(context).pop(
                        EmailAndPassword(_email.text, _password.text),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
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
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Sign in'),
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

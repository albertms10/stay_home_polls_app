import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/login_flow/signin_flow_app.dart';
import 'package:stay_home_polls_app/login_flow/pages/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/user.dart';

class SignInConfig {
  final bool canSignInAnonymously;

  const SignInConfig({this.canSignInAnonymously = false});
}

class AuthStateSwitch extends StatelessWidget {
  final Widget app;
  final SignInConfig signInConfig;

  const AuthStateSwitch({
    this.app,
    this.signInConfig = const SignInConfig(),
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasError) return SplashPage(error: snapshot.error);

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const SplashPage(error: 'Connection state is none');

          case ConnectionState.waiting:
            return const SplashPage();

          case ConnectionState.active:
            final user = snapshot.data;

            if (user == null) {
              return Provider<SignInConfig>.value(
                value: signInConfig,
                child: const SignInFlowApp(),
              );
            } else {
              return Provider<User>.value(
                value: User(
                  id: user.uid,
                  displayName: user.displayName,
                ),
                child: app,
              );
            }

            break;

          case ConnectionState.done:
          default:
            return const SplashPage(error: 'Connection state is done');
        }
      },
    );
  }
}

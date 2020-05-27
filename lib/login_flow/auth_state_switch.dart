import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/login_flow/signin_flow_app.dart';
import 'package:stay_home_polls_app/login_flow/pages/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/user.dart';

class SignInConfig {
  bool canSignInAnonymously;
  SignInConfig(this.canSignInAnonymously);
}

class AuthStateSwitch extends StatelessWidget {
  final SignInConfig signInConfig;
  final Widget app;

  AuthStateSwitch(this.app, {bool canSignInAnonymously = false})
      : signInConfig = SignInConfig(canSignInAnonymously);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasError) return SplashPage(error: snapshot.error);

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return SplashPage(error: "Connection state is none");

          case ConnectionState.waiting:
            return SplashPage();

          case ConnectionState.active:
            final FirebaseUser user = snapshot.data;
            return user == null
                ? Provider<SignInConfig>.value(
                    value: signInConfig,
                    child: SignInFlowApp(),
                  )
                : Provider<User>.value(
                    value: User(
                      id: user.uid,
                      displayName: user.displayName,
                    ),
                    child: this.app,
                  );

          case ConnectionState.done:
          default:
            return SplashPage(error: "Connection state is done");
        }
      },
    );
  }
}

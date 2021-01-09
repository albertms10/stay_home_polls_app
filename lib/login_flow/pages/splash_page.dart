import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/login_flow/widgets/auth_page_title.dart';
import 'package:stay_home_polls_app/main.dart';

class SplashPage extends StatelessWidget {
  final String error;
  const SplashPage({this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.orangeAccent,
        textTheme: AppConstants.of(context).textTheme,
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/icons/android_icon.png'),
                  height: 100,
                ),
                SizedBox(height: 6),
                AuthPageTitle('StayHomePolls'),
                SizedBox(height: 24),
                Center(
                  child:
                      error != null ? Text(error) : CircularProgressIndicator()
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

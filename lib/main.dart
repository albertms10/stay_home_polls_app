import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/login_flow/auth_state_switch.dart';
import 'package:stay_home_polls_app/pages/home_page.dart';

void main() => runApp(AuthStateSwitch(StayHomePollsApp()));

class StayHomePollsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const title = 'Stay Home Polls';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.orangeAccent,
      ),
      home: HomePage(title: title),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/pages/home-page.dart';

void main() => runApp(StayHomePollsApp());

class StayHomePollsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stay Home Polls',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(title: 'Stay Home Polls'),
    );
  }
}

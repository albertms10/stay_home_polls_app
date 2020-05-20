import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/widgets/poll_form.dart';

class NewPoll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New poll'),
      ),
      body: PollForm(),
    );
  }
}

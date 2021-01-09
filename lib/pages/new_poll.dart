import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/main.dart';
import 'package:stay_home_polls_app/widgets/poll_form.dart';

class NewPoll extends StatelessWidget {
  const NewPoll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New poll',
          style: AppConstants.of(context).font.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        brightness: Brightness.dark,
      ),
      body: const PollForm(),
    );
  }
}

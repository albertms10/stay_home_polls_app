import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stay_home_polls_app/main.dart';
import 'package:stay_home_polls_app/widgets/poll_form.dart';

class NewPoll extends StatelessWidget {
  const NewPoll({Key key}) : super(key: key);

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
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: const PollForm(),
    );
  }
}

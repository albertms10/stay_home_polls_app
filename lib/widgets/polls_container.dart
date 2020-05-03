import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/widgets/polls_list.dart';

class PollsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Poll>>(
      stream: pollListSnapshots(),
      builder: (context, AsyncSnapshot<List<Poll>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('ERROR: ${snapshot.error.toString()}'));
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.active:
            return PollsList(polls: snapshot.data);
          case ConnectionState.done:
            return Center(child: Text("done??"));
          case ConnectionState.none:
          default:
            return Center(child: Text("no hi ha stream??"));
        }
      },
    );
  }

}

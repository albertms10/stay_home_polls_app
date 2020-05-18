import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';
import 'package:stay_home_polls_app/widgets/polls_list.dart';

class PollsContainer extends StatelessWidget {
  final Stream<List<Poll>> streamPollsList;
  final Function filterCallback;

  PollsContainer({this.streamPollsList, this.filterCallback});

  StreamBuilder _streamBuilder(stream, Function callback) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError)
          return Center(child: Text('Error: ${snapshot.error}'));

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.active:
            return callback(snapshot.data);
          case ConnectionState.done:
            return Center(child: Text("Connection done"));
          case ConnectionState.none:
          default:
            return Center(child: Text("No stream"));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return _streamBuilder(streamPollsList, (List<Poll> polls) {
      return _streamBuilder(user.pollsSnapshots(), (List<Poll> userPolls) {
        return PollsList(
            polls: filterCallback != null
                ? filterCallback(polls, userPolls)
                : polls);
      });
    });
  }
}

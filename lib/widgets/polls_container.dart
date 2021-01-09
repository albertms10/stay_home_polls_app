import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';
import 'package:stay_home_polls_app/widgets/polls_list.dart';

class PollsContainer<T extends Poll> extends StatelessWidget {
  final Stream<List<T>> streamPollsList;
  final List<T> Function(List<T>, List<T>) filterCallback;

  const PollsContainer({this.streamPollsList, this.filterCallback});

  StreamBuilder<List<T>> _streamBuilder({
    Stream<List<T>> stream,
    Widget Function(BuildContext, List<T>) builder,
  }) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());

          case ConnectionState.active:
            return builder(context, snapshot.data);

          case ConnectionState.done:
            return const Center(child: Text('Connection done'));

          case ConnectionState.none:
          default:
            return const Center(child: Text('No stream'));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return _streamBuilder(
      stream: streamPollsList,
      builder: (context, polls) {
        return _streamBuilder(
          stream: user.pollsSnapshots(),
          builder: (context, userPolls) {
            return PollsList(
              polls: filterCallback != null
                  ? filterCallback(polls, userPolls)
                  : polls,
            );
          },
        );
      },
    );
  }
}

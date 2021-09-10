import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';
import 'package:stay_home_polls_app/widgets/polls_list.dart';

class PollsContainer<T extends Poll> extends StatelessWidget {
  final Stream<List<T>> streamPollsList;
  final List<T> Function(List<T>, List<T>) filterCallback;

  const PollsContainer({Key key, this.streamPollsList, this.filterCallback})
      : super(key: key);

  StreamBuilder<List<List<T>>> _streamsBuilder({
    Stream<List<List<T>>> streams,
    Widget Function(BuildContext, AsyncSnapshot<List<List<T>>>) builder,
  }) {
    return StreamBuilder(
      stream: streams,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());

          case ConnectionState.active:
            return builder(context, snapshot);

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

    return _streamsBuilder(
      streams: StreamZip([
        streamPollsList,
        user.pollsSnapshots() as Stream<List<T>>,
      ]),
      builder: (context, streams) {
        final polls = streams.data.first;
        final userPolls = streams.data.last;

        return PollsList(
          polls:
              filterCallback != null ? filterCallback(polls, userPolls) : polls,
        );
      },
    );
  }
}

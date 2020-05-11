import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';
import 'package:stay_home_polls_app/widgets/poll_tile.dart';

class PollsList extends StatelessWidget {
  final List<Poll> polls;
  final user = User(id: 'Ap8s7eym7sY32CnuGIgM', displayName: 'Albert');

  PollsList({this.polls});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: polls.length,
      itemBuilder: (context, int index) => Dismissible(
        key: Key(polls[index].id),
        child: PollTile(poll: polls[index]),
        onDismissed: (_) {
          user.dismiss(polls[index]);
          polls.removeAt(index);
        },
      ),
    );
  }
}

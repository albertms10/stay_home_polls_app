import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';
import 'package:stay_home_polls_app/widgets/poll_tile.dart';

class PollsList extends StatelessWidget {
  final List<Poll> polls;
  final String emptyMessage;

  PollsList({this.polls, this.emptyMessage});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return polls.length > 0
        ? ListView.builder(
            itemCount: polls.length,
            itemBuilder: (context, int index) {
              return Dismissible(
                key: Key(polls[index].id),
                child: Container(
                  child: PollTile(poll: polls[index]),
                  margin: index == polls.length - 1
                      ? const EdgeInsets.only(bottom: 50)
                      : null,
                ),
                onDismissed: (_) {
                  user.dismiss(polls[index]);
                  polls.removeAt(index);
                },
              );
            })
        : NoPolls(text: emptyMessage);
  }
}

class NoPolls extends StatelessWidget {
  final String text;

  NoPolls({this.text = 'No polls yet'});

  @override
  Widget build(BuildContext context) {
    final _random = Random();
    const emojis = [
      "¯\\_(ツ)_/¯",
      "⚆ _ ⚆",
      "◔̯◔",
      "(╯°□°)╯",
      "ԅ། – ‸ – །ᕗ",
      "ᕙ(⇀‸↼‶)ᕗ",
      "( ͡° ͜ʖ ͡°)",
    ];

    return Center(
      child: Text(
        '$text\n${emojis[_random.nextInt(emojis.length)]}',
        style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 24),
        textAlign: TextAlign.center,
      ),
    );
  }
}

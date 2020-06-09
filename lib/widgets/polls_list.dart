import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';
import 'package:stay_home_polls_app/widgets/poll_tile.dart';

class PollsList extends StatelessWidget {
  final List<Poll> polls;

  PollsList({this.polls});

  final _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return polls.length > 0
        ? AnimatedList(
            key: _listKey,
            initialItemCount: polls.length,
            itemBuilder: (context, index, animation) {
              final _container = Container(
                child: PollTile(poll: polls[index]),
                margin: index == polls.length - 1
                    ? const EdgeInsets.only(bottom: 50)
                    : null,
              );

              return SlideTransition(
                position: animation.drive(
                  Tween<Offset>(
                    begin: const Offset(0, 0),
                    end: const Offset(0, 0),
                  ),
                ),
                child: polls[index].isAuth || polls[index].voteValue != null
                    ? _container
                    : Dismissible(
                        key: Key(polls[index].id),
                        child: _container,
                        onDismissed: (_) {
                          user.dismiss(polls[index]);
                          _listKey.currentState.removeItem(
                              index,
                              (context, animation) =>
                                  PollTile(poll: polls[index]));
                          polls.removeAt(index);
                        },
                      ),
              );
            })
        : NoPolls(text: Provider.of<String>(context));
  }
}

class NoPolls extends StatelessWidget {
  final String text;

  NoPolls({this.text});

  @override
  Widget build(BuildContext context) {
    final _headline4 = Theme.of(context).textTheme.headline4;
    final _random = Random();
    const _emojis = [
      "¯\\_(ツ)_/¯",
      "⚆ _ ⚆",
      "◔̯◔",
      "(╯°□°)╯",
      "ԅ། – . – །ᕗ",
      "ᕙ(⇀ _ ↼)ᕗ",
      "( ͡° ͜ʖ ͡°)",
    ];

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            text,
            style: _headline4.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            _emojis[_random.nextInt(_emojis.length)],
            style: _headline4.copyWith(
              fontSize: 18,
              fontFamily: GoogleFonts.notoSans().fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}

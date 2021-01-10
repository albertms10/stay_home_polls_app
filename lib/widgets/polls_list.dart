import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/model/user.dart';
import 'package:stay_home_polls_app/widgets/poll_tile.dart';

class PollsList extends StatefulWidget {
  final List<Poll> polls;

  const PollsList({this.polls});

  @override
  _PollsListState createState() => _PollsListState();
}

class _PollsListState extends State<PollsList> {
  GlobalKey<AnimatedListState> _listKey;
  List<Poll> _polls;

  @override
  void initState() {
    super.initState();

    _listKey = GlobalKey<AnimatedListState>();
    _polls = widget.polls;
  }

  bool shouldDismiss(Poll poll) => !poll.isAuth && poll.voteValue == null;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (widget.polls.isEmpty) {
      return NoPolls(text: Provider.of<String>(context));
    }

    return AnimatedList(
      key: _listKey,
      initialItemCount: _polls.length,
      itemBuilder: (context, index, animation) {
        final poll = _polls[index];

        final container = Container(
          child: PollTile(poll: poll),
          margin: index == _polls.length - 1
              ? const EdgeInsets.only(bottom: 50.0)
              : null,
        );

        return SlideTransition(
          key: ValueKey(poll.id),
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(0.0, 0.0),
              end: const Offset(0.0, 0.0),
            ),
          ),
          child: shouldDismiss(poll)
              ? Dismissible(
                  key: Key(poll.id),
                  child: container,
                  onDismissed: (direction) {
                    user.dismiss(poll);
                    _listKey.currentState.removeItem(
                      index,
                      (context, animation) => const SizedBox(),
                    );
                    _polls.removeAt(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Dismissed')),
                    );
                  },
                )
              : container,
        );
      },
    );
  }
}

class NoPolls extends StatelessWidget {
  final String text;

  const NoPolls({this.text});

  @override
  Widget build(BuildContext context) {
    final headline4 = Theme.of(context).textTheme.headline4;

    const emojis = [
      '¯\\_(ツ)_/¯',
      '⚆ _ ⚆',
      '◔̯◔',
      '(╯°□°)╯',
      'ԅ། – . – །ᕗ',
      'ᕙ(⇀ _ ↼)ᕗ',
      '( ͡° ͜ʖ ͡°)',
    ];

    final nextEmojiIndex = Random().nextInt(emojis.length);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: headline4.copyWith(fontSize: 24.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),
          Text(
            emojis[nextEmojiIndex],
            style: headline4.copyWith(
              fontSize: 18.0,
              fontFamily: GoogleFonts.notoSans().fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}

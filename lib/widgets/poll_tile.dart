import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/widgets/choice_poll_action.dart';
import 'package:stay_home_polls_app/widgets/slider_poll_action.dart';

class PollTile extends StatelessWidget {
  final Poll poll;

  const PollTile({Key key, @required this.poll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              poll.title,
              style: const TextStyle(fontSize: 16.0),
            ),
            if (poll is SliderPoll)
              SliderPollAction(sliderPoll: poll)
            else if (poll is ChoicePoll)
              ChoicePollAction(choicePoll: poll),
          ],
        ),
      ),
    );
  }
}

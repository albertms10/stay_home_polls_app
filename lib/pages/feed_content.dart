import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/pages/page_content.dart';
import 'package:stay_home_polls_app/widgets/polls_container.dart';

class FeedContent extends StatelessWidget {
  List<Poll> _filterCallback(List<Poll> pollsList, List<Poll> userPollsList) {
    return pollsList.where((poll) {
      final userPoll = userPollsList.firstWhere(
          (userPoll) => userPoll != null ? poll.id == userPoll.id : false,
          orElse: () => null);

      if (userPoll == null) return true;

      poll.voteValue = userPoll.voteValue;
      poll.isAuth = userPoll.isAuth;

      if (!userPoll.finished) return true;
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PageContent(
      tabs: [
        Tab(text: "POPULAR"),
        Tab(text: "LATEST"),
      ],
      emptyMessage: 'You ran out of polls',
      children: [
        PollsContainer(
          streamPollsList: popularPollListSnapshots(),
          filterCallback: _filterCallback,
        ),
        PollsContainer(
          streamPollsList: latestPollListSnapshots(),
          filterCallback: _filterCallback,
        ),
      ],
    );
  }
}

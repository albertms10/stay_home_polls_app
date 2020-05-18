import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/pages/page_content.dart';
import 'package:stay_home_polls_app/widgets/polls_container.dart';

class FeedContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _filterCallback(List<Poll> pollsList, List<Poll> userPollsList) {
      return pollsList.where((poll) {
        final userPoll = userPollsList.firstWhere(
            (userPoll) => userPoll != null ? poll.id == userPoll.id : false,
            orElse: () {});
        return userPoll == null ? true : false;
      }).toList();
    }

    return PageContent(
      tabs: [
        Tab(text: "POPULAR"),
        Tab(text: "LATEST"),
      ],
      children: [
        PollsContainer(
          streamPollsList: popularPollListSnapshots(),
          filterCallback: _filterCallback,
          emptyMessage: 'You ran out of polls',
        ),
        PollsContainer(
          streamPollsList: latestPollListSnapshots(),
          filterCallback: _filterCallback,
          emptyMessage: 'You ran out of polls',
        ),
      ],
    );
  }
}

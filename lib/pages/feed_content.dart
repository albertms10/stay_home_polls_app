import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/pages/page_content.dart';
import 'package:stay_home_polls_app/widgets/polls_container.dart';
import 'package:stay_home_polls_app/model/poll.dart';

class FeedContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContent(
      tabs: [
        Tab(text: "POPULAR"),
        Tab(text: "LATEST"),
      ],
      children: [
        PollsContainer(
          streamPollsList: popularPollListSnapshots(),
          filterCallback: (pollsList, userPollsList) => pollsList.where((poll) {
            final userPoll = userPollsList.firstWhere(
                (userPoll) => userPoll != null ? poll.id == userPoll.id : false,
                orElse: () {});
            return userPoll == null ? true : false;
          }).toList(),
          emptyMessage: 'You ran out of polls',
        ),
        PollsContainer(
          streamPollsList: latestPollListSnapshots(),
          filterCallback: (pollsList, userPollsList) => pollsList.where((poll) {
            final userPoll = userPollsList.firstWhere(
                (userPoll) => userPoll != null ? poll.id == userPoll.id : false,
                orElse: () {});
            return userPoll == null ? true : false;
          }).toList(),
          emptyMessage: 'You ran out of polls',
        ),
      ],
    );
  }
}

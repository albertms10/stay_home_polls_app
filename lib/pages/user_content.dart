import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/pages/page_content.dart';
import 'package:stay_home_polls_app/widgets/polls_container.dart';

class UserContent extends StatelessWidget {
  List<Poll> _filterCallback(List<Poll> pollsList, List<Poll> userPollsList,
      Function(Poll, Poll) check) {
    return pollsList.where((poll) {
      final userPoll = userPollsList.firstWhere(
          (userPoll) => userPoll != null ? check(poll, userPoll) : false,
          orElse: () => null);

      if (userPoll == null) return false;
      poll.voteValue = userPoll.voteValue;
      poll.isAuth = userPoll.isAuth;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PageContent(
      tabs: [
        Tab(text: "POSTED"),
        Tab(text: "VOTED"),
      ],
      emptyMessage: 'No polls yet',
      children: [
        PollsContainer(
          streamPollsList: popularPollListSnapshots(),
          filterCallback: (pollsList, userPollsList) => _filterCallback(
            pollsList,
            userPollsList,
            (poll, userPoll) => poll.id == userPoll.id && userPoll.isAuth,
          ),
        ),
        PollsContainer(
          streamPollsList: popularPollListSnapshots(),
          filterCallback: (pollsList, userPollsList) => _filterCallback(
            pollsList,
            userPollsList,
            (poll, userPoll) => poll.id == userPoll.id && !userPoll.isAuth,
          ),
        ),
      ],
    );
  }
}

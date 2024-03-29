import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/pages/page_content.dart';
import 'package:stay_home_polls_app/widgets/polls_container.dart';

class FeedContent<T extends Poll> extends StatelessWidget {
  const FeedContent({Key key}) : super(key: key);

  List<T> _filterCallback(List<T> pollsList, List<T> userPollsList) {
    return pollsList.where((poll) {
      final userPoll = userPollsList.firstWhere(
        (userPoll) => userPoll != null && poll.id == userPoll.id,
        orElse: () => null,
      );

      if (userPoll == null) return true;

      poll
        ..voteValue = userPoll.voteValue
        ..isAuth = userPoll.isAuth;

      if (!userPoll.finished) return true;

      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PageContent(
      tabs: const [
        Tab(text: 'POPULAR'),
        Tab(text: 'LATEST'),
      ],
      emptyMessage: 'You ran out of polls',
      children: [
        PollsContainer<T>(
          streamPollsList: popularPollListSnapshots(),
          filterCallback: _filterCallback,
        ),
        PollsContainer<T>(
          streamPollsList: latestPollListSnapshots(),
          filterCallback: _filterCallback,
        ),
      ],
    );
  }
}

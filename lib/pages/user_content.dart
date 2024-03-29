import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/pages/page_content.dart';
import 'package:stay_home_polls_app/widgets/polls_container.dart';

class UserContent<T extends Poll> extends StatelessWidget {
  const UserContent({Key key}) : super(key: key);

  List<T> _filterCallback(
    List<T> pollsList,
    List<T> userPollsList,
    bool Function(T, T) check,
  ) {
    return pollsList.where((poll) {
      final userPoll = userPollsList.firstWhere(
        (userPoll) => userPoll != null && check(poll, userPoll),
        orElse: () => null,
      );

      if (userPoll == null) return false;

      poll
        ..voteValue = userPoll.voteValue
        ..isAuth = userPoll.isAuth;

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PageContent(
      tabs: const [
        Tab(text: 'POSTED'),
        Tab(text: 'VOTED'),
      ],
      emptyMessage: 'No polls yet',
      children: [
        PollsContainer<T>(
          streamPollsList: popularPollListSnapshots(),
          filterCallback: (pollsList, userPollsList) => _filterCallback(
            pollsList,
            userPollsList,
            (poll, userPoll) => poll.id == userPoll.id && userPoll.isAuth,
          ),
        ),
        PollsContainer<T>(
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

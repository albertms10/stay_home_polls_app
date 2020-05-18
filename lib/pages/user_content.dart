import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/model/poll.dart';
import 'package:stay_home_polls_app/pages/page_content.dart';
import 'package:stay_home_polls_app/widgets/polls_container.dart';

class UserContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContent(
      tabs: [
        Tab(text: "POSTED"),
        Tab(text: "VOTED"),
      ],
      children: [
        PollsContainer(
          streamPollsList: popularPollListSnapshots(),
          filterCallback: (pollsList, userPollsList) => pollsList.where((poll) {
            final userPoll = userPollsList.firstWhere(
                (userPoll) => userPoll != null
                    ? poll.id == userPoll.id && userPoll.isAuth
                    : false,
                orElse: () {});
            return userPoll == null ? false : true;
          }).toList(),
        ),
        PollsContainer(
          streamPollsList: popularPollListSnapshots(),
          filterCallback: (pollsList, userPollsList) => pollsList.where((poll) {
            final userPoll = userPollsList.firstWhere(
                (userPoll) => userPoll != null ? poll.id == userPoll.id : false,
                orElse: () {});
            return userPoll == null ? false : true;
          }).toList(),
        ),
      ],
    );
  }
}

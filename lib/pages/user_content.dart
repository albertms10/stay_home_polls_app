import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_home_polls_app/model/user.dart';
import 'package:stay_home_polls_app/widgets/polls_container.dart';

class UserContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            height: 50.0,
            child: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Theme.of(context).primaryColor,
              tabs: [
                Tab(text: "POSTED"),
                Tab(text: "VOTED"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            PollsContainer(
              streamPollsList: user.pollsSnapshots(),
              filterCallback: (pollsList, userPollsList) =>
                  pollsList.where((poll) {
                final userPoll = userPollsList.firstWhere(
                    (userPoll) =>
                        userPoll != null ? poll.id == userPoll.id : false,
                    orElse: () {});
                return userPoll == null ? false : true;
              }).toList(),
            ),
            PollsContainer(
              streamPollsList: user.pollsSnapshots(),
            ),
          ],
        ),
      ),
    );
  }
}

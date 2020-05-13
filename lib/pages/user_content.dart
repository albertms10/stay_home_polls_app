import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/widgets/polls_container.dart';
import 'package:stay_home_polls_app/model/user.dart';

class UserContent extends StatelessWidget {
  final user = User(id: 'Ap8s7eym7sY32CnuGIgM', displayName: 'Albert');

  @override
  Widget build(BuildContext context) {
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
          children: [
            PollsContainer(
              streamPollsList: user.pollsSnapshots(),
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

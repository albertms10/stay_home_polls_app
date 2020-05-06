import 'package:flutter/material.dart';
import 'package:stay_home_polls_app/widgets/polls_container.dart';
import 'package:stay_home_polls_app/model/poll.dart';

class FeedContent extends StatelessWidget {
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
                Tab(text: "POPULAR"),
                Tab(text: "LATEST"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            PollsContainer(popularPollListSnapshots()),
            PollsContainer(latestPollListSnapshots()),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class UserContent extends StatelessWidget {
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
            Placeholder(),
            Placeholder(),
          ],
        ),
      ),
    );
  }
}
